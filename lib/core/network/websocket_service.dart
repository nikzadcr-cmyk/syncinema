import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/logger.dart';
import '../constants/api_constants.dart';
import '../constants/app_constants.dart';

enum WsConnectionState { disconnected, connecting, connected, reconnecting, failed }

class WebSocketService {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();
  final _stateController = StreamController<WsConnectionState>.broadcast();
  
  Stream<Map<String, dynamic>> get messages => _messageController.stream;
  Stream<WsConnectionState> get connectionState => _stateController.stream;
  
  WsConnectionState _currentState = WsConnectionState.disconnected;
  WsConnectionState get currentState => _currentState;
  
  String? _currentRoomId;
  String? _userId;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  bool _shouldReconnect = true;
  
  // For heartbeat RTT
  final Map<String, DateTime> _pingTimes = {};
  
  void _setState(WsConnectionState state) {
    _currentState = state;
    _stateController.add(state);
    AppLogger.info('WS State changed: $state');
  }
  
  Future<void> connect({
    required String roomId,
    required String userId,
    String? userName,
  }) async {
    if (_currentState == WsConnectionState.connected && _currentRoomId == roomId) {
      AppLogger.info('Already connected to room $roomId');
      return;
    }
    
    await disconnect();
    _shouldReconnect = true;
    _currentRoomId = roomId;
    _userId = userId;
    _reconnectAttempts = 0;
    
    _setState(WsConnectionState.connecting);
    
    try {
      final url = EnvConfig.wsBase + '/room/$roomId/websocket?userId=$userId&userName=${Uri.encodeComponent(userName ?? 'Anonymous')}';
      AppLogger.info('Connecting to WebSocket: $url');
      
      _channel = WebSocketChannel.connect(Uri.parse(url));
      await _channel!.ready;
      
      _setState(WsConnectionState.connected);
      _reconnectAttempts = 0;
      
      // Listen
      _subscription = _channel!.stream.listen(
        _onMessage,
        onDone: _onDone,
        onError: _onError,
        cancelOnError: false,
      );
      
      _startHeartbeat();
      
      // Send join event
      send({
        'type': 'join',
        'userId': userId,
        'userName': userName,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      
    } catch (e, stack) {
      AppLogger.error('WS connect failed', error: e, stack: stack);
      _setState(WsConnectionState.failed);
      _scheduleReconnect();
    }
  }
  
  void _onMessage(dynamic data) {
    try {
      final Map<String, dynamic> message;
      if (data is String) {
        message = jsonDecode(data) as Map<String, dynamic>;
      } else if (data is List<int>) {
        message = jsonDecode(utf8.decode(data)) as Map<String, dynamic>;
      } else {
        message = data as Map<String, dynamic>;
      }
      
      // Handle pong internally to calculate latency
      if (message['type'] == 'pong') {
        final pingId = message['pingId'] as String?;
        if (pingId != null && _pingTimes.containsKey(pingId)) {
          final sent = _pingTimes.remove(pingId);
          if (sent != null) {
            final rtt = DateTime.now().difference(sent).inMilliseconds;
            message['rtt'] = rtt;
          }
        }
      }
      
      _messageController.add(message);
    } catch (e) {
      AppLogger.error('Failed to parse WS message: $data', error: e);
    }
  }
  
  void _onDone() {
    AppLogger.info('WS connection closed');
    _stopHeartbeat();
    if (_shouldReconnect && _currentState != WsConnectionState.disconnected) {
      _scheduleReconnect();
    } else {
      _setState(WsConnectionState.disconnected);
    }
  }
  
  void _onError(Object error) {
    AppLogger.error('WS error', error: error);
    if (_shouldReconnect) {
      _scheduleReconnect();
    }
  }
  
  void _scheduleReconnect() {
    if (!_shouldReconnect) return;
    if (_reconnectAttempts >= AppConstants.maxReconnectAttempts) {
      AppLogger.warning('Max reconnect attempts reached');
      _setState(WsConnectionState.failed);
      return;
    }
    
    _setState(WsConnectionState.reconnecting);
    _reconnectAttempts++;
    final delay = Duration(seconds: _reconnectAttempts * 2);
    AppLogger.info('Scheduling reconnect attempt $_reconnectAttempts in ${delay.inSeconds}s');
    
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (_currentRoomId != null && _userId != null) {
        connect(roomId: _currentRoomId!, userId: _userId!);
      }
    });
  }
  
  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(AppConstants.heartbeatInterval, (_) {
      final pingId = DateTime.now().millisecondsSinceEpoch.toString();
      _pingTimes[pingId] = DateTime.now();
      // Cleanup old pings
      if (_pingTimes.length > 10) {
        final oldest = _pingTimes.keys.first;
        _pingTimes.remove(oldest);
      }
      send({
        'type': 'ping',
        'pingId': pingId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    });
  }
  
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }
  
  void send(Map<String, dynamic> message) {
    if (_channel == null || _currentState != WsConnectionState.connected) {
      AppLogger.warning('Cannot send, not connected: $message');
      return;
    }
    try {
      final encoded = jsonEncode(message);
      _channel!.sink.add(encoded);
      AppLogger.debug('WS Send: ${message['type']}');
    } catch (e) {
      AppLogger.error('WS send failed', error: e);
    }
  }
  
  Future<void> disconnect() async {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _stopHeartbeat();
    _pingTimes.clear();
    
    try {
      await _subscription?.cancel();
    } catch (_) {}
    _subscription = null;
    
    try {
      await _channel?.sink.close();
    } catch (_) {}
    _channel = null;
    
    if (_currentState != WsConnectionState.disconnected) {
      _setState(WsConnectionState.disconnected);
    }
    _currentRoomId = null;
  }
  
  void dispose() {
    disconnect();
    _messageController.close();
    _stateController.close();
  }
}
