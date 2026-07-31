import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/websocket_service.dart';
import '../../features/room/data/datasources/room_remote_datasource.dart';
import 'injection.dart';

final webSocketServiceProvider = Provider<WebSocketService>((ref) => sl<WebSocketService>());

final roomDataSourceProvider = Provider<RoomRemoteDataSource>((ref) {
  final ws = ref.watch(webSocketServiceProvider);
  return RoomRemoteDataSourceImpl(ws);
});
