import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String name,
    required String hostId,
    required DateTime createdAt,
    @Default([]) List<String> participantIds,
    @Default(true) bool allowAllControl,
    @Default(false) bool isMusicMode,
    String? currentMediaName,
    @Default(0) int currentMediaDurationMs,
    @Default(RoomState.waiting) RoomState state,
    String? inviteLink,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

enum RoomState {
  waiting,
  playing,
  paused,
  syncing,
}

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    String? avatar,
    @Default(false) bool isHost,
    @Default(UserStatus.online) UserStatus status,
    @Default(false) bool isTyping,
    String? currentFileName,
    DateTime? lastSeen,
    @Default(0) int pingMs,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

enum UserStatus {
  online,
  away,
  offline,
}

@freezed
class RoomSettings with _$RoomSettings {
  const factory RoomSettings({
    @Default(true) bool allowAllControl,
    @Default(true) bool enableChat,
    @Default(true) bool enableReactions,
    @Default(true) bool autoSync,
    @Default(150) int maxDriftMs,
  }) = _RoomSettings;

  factory RoomSettings.fromJson(Map<String, dynamic> json) => _$RoomSettingsFromJson(json);
}
