import 'dart:async';
import 'dart:math';
import '../domain/entities/sync_event.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';

class SyncEngine {
  final void Function(SyncEvent event) _sendEvent;
  final Future<void> Function(Duration pos, bool isPlaying, double speed) _applyState;
  
  SyncEngine({
    required void Function(SyncEvent) sendEvent,
    required Future<void> Function(Duration, bool, double) applyState,
  })  : _sendEvent = sendEvent,
        _applyState = applyState;

  Timer? _syncTimer;
  Timer? _driftCheckTimer;
  
  PlaybackState _localState = const PlaybackState();
  PlaybackState _remoteState = const PlaybackState();
  bool _isHost = false;
  String? _roomId;
  String? _userId;
  
  SyncMetrics _metrics = const SyncMetrics();
  final _metricsController = StreamController<SyncMetrics>.broadcast();
  Stream<SyncMetrics> get metricsStream => _metricsController.stream;
  
  bool _isSyncing = false;
  int _lastRemoteTimestamp = 0;
  
  void init({required String roomId, required String userId, required bool isHost}) {
    _roomId = roomId;
    _userId = userId;
    _isHost = isHost;
    AppLogger.info('SyncEngine init: room=$roomId user=$userId isHost=$isHost');
    
    _startSyncLoop();
    _startDriftCorrection();
  }
  
  void updateLocalState(PlaybackState state) {
    _localState = state;
  }
  
  void handleRemoteEvent(SyncEvent event) {
    // Ignore own events
    if (event.userId == _userId) return;
    
    // Calculate network delay for drift correction
    final now = DateTime.now().millisecondsSinceEpoch;
    final networkDelay = max(0, now - event.timestamp);
    final positionWithDelay = (event.positionMs ?? 0) + (event.isPlaying == true ? networkDelay * (event.speed ?? 1.0) : 0);
    
    _remoteState = PlaybackState(
      isPlaying: event.isPlaying ?? _remoteState.isPlaying,
      positionMs: positionWithDelay,
      speed: event.speed ?? _remoteState.speed,
      lastUpdateTimestamp: event.timestamp,
    );
    
    _lastRemoteTimestamp = event.timestamp;
    
    if (event.type == SyncEventType.ping || event.type == SyncEventType.pong) return;
    
    AppLogger.info('Handle remote event ${event.type} pos=${event.positionMs} playing=${event.isPlaying}');
    
    // Apply immediately if sync event
    if (event.isPlaybackEvent) {
      _applyWithDriftCorrection(event);
    }
    
    // Update metrics
    if (event.metadata?['rtt'] != null) {
      final rtt = event.metadata!['rtt'] as int;
      _updateMetrics(rtt: rtt);
    }
  }
  
  Future<void> _applyWithDriftCorrection(SyncEvent event) async {
    if (_isSyncing) return;
    _isSyncing = true;
    
    try {
      final targetPos = Duration(milliseconds: (event.positionMs ?? 0).toInt());
      final shouldPlay = event.isPlaying ?? false;
      final speed = event.speed ?? 1.0;
      
      await _applyState(targetPos, shouldPlay, speed);
      AppLogger.info('Applied remote state: pos=$targetPos playing=$shouldPlay speed=$speed');
    } catch (e) {
      AppLogger.error('Failed to apply remote state', error: e);
    } finally {
      _isSyncing = false;
    }
  }
  
  void sendPlay(Duration position, {double speed = 1.0}) {
    if (_roomId == null || _userId == null) return;
    final event = SyncEvent(
      type: SyncEventType.play,
      roomId: _roomId!,
      userId: _userId!,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      positionMs: position.inMilliseconds.toDouble(),
      isPlaying: true,
      speed: speed,
    );
    _sendEvent(event);
    AppLogger.info('Sent PLAY event at $position');
  }
  
  void sendPause(Duration position) {
    if (_roomId == null || _userId == null) return;
    final event = SyncEvent(
      type: SyncEventType.pause,
      roomId: _roomId!,
      userId: _userId!,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      positionMs: position.inMilliseconds.toDouble(),
      isPlaying: false,
    );
    _sendEvent(event);
    AppLogger.info('Sent PAUSE event at $position');
  }
  
  void sendSeek(Duration position, {bool isPlaying = false}) {
    if (_roomId == null || _userId == null) return;
    final event = SyncEvent(
      type: SyncEventType.seek,
      roomId: _roomId!,
      userId: _userId!,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      positionMs: position.inMilliseconds.toDouble(),
      isPlaying: isPlaying,
    );
    _sendEvent(event);
    AppLogger.info('Sent SEEK event to $position playing=$isPlaying');
  }
  
  void sendSpeed(double speed, Duration position) {
    if (_roomId == null || _userId == null) return;
    final event = SyncEvent(
      type: SyncEventType.speed,
      roomId: _roomId!,
      userId: _userId!,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      positionMs: position.inMilliseconds.toDouble(),
      isPlaying: _localState.isPlaying,
      speed: speed,
    );
    _sendEvent(event);
  }
  
  void _startSyncLoop() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(AppConstants.syncInterval, (_) {
      if (_isHost && _localState.isPlaying) {
        // Host broadcasts current position periodically for drift correction
        // But not too frequently to save bandwidth
      }
    });
  }
  
  void _startDriftCorrection() {
    _driftCheckTimer?.cancel();
    _driftCheckTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _checkDrift();
    });
  }
  
  void _checkDrift() {
    if (_localState.isPlaying == false || _remoteState.isPlaying == false) return;
    if (_isSyncing) return;
    
    final drift = (_localState.positionMs - _remoteState.positionMs).abs();
    final threshold = AppConstants.maxDriftThreshold.inMilliseconds;
    
    _metrics = _metrics.copyWith(driftMs: drift);
    _metricsController.add(_metrics);
    
    if (drift > threshold) {
      AppLogger.info('Drift detected: ${drift}ms > ${threshold}ms, correcting');
      // Auto correct if not host or if host allows
      _applyState(
        Duration(milliseconds: _remoteState.positionMs.toInt()),
        _remoteState.isPlaying,
        _remoteState.speed,
      );
    }
  }
  
  void _updateMetrics({required int rtt}) {
    SyncQuality quality;
    if (rtt < 50) quality = SyncQuality.excellent;
    else if (rtt < 150) quality = SyncQuality.good;
    else if (rtt < 300) quality = SyncQuality.fair;
    else quality = SyncQuality.poor;
    
    _metrics = _metrics.copyWith(
      rttMs: rtt,
      lastSync: DateTime.now(),
      quality: quality,
      syncCount: _metrics.syncCount + 1,
    );
    _metricsController.add(_metrics);
  }
  
  void dispose() {
    _syncTimer?.cancel();
    _driftCheckTimer?.cancel();
    _metricsController.close();
  }
}
