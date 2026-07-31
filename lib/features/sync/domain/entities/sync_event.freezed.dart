// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncEvent _$SyncEventFromJson(Map<String, dynamic> json) {
  return _SyncEvent.fromJson(json);
}

/// @nodoc
mixin _$SyncEvent {
  SyncEventType get type => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  double? get positionMs => throw _privateConstructorUsedError;
  double? get speed => throw _privateConstructorUsedError;
  bool? get isPlaying => throw _privateConstructorUsedError;
  String? get targetUserId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this SyncEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncEventCopyWith<SyncEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncEventCopyWith<$Res> {
  factory $SyncEventCopyWith(SyncEvent value, $Res Function(SyncEvent) then) =
      _$SyncEventCopyWithImpl<$Res, SyncEvent>;
  @useResult
  $Res call(
      {SyncEventType type,
      String roomId,
      String userId,
      int timestamp,
      double? positionMs,
      double? speed,
      bool? isPlaying,
      String? targetUserId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$SyncEventCopyWithImpl<$Res, $Val extends SyncEvent>
    implements $SyncEventCopyWith<$Res> {
  _$SyncEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? roomId = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? positionMs = freezed,
    Object? speed = freezed,
    Object? isPlaying = freezed,
    Object? targetUserId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SyncEventType,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      positionMs: freezed == positionMs
          ? _value.positionMs
          : positionMs // ignore: cast_nullable_to_non_nullable
              as double?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double?,
      isPlaying: freezed == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool?,
      targetUserId: freezed == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncEventImplCopyWith<$Res>
    implements $SyncEventCopyWith<$Res> {
  factory _$$SyncEventImplCopyWith(
          _$SyncEventImpl value, $Res Function(_$SyncEventImpl) then) =
      __$$SyncEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SyncEventType type,
      String roomId,
      String userId,
      int timestamp,
      double? positionMs,
      double? speed,
      bool? isPlaying,
      String? targetUserId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$SyncEventImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$SyncEventImpl>
    implements _$$SyncEventImplCopyWith<$Res> {
  __$$SyncEventImplCopyWithImpl(
      _$SyncEventImpl _value, $Res Function(_$SyncEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? roomId = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? positionMs = freezed,
    Object? speed = freezed,
    Object? isPlaying = freezed,
    Object? targetUserId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$SyncEventImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SyncEventType,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      positionMs: freezed == positionMs
          ? _value.positionMs
          : positionMs // ignore: cast_nullable_to_non_nullable
              as double?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double?,
      isPlaying: freezed == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool?,
      targetUserId: freezed == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncEventImpl implements _SyncEvent {
  const _$SyncEventImpl(
      {required this.type,
      required this.roomId,
      required this.userId,
      required this.timestamp,
      this.positionMs,
      this.speed,
      this.isPlaying,
      this.targetUserId,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$SyncEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncEventImplFromJson(json);

  @override
  final SyncEventType type;
  @override
  final String roomId;
  @override
  final String userId;
  @override
  final int timestamp;
  @override
  final double? positionMs;
  @override
  final double? speed;
  @override
  final bool? isPlaying;
  @override
  final String? targetUserId;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SyncEvent(type: $type, roomId: $roomId, userId: $userId, timestamp: $timestamp, positionMs: $positionMs, speed: $speed, isPlaying: $isPlaying, targetUserId: $targetUserId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncEventImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.positionMs, positionMs) ||
                other.positionMs == positionMs) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.targetUserId, targetUserId) ||
                other.targetUserId == targetUserId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      roomId,
      userId,
      timestamp,
      positionMs,
      speed,
      isPlaying,
      targetUserId,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncEventImplCopyWith<_$SyncEventImpl> get copyWith =>
      __$$SyncEventImplCopyWithImpl<_$SyncEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncEventImplToJson(
      this,
    );
  }
}

abstract class _SyncEvent implements SyncEvent {
  const factory _SyncEvent(
      {required final SyncEventType type,
      required final String roomId,
      required final String userId,
      required final int timestamp,
      final double? positionMs,
      final double? speed,
      final bool? isPlaying,
      final String? targetUserId,
      final Map<String, dynamic>? metadata}) = _$SyncEventImpl;

  factory _SyncEvent.fromJson(Map<String, dynamic> json) =
      _$SyncEventImpl.fromJson;

  @override
  SyncEventType get type;
  @override
  String get roomId;
  @override
  String get userId;
  @override
  int get timestamp;
  @override
  double? get positionMs;
  @override
  double? get speed;
  @override
  bool? get isPlaying;
  @override
  String? get targetUserId;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of SyncEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncEventImplCopyWith<_$SyncEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlaybackState _$PlaybackStateFromJson(Map<String, dynamic> json) {
  return _PlaybackState.fromJson(json);
}

/// @nodoc
mixin _$PlaybackState {
  bool get isPlaying => throw _privateConstructorUsedError;
  double get positionMs => throw _privateConstructorUsedError;
  double get speed => throw _privateConstructorUsedError;
  int get lastUpdateTimestamp => throw _privateConstructorUsedError;
  String? get mediaPath => throw _privateConstructorUsedError;
  bool get isBuffering => throw _privateConstructorUsedError;

  /// Serializes this PlaybackState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaybackStateCopyWith<PlaybackState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackStateCopyWith<$Res> {
  factory $PlaybackStateCopyWith(
          PlaybackState value, $Res Function(PlaybackState) then) =
      _$PlaybackStateCopyWithImpl<$Res, PlaybackState>;
  @useResult
  $Res call(
      {bool isPlaying,
      double positionMs,
      double speed,
      int lastUpdateTimestamp,
      String? mediaPath,
      bool isBuffering});
}

/// @nodoc
class _$PlaybackStateCopyWithImpl<$Res, $Val extends PlaybackState>
    implements $PlaybackStateCopyWith<$Res> {
  _$PlaybackStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
    Object? positionMs = null,
    Object? speed = null,
    Object? lastUpdateTimestamp = null,
    Object? mediaPath = freezed,
    Object? isBuffering = null,
  }) {
    return _then(_value.copyWith(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      positionMs: null == positionMs
          ? _value.positionMs
          : positionMs // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdateTimestamp: null == lastUpdateTimestamp
          ? _value.lastUpdateTimestamp
          : lastUpdateTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      mediaPath: freezed == mediaPath
          ? _value.mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isBuffering: null == isBuffering
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlaybackStateImplCopyWith<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  factory _$$PlaybackStateImplCopyWith(
          _$PlaybackStateImpl value, $Res Function(_$PlaybackStateImpl) then) =
      __$$PlaybackStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isPlaying,
      double positionMs,
      double speed,
      int lastUpdateTimestamp,
      String? mediaPath,
      bool isBuffering});
}

/// @nodoc
class __$$PlaybackStateImplCopyWithImpl<$Res>
    extends _$PlaybackStateCopyWithImpl<$Res, _$PlaybackStateImpl>
    implements _$$PlaybackStateImplCopyWith<$Res> {
  __$$PlaybackStateImplCopyWithImpl(
      _$PlaybackStateImpl _value, $Res Function(_$PlaybackStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
    Object? positionMs = null,
    Object? speed = null,
    Object? lastUpdateTimestamp = null,
    Object? mediaPath = freezed,
    Object? isBuffering = null,
  }) {
    return _then(_$PlaybackStateImpl(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      positionMs: null == positionMs
          ? _value.positionMs
          : positionMs // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdateTimestamp: null == lastUpdateTimestamp
          ? _value.lastUpdateTimestamp
          : lastUpdateTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      mediaPath: freezed == mediaPath
          ? _value.mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isBuffering: null == isBuffering
          ? _value.isBuffering
          : isBuffering // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaybackStateImpl implements _PlaybackState {
  const _$PlaybackStateImpl(
      {this.isPlaying = false,
      this.positionMs = 0,
      this.speed = 1.0,
      this.lastUpdateTimestamp = 0,
      this.mediaPath,
      this.isBuffering = false});

  factory _$PlaybackStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaybackStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final double positionMs;
  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final int lastUpdateTimestamp;
  @override
  final String? mediaPath;
  @override
  @JsonKey()
  final bool isBuffering;

  @override
  String toString() {
    return 'PlaybackState(isPlaying: $isPlaying, positionMs: $positionMs, speed: $speed, lastUpdateTimestamp: $lastUpdateTimestamp, mediaPath: $mediaPath, isBuffering: $isBuffering)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybackStateImpl &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.positionMs, positionMs) ||
                other.positionMs == positionMs) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.lastUpdateTimestamp, lastUpdateTimestamp) ||
                other.lastUpdateTimestamp == lastUpdateTimestamp) &&
            (identical(other.mediaPath, mediaPath) ||
                other.mediaPath == mediaPath) &&
            (identical(other.isBuffering, isBuffering) ||
                other.isBuffering == isBuffering));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isPlaying, positionMs, speed,
      lastUpdateTimestamp, mediaPath, isBuffering);

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybackStateImplCopyWith<_$PlaybackStateImpl> get copyWith =>
      __$$PlaybackStateImplCopyWithImpl<_$PlaybackStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaybackStateImplToJson(
      this,
    );
  }
}

abstract class _PlaybackState implements PlaybackState {
  const factory _PlaybackState(
      {final bool isPlaying,
      final double positionMs,
      final double speed,
      final int lastUpdateTimestamp,
      final String? mediaPath,
      final bool isBuffering}) = _$PlaybackStateImpl;

  factory _PlaybackState.fromJson(Map<String, dynamic> json) =
      _$PlaybackStateImpl.fromJson;

  @override
  bool get isPlaying;
  @override
  double get positionMs;
  @override
  double get speed;
  @override
  int get lastUpdateTimestamp;
  @override
  String? get mediaPath;
  @override
  bool get isBuffering;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaybackStateImplCopyWith<_$PlaybackStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncMetrics _$SyncMetricsFromJson(Map<String, dynamic> json) {
  return _SyncMetrics.fromJson(json);
}

/// @nodoc
mixin _$SyncMetrics {
  int get rttMs => throw _privateConstructorUsedError;
  double get driftMs => throw _privateConstructorUsedError;
  int get syncCount => throw _privateConstructorUsedError;
  DateTime? get lastSync => throw _privateConstructorUsedError;
  SyncQuality get quality => throw _privateConstructorUsedError;

  /// Serializes this SyncMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncMetricsCopyWith<SyncMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncMetricsCopyWith<$Res> {
  factory $SyncMetricsCopyWith(
          SyncMetrics value, $Res Function(SyncMetrics) then) =
      _$SyncMetricsCopyWithImpl<$Res, SyncMetrics>;
  @useResult
  $Res call(
      {int rttMs,
      double driftMs,
      int syncCount,
      DateTime? lastSync,
      SyncQuality quality});
}

/// @nodoc
class _$SyncMetricsCopyWithImpl<$Res, $Val extends SyncMetrics>
    implements $SyncMetricsCopyWith<$Res> {
  _$SyncMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rttMs = null,
    Object? driftMs = null,
    Object? syncCount = null,
    Object? lastSync = freezed,
    Object? quality = null,
  }) {
    return _then(_value.copyWith(
      rttMs: null == rttMs
          ? _value.rttMs
          : rttMs // ignore: cast_nullable_to_non_nullable
              as int,
      driftMs: null == driftMs
          ? _value.driftMs
          : driftMs // ignore: cast_nullable_to_non_nullable
              as double,
      syncCount: null == syncCount
          ? _value.syncCount
          : syncCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastSync: freezed == lastSync
          ? _value.lastSync
          : lastSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as SyncQuality,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncMetricsImplCopyWith<$Res>
    implements $SyncMetricsCopyWith<$Res> {
  factory _$$SyncMetricsImplCopyWith(
          _$SyncMetricsImpl value, $Res Function(_$SyncMetricsImpl) then) =
      __$$SyncMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int rttMs,
      double driftMs,
      int syncCount,
      DateTime? lastSync,
      SyncQuality quality});
}

/// @nodoc
class __$$SyncMetricsImplCopyWithImpl<$Res>
    extends _$SyncMetricsCopyWithImpl<$Res, _$SyncMetricsImpl>
    implements _$$SyncMetricsImplCopyWith<$Res> {
  __$$SyncMetricsImplCopyWithImpl(
      _$SyncMetricsImpl _value, $Res Function(_$SyncMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rttMs = null,
    Object? driftMs = null,
    Object? syncCount = null,
    Object? lastSync = freezed,
    Object? quality = null,
  }) {
    return _then(_$SyncMetricsImpl(
      rttMs: null == rttMs
          ? _value.rttMs
          : rttMs // ignore: cast_nullable_to_non_nullable
              as int,
      driftMs: null == driftMs
          ? _value.driftMs
          : driftMs // ignore: cast_nullable_to_non_nullable
              as double,
      syncCount: null == syncCount
          ? _value.syncCount
          : syncCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastSync: freezed == lastSync
          ? _value.lastSync
          : lastSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as SyncQuality,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncMetricsImpl implements _SyncMetrics {
  const _$SyncMetricsImpl(
      {this.rttMs = 0,
      this.driftMs = 0,
      this.syncCount = 0,
      this.lastSync,
      this.quality = SyncQuality.excellent});

  factory _$SyncMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncMetricsImplFromJson(json);

  @override
  @JsonKey()
  final int rttMs;
  @override
  @JsonKey()
  final double driftMs;
  @override
  @JsonKey()
  final int syncCount;
  @override
  final DateTime? lastSync;
  @override
  @JsonKey()
  final SyncQuality quality;

  @override
  String toString() {
    return 'SyncMetrics(rttMs: $rttMs, driftMs: $driftMs, syncCount: $syncCount, lastSync: $lastSync, quality: $quality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncMetricsImpl &&
            (identical(other.rttMs, rttMs) || other.rttMs == rttMs) &&
            (identical(other.driftMs, driftMs) || other.driftMs == driftMs) &&
            (identical(other.syncCount, syncCount) ||
                other.syncCount == syncCount) &&
            (identical(other.lastSync, lastSync) ||
                other.lastSync == lastSync) &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, rttMs, driftMs, syncCount, lastSync, quality);

  /// Create a copy of SyncMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncMetricsImplCopyWith<_$SyncMetricsImpl> get copyWith =>
      __$$SyncMetricsImplCopyWithImpl<_$SyncMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncMetricsImplToJson(
      this,
    );
  }
}

abstract class _SyncMetrics implements SyncMetrics {
  const factory _SyncMetrics(
      {final int rttMs,
      final double driftMs,
      final int syncCount,
      final DateTime? lastSync,
      final SyncQuality quality}) = _$SyncMetricsImpl;

  factory _SyncMetrics.fromJson(Map<String, dynamic> json) =
      _$SyncMetricsImpl.fromJson;

  @override
  int get rttMs;
  @override
  double get driftMs;
  @override
  int get syncCount;
  @override
  DateTime? get lastSync;
  @override
  SyncQuality get quality;

  /// Create a copy of SyncMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncMetricsImplCopyWith<_$SyncMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
