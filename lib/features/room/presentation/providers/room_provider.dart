import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/network/websocket_service.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/room.dart';
import '../../../chat/domain/entities/chat_message.dart';
import '../../data/datasources/room_remote_datasource.dart';
import '../../../../core/di/providers.dart';

enum RoomStatus { idle, connecting, connected, error, disconnected }

class RoomStateData {
  final Room? room;
  final List<User> users;
  final RoomStatus status;
  final String? error;
  final String? currentUserId;
  final bool isHost;
  final int ping;
  final WsConnectionState wsState;
  
  const RoomStateData({
    this.room,
    this.users = const [],
    this.status = RoomStatus.idle,
    this.error,
    this.currentUserId,
    this.isHost = false,
    this.ping = 0,
    this.wsState = WsConnectionState.disconnected,
  });
  
  RoomStateData copyWith({
    Room? room,
    List<User>? users,
    RoomStatus? status,
    String? error,
    String? currentUserId,
    bool? isHost,
    int? ping,
    WsConnectionState? wsState,
  }) => RoomStateData(
    room: room ?? this.room,
    users: users ?? this.users,
    status: status ?? this.status,
    error: error ?? this.error,
    currentUserId: currentUserId ?? this.currentUserId,
    isHost: isHost ?? this.isHost,
    ping: ping ?? this.ping,
    wsState: wsState ?? this.wsState,
  );
}

class RoomNotifier extends StateNotifier<RoomStateData> {
  final RoomRemoteDataSource _dataSource;
  StreamSubscription? _messageSub;
  StreamSubscription? _wsStateSub;
  
  RoomNotifier(this._dataSource) : super(const RoomStateData());
  
  Future<String> createRoom({required String roomName, required String userName, bool isMusicMode = false}) async {
    final userId = LocalStorage.getUserId() ?? const Uuid().v4();
    if (LocalStorage.getUserId() == null) {
      await LocalStorage.setUserId(userId);
    }
    await LocalStorage.setUserName(userName);
    
    final roomId = _generateRoomId();
    final room = Room(
      id: roomId,
      name: roomName,
      hostId: userId,
      createdAt: DateTime.now(),
      participantIds: [userId],
      isMusicMode: isMusicMode,
      allowAllControl: true,
    );
    
    state = state.copyWith(room: room, currentUserId: userId, isHost: true, status: RoomStatus.connecting);
    
    try {
      await _dataSource.connectToRoom(roomId: roomId, userId: userId, userName: userName);
      _listen();
      state = state.copyWith(status: RoomStatus.connected);
      await LocalStorage.addRecentRoom(roomId);
      AppLogger.info('Room created: $roomId');
      return roomId;
    } catch (e) {
      state = state.copyWith(status: RoomStatus.error, error: e.toString());
      rethrow;
    }
  }
  
  Future<void> joinRoom({required String roomId, required String userName}) async {
    final userId = LocalStorage.getUserId() ?? const Uuid().v4();
    if (LocalStorage.getUserId() == null) {
      await LocalStorage.setUserId(userId);
    }
    await LocalStorage.setUserName(userName);
    
    state = state.copyWith(currentUserId: userId, status: RoomStatus.connecting, isHost: false);
    
    try {
      await _dataSource.connectToRoom(roomId: roomId, userId: userId, userName: userName);
      _listen();
      state = state.copyWith(status: RoomStatus.connected);
      await LocalStorage.addRecentRoom(roomId);
      AppLogger.info('Joined room: $roomId');
    } catch (e) {
      state = state.copyWith(status: RoomStatus.error, error: e.toString());
      rethrow;
    }
  }
  
  void _listen() {
    _messageSub?.cancel();
    _wsStateSub?.cancel();
    
    _messageSub = _dataSource.messages.listen((msg) {
      final type = msg['type'] as String?;
      AppLogger.debug('Room msg: $type');
      
      switch (type) {
        case 'room_state':
          _handleRoomState(msg);
          break;
        case 'user_joined':
          _handleUserJoined(msg);
          break;
        case 'user_left':
          _handleUserLeft(msg);
          break;
        case 'host_transfer':
          _handleHostTransfer(msg);
          break;
        case 'pong':
          if (msg['rtt'] != null) {
            state = state.copyWith(ping: msg['rtt'] as int);
          }
          break;
      }
    });
    
    _wsStateSub = _dataSource.connectionState.listen((wsState) {
      state = state.copyWith(wsState: wsState);
      if (wsState == WsConnectionState.disconnected) {
        state = state.copyWith(status: RoomStatus.disconnected);
      } else if (wsState == WsConnectionState.connected) {
        state = state.copyWith(status: RoomStatus.connected);
      }
    });
  }
  
