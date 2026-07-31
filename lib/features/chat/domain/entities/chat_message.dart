import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

enum MessageType { text, emoji, reaction, system, invite }

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String roomId,
    required String userId,
    required String userName,
    required String content,
    required MessageType type,
    required int timestamp,
    String? replyTo,
    String? avatar,
    @Default([]) List<String> reactions,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}

@freezed
class TypingIndicator with _$TypingIndicator {
  const factory TypingIndicator({
    required String userId,
    required String userName,
    required String roomId,
    required bool isTyping,
    required int timestamp,
  }) = _TypingIndicator;

  factory TypingIndicator.fromJson(Map<String, dynamic> json) => _$TypingIndicatorFromJson(json);
}
