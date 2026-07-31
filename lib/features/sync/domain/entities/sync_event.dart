import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_event.freezed.dart';
part 'sync_event.g.dart';

enum SyncEventType {
  play,
  pause,
  seek,
  speed,
  syncRequest,
  syncResponse,
  heartbeat,
  ping,
  pong,
  join,
  leave,
  hostTransfer,
  permissionChange,
  mediaChange,
}

@freezed
class SyncEvent with _$SyncEvent {
  const factory SyncEvent({
    required SyncEventType type,
    required String roomId,
    required String userId,
    required int timestamp,
    double? positionMs,
    double? speed,
    bool? isPlaying,
    String? targetUserId,
    Map<String, dynamic>? metadata,
  }) = _SyncEvent;

  factory SyncEvent.fromJson(Map<String, dynamic> json) => _$SyncEventFromJson(json);
}

extension SyncEventX on SyncEvent {
  bool get isPlaybackEvent => 
      type == SyncEventType.play || 
      type == SyncEventType.pause || 
      type == SyncEventType.seek ||
      type == SyncEventType.speed;
}

@freezed
class PlaybackState with _$PlaybackState {
  const factory PlaybackState({
    @Default(false) bool isPlaying,
    @Default(0) double positionMs,
    @Default(1.0) double speed,
    @Default(0) int lastUpdateTimestamp,
    String? mediaPath,
    @Default(false) bool isBuffering,
  }) = _PlaybackState;

  factory PlaybackState.fromJson(Map<String, dynamic> json) => _$PlaybackStateFromJson(json);
}

@freezed
class SyncMetrics with _$SyncMetrics {
  const factory SyncMetrics({
    @Default(0) int rttMs,
    @Default(0) double driftMs,
    @Default(0) int syncCount,
    DateTime? lastSync,
    @Default(SyncQuality.excellent) SyncQuality quality,
  }) = _SyncMetrics;

  factory SyncMetrics.fromJson(Map<String, dynamic> json) => _$SyncMetricsFromJson(json);
}

enum SyncQuality { excellent, good, fair, poor }