  void _handleRoomState(Map<String, dynamic> msg) {
    try {
      final roomJson = msg['room'] as Map<String, dynamic>?;
      final usersJson = msg['users'] as List?;
      
      if (roomJson != null) {
        final room = Room(
          id: roomJson['id'] as String,
          name: roomJson['name'] as String? ?? 'Room',
          hostId: roomJson['hostId'] as String,
          createdAt: DateTime.now(),
          participantIds: (roomJson['participantIds'] as List?)?.cast<String>() ?? [],
          allowAllControl: roomJson['allowAllControl'] as bool? ?? true,
          isMusicMode: roomJson['isMusicMode'] as bool? ?? false,
        );
        final isHost = room.hostId == state.currentUserId;
        state = state.copyWith(room: room, isHost: isHost);
      }
      
      if (usersJson != null) {
        final users = usersJson.map((u) {
          final m = u as Map<String, dynamic>;
          return User(
            id: m['id'] as String,
            name: m['name'] as String? ?? 'Anonymous',
            isHost: m['isHost'] as bool? ?? false,
            status: UserStatus.online,
            pingMs: m['pingMs'] as int? ?? 0,
          );
        }).toList();
        state = state.copyWith(users: users);
      }
    } catch (e) {
      AppLogger.error('Failed to parse room_state', error: e);
    }
  }
  
  void _handleUserJoined(Map<String, dynamic> msg) {
    final userJson = msg['user'] as Map<String, dynamic>?;
    if (userJson == null) return;
    final user = User(
      id: userJson['id'] as String,
      name: userJson['name'] as String? ?? 'Anonymous',
      isHost: userJson['isHost'] as bool? ?? false,
    );
    if (!state.users.any((u) => u.id == user.id)) {
      state = state.copyWith(users: [...state.users, user]);
    }
  }
  
  void _handleUserLeft(Map<String, dynamic> msg) {
    final userId = msg['userId'] as String?;
    if (userId == null) return;
    state = state.copyWith(users: state.users.where((u) => u.id != userId).toList());
  }
  
  void _handleHostTransfer(Map<String, dynamic> msg) {
    final newHostId = msg['newHostId'] as String?;
    if (newHostId == null || state.room == null) return;
    final isNowHost = newHostId == state.currentUserId;
    state = state.copyWith(
      room: state.room!.copyWith(hostId: newHostId),
      isHost: isNowHost,
      users: state.users.map((u) => u.copyWith(isHost: u.id == newHostId)).toList(),
    );
  }
  
  void transferHost(String newHostId) {
    if (!state.isHost) return;
    _dataSource.send({
      'type': 'host_transfer',
      'roomId': state.room?.id,
      'newHostId': newHostId,
      'userId': state.currentUserId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
  
  void toggleAllowAllControl(bool value) {
    if (!state.isHost) return;
    _dataSource.send({
      'type': 'permission_change',
      'roomId': state.room?.id,
      'allowAllControl': value,
      'userId': state.currentUserId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
    if (state.room != null) {
      state = state.copyWith(room: state.room!.copyWith(allowAllControl: value));
    }
  }
  
  Future<void> leaveRoom() async {
    try {
      _dataSource.send({
        'type': 'leave',
        'roomId': state.room?.id,
        'userId': state.currentUserId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (_) {}
    await _dataSource.disconnect();
    await _messageSub?.cancel();
    await _wsStateSub?.cancel();
    state = const RoomStateData();
  }
  
  String _generateRoomId() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rnd = DateTime.now().millisecondsSinceEpoch;
    final sb = StringBuffer();
    var n = rnd;
    for (int i=0;i<6;i++) {
      sb.write(chars[n % chars.length]);
      n ~/= chars.length + 1;
      if (n == 0) n = DateTime.now().microsecondsSinceEpoch + i*1013;
    }
    return sb.toString();
  }
  
  @override
  void dispose() {
    _messageSub?.cancel();
    _wsStateSub?.cancel();
    super.dispose();
  }
}

final roomProvider = StateNotifierProvider<RoomNotifier, RoomStateData>((ref) {
  final ds = ref.watch(roomDataSourceProvider);
  return RoomNotifier(ds);
});
