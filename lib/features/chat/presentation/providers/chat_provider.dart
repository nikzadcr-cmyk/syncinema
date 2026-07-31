import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/chat_message.dart';
import '../../../room/data/datasources/room_remote_datasource.dart';
import '../../../room/presentation/providers/room_provider.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/di/providers.dart';

class ChatState {
  final List<ChatMessage> messages;
  final Map<String, bool> typingUsers; // userId -> isTyping
  final bool isLoading;
  const ChatState({this.messages = const [], this.typingUsers = const {}, this.isLoading = false});

  ChatState copyWith({List<ChatMessage>? messages, Map<String, bool>? typingUsers, bool? isLoading}) =>
      ChatState(messages: messages ?? this.messages, typingUsers: typingUsers ?? this.typingUsers, isLoading: isLoading ?? this.isLoading);
}

class ChatNotifier extends StateNotifier<ChatState> {
  final RoomRemoteDataSource _ds;
  final Ref _ref;
  StreamSubscription? _sub;
  Timer? _typingTimer;

  ChatNotifier(this._ds, this._ref) : super(const ChatState()) {
    _listen();
  }

  void _listen() {
    _sub = _ds.messages.listen((msg) {
      final type = msg['type'] as String?;
      if (type == 'chat_message') {
        try {
          final m = ChatMessage(
            id: msg['id'] as String? ?? const Uuid().v4(),
            roomId: msg['roomId'] as String,
            userId: msg['userId'] as String,
            userName: msg['userName'] as String? ?? 'User',
            content: msg['content'] as String,
            type: _parseType(msg['messageType'] as String?),
            timestamp: msg['timestamp'] as int? ?? DateTime.now().millisecondsSinceEpoch,
          );
          state = state.copyWith(messages: [...state.messages, m]);
        } catch (e) {
          AppLogger.error('parse chat msg failed', error: e);
        }
      } else if (type == 'typing') {
        final userId = msg['userId'] as String?;
        final isTyping = msg['isTyping'] as bool? ?? false;
        final userName = msg['userName'] as String? ?? '';
        if (userId != null) {
          final currentUserId = _ref.read(roomProvider).currentUserId;
          if (userId == currentUserId) return; // ignore self
          final newMap = Map<String, bool>.from(state.typingUsers);
          if (isTyping) {
            newMap[userId] = true;
          } else {
            newMap.remove(userId);
          }
          state = state.copyWith(typingUsers: newMap);
        }
      }
    });
  }

  MessageType _parseType(String? s) {
    switch (s) {
      case 'emoji': return MessageType.emoji;
      case 'reaction': return MessageType.reaction;
      case 'system': return MessageType.system;
      default: return MessageType.text;
    }
  }

  void sendMessage(String content, {MessageType type = MessageType.text}) {
    final room = _ref.read(roomProvider);
    if (room.room == null || room.currentUserId == null) return;
    final msg = {
      'type': 'chat_message',
      'id': const Uuid().v4(),
      'roomId': room.room!.id,
      'userId': room.currentUserId,
      'userName': room.users.firstWhere((u) => u.id == room.currentUserId, orElse: () => room.users.first).name,
      'content': content,
      'messageType': type.name,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    _ds.send(msg);
    // optimistic add
    final local = ChatMessage(
      id: msg['id'] as String,
      roomId: msg['roomId'] as String,
      userId: msg['userId'] as String,
      userName: msg['userName'] as String,
      content: content,
      type: type,
      timestamp: msg['timestamp'] as int,
    );
    state = state.copyWith(messages: [...state.messages, local]);
  }

  void sendTyping(bool isTyping) {
    final room = _ref.read(roomProvider);
    if (room.room == null || room.currentUserId == null) return;
    _ds.send({
      'type': 'typing',
      'roomId': room.room!.id,
      'userId': room.currentUserId,
      'userName': room.users.firstWhere((u) => u.id == room.currentUserId, orElse: () => room.users.first).name,
      'isTyping': isTyping,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
    _typingTimer?.cancel();
    if (isTyping) {
      _typingTimer = Timer(const Duration(seconds: 3), () => sendTyping(false));
    }
  }

  void sendReaction(String emoji) => sendMessage(emoji, type: MessageType.emoji);

  @override
  void dispose() {
    _sub?.cancel();
    _typingTimer?.cancel();
    super.dispose();
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final ds = ref.watch(roomDataSourceProvider);
  return ChatNotifier(ds, ref);
});
