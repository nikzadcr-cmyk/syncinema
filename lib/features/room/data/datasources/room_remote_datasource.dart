import 'dart:async';
import '../../../../core/network/websocket_service.dart';
import '../../../../core/utils/logger.dart';

abstract class RoomRemoteDataSource {
  Future<void> connectToRoom({required String roomId, required String userId, String? userName});
  Future<void> disconnect();
  Stream<Map<String, dynamic>> get messages;
  Stream<WsConnectionState> get connectionState;
  void send(Map<String, dynamic> data);
  WsConnectionState get currentState;
}

class RoomRemoteDataSourceImpl implements RoomRemoteDataSource {
  final WebSocketService _ws;
  RoomRemoteDataSourceImpl(this._ws);

  @override
  Future<void> connectToRoom({required String roomId, required String userId, String? userName}) {
    AppLogger.info('Connecting room DS: $roomId as $userId');
    return _ws.connect(roomId: roomId, userId: userId, userName: userName);
  }

  @override
  Future<void> disconnect() => _ws.disconnect();

  @override
  Stream<Map<String, dynamic>> get messages => _ws.messages;

  @override
  Stream<WsConnectionState> get connectionState => _ws.connectionState;

  @override
  void send(Map<String, dynamic> data) => _ws.send(data);

  @override
  WsConnectionState get currentState => _ws.currentState;
}
