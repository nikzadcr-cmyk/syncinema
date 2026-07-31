// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get hostId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  bool get allowAllControl => throw _privateConstructorUsedError;
  bool get isMusicMode => throw _privateConstructorUsedError;
  String? get currentMediaName => throw _privateConstructorUsedError;
  int get currentMediaDurationMs => throw _privateConstructorUsedError;
  RoomState get state => throw _privateConstructorUsedError;
  String? get inviteLink => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call(
      {String id,
      String name,
      String hostId,
      DateTime createdAt,
      List<String> participantIds,
      bool allowAllControl,
      bool isMusicMode,
      String? currentMediaName,
      int currentMediaDurationMs,
      RoomState state,
      String? inviteLink});
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? hostId = null,
    Object? createdAt = null,
    Object? participantIds = null,
    Object? allowAllControl = null,
    Object? isMusicMode = null,
    Object? currentMediaName = freezed,
    Object? currentMediaDurationMs = null,
    Object? state = null,
    Object? inviteLink = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hostId: null == hostId
          ? _value.hostId
          : hostId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      participantIds: null == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowAllControl: null == allowAllControl
          ? _value.allowAllControl
          : allowAllControl // ignore: cast_nullable_to_non_nullable
              as bool,
      isMusicMode: null == isMusicMode
          ? _value.isMusicMode
          : isMusicMode // ignore: cast_nullable_to_non_nullable
              as bool,
      currentMediaName: freezed == currentMediaName
          ? _value.currentMediaName
          : currentMediaName // ignore: cast_nullable_to_non_nullable
              as String?,
      currentMediaDurationMs: null == currentMediaDurationMs
          ? _value.currentMediaDurationMs
          : currentMediaDurationMs // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as RoomState,
      inviteLink: freezed == inviteLink
          ? _value.inviteLink
          : inviteLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
          _$RoomImpl value, $Res Function(_$RoomImpl) then) =
      __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String hostId,
      DateTime createdAt,
      List<String> participantIds,
      bool allowAllControl,
      bool isMusicMode,
      String? currentMediaName,
      int currentMediaDurationMs,
      RoomState state,
      String? inviteLink});
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? hostId = null,
    Object? createdAt = null,
    Object? participantIds = null,
    Object? allowAllControl = null,
    Object? isMusicMode = null,
    Object? currentMediaName = freezed,
    Object? currentMediaDurationMs = null,
    Object? state = null,
    Object? inviteLink = freezed,
  }) {
    return _then(_$RoomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hostId: null == hostId
          ? _value.hostId
          : hostId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      participantIds: null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allowAllControl: null == allowAllControl
          ? _value.allowAllControl
          : allowAllControl // ignore: cast_nullable_to_non_nullable
              as bool,
      isMusicMode: null == isMusicMode
          ? _value.isMusicMode
          : isMusicMode // ignore: cast_nullable_to_non_nullable
              as bool,
      currentMediaName: freezed == currentMediaName
          ? _value.currentMediaName
          : currentMediaName // ignore: cast_nullable_to_non_nullable
              as String?,
      currentMediaDurationMs: null == currentMediaDurationMs
          ? _value.currentMediaDurationMs
          : currentMediaDurationMs // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as RoomState,
      inviteLink: freezed == inviteLink
          ? _value.inviteLink
          : inviteLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl implements _Room {
  const _$RoomImpl(
      {required this.id,
      required this.name,
      required this.hostId,
      required this.createdAt,
      final List<String> participantIds = const [],
      this.allowAllControl = true,
      this.isMusicMode = false,
      this.currentMediaName,
      this.currentMediaDurationMs = 0,
      this.state = RoomState.waiting,
      this.inviteLink})
      : _participantIds = participantIds;

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String hostId;
  @override
  final DateTime createdAt;
  final List<String> _participantIds;
  @override
  @JsonKey()
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  @JsonKey()
  final bool allowAllControl;
  @override
  @JsonKey()
  final bool isMusicMode;
  @override
  final String? currentMediaName;
  @override
  @JsonKey()
  final int currentMediaDurationMs;
  @override
  @JsonKey()
  final RoomState state;
  @override
  final String? inviteLink;

  @override
  String toString() {
    return 'Room(id: $id, name: $name, hostId: $hostId, createdAt: $createdAt, participantIds: $participantIds, allowAllControl: $allowAllControl, isMusicMode: $isMusicMode, currentMediaName: $currentMediaName, currentMediaDurationMs: $currentMediaDurationMs, state: $state, inviteLink: $inviteLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            (identical(other.allowAllControl, allowAllControl) ||
                other.allowAllControl == allowAllControl) &&
            (identical(other.isMusicMode, isMusicMode) ||
                other.isMusicMode == isMusicMode) &&
            (identical(other.currentMediaName, currentMediaName) ||
                other.currentMediaName == currentMediaName) &&
            (identical(other.currentMediaDurationMs, currentMediaDurationMs) ||
                other.currentMediaDurationMs == currentMediaDurationMs) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.inviteLink, inviteLink) ||
                other.inviteLink == inviteLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      hostId,
      createdAt,
      const DeepCollectionEquality().hash(_participantIds),
      allowAllControl,
      isMusicMode,
      currentMediaName,
      currentMediaDurationMs,
      state,
      inviteLink);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(
      this,
    );
  }
}

abstract class _Room implements Room {
  const factory _Room(
      {required final String id,
      required final String name,
      required final String hostId,
      required final DateTime createdAt,
      final List<String> participantIds,
      final bool allowAllControl,
      final bool isMusicMode,
      final String? currentMediaName,
      final int currentMediaDurationMs,
      final RoomState state,
      final String? inviteLink}) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get hostId;
  @override
  DateTime get createdAt;
  @override
  List<String> get participantIds;
  @override
  bool get allowAllControl;
  @override
  bool get isMusicMode;
  @override
  String? get currentMediaName;
  @override
  int get currentMediaDurationMs;
  @override
  RoomState get state;
  @override
  String? get inviteLink;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  bool get isHost => throw _privateConstructorUsedError;
  UserStatus get status => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;
  String? get currentFileName => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;
  int get pingMs => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? avatar,
      bool isHost,
      UserStatus status,
      bool isTyping,
      String? currentFileName,
      DateTime? lastSeen,
      int pingMs});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? isHost = null,
    Object? status = null,
    Object? isTyping = null,
    Object? currentFileName = freezed,
    Object? lastSeen = freezed,
    Object? pingMs = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      isHost: null == isHost
          ? _value.isHost
          : isHost // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      currentFileName: freezed == currentFileName
          ? _value.currentFileName
          : currentFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pingMs: null == pingMs
          ? _value.pingMs
          : pingMs // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? avatar,
      bool isHost,
      UserStatus status,
      bool isTyping,
      String? currentFileName,
      DateTime? lastSeen,
      int pingMs});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? isHost = null,
    Object? status = null,
    Object? isTyping = null,
    Object? currentFileName = freezed,
    Object? lastSeen = freezed,
    Object? pingMs = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      isHost: null == isHost
          ? _value.isHost
          : isHost // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      currentFileName: freezed == currentFileName
          ? _value.currentFileName
          : currentFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pingMs: null == pingMs
          ? _value.pingMs
          : pingMs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.name,
      this.avatar,
      this.isHost = false,
      this.status = UserStatus.online,
      this.isTyping = false,
      this.currentFileName,
      this.lastSeen,
      this.pingMs = 0});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? avatar;
  @override
  @JsonKey()
  final bool isHost;
  @override
  @JsonKey()
  final UserStatus status;
  @override
  @JsonKey()
  final bool isTyping;
  @override
  final String? currentFileName;
  @override
  final DateTime? lastSeen;
  @override
  @JsonKey()
  final int pingMs;

  @override
  String toString() {
    return 'User(id: $id, name: $name, avatar: $avatar, isHost: $isHost, status: $status, isTyping: $isTyping, currentFileName: $currentFileName, lastSeen: $lastSeen, pingMs: $pingMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.isHost, isHost) || other.isHost == isHost) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping) &&
            (identical(other.currentFileName, currentFileName) ||
                other.currentFileName == currentFileName) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.pingMs, pingMs) || other.pingMs == pingMs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatar, isHost, status,
      isTyping, currentFileName, lastSeen, pingMs);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String name,
      final String? avatar,
      final bool isHost,
      final UserStatus status,
      final bool isTyping,
      final String? currentFileName,
      final DateTime? lastSeen,
      final int pingMs}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  bool get isHost;
  @override
  UserStatus get status;
  @override
  bool get isTyping;
  @override
  String? get currentFileName;
  @override
  DateTime? get lastSeen;
  @override
  int get pingMs;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoomSettings _$RoomSettingsFromJson(Map<String, dynamic> json) {
  return _RoomSettings.fromJson(json);
}

/// @nodoc
mixin _$RoomSettings {
  bool get allowAllControl => throw _privateConstructorUsedError;
  bool get enableChat => throw _privateConstructorUsedError;
  bool get enableReactions => throw _privateConstructorUsedError;
  bool get autoSync => throw _privateConstructorUsedError;
  int get maxDriftMs => throw _privateConstructorUsedError;

  /// Serializes this RoomSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomSettingsCopyWith<RoomSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomSettingsCopyWith<$Res> {
  factory $RoomSettingsCopyWith(
          RoomSettings value, $Res Function(RoomSettings) then) =
      _$RoomSettingsCopyWithImpl<$Res, RoomSettings>;
  @useResult
  $Res call(
      {bool allowAllControl,
      bool enableChat,
      bool enableReactions,
      bool autoSync,
      int maxDriftMs});
}

/// @nodoc
class _$RoomSettingsCopyWithImpl<$Res, $Val extends RoomSettings>
    implements $RoomSettingsCopyWith<$Res> {
  _$RoomSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowAllControl = null,
    Object? enableChat = null,
    Object? enableReactions = null,
    Object? autoSync = null,
    Object? maxDriftMs = null,
  }) {
    return _then(_value.copyWith(
      allowAllControl: null == allowAllControl
          ? _value.allowAllControl
          : allowAllControl // ignore: cast_nullable_to_non_nullable
              as bool,
      enableChat: null == enableChat
          ? _value.enableChat
          : enableChat // ignore: cast_nullable_to_non_nullable
              as bool,
      enableReactions: null == enableReactions
          ? _value.enableReactions
          : enableReactions // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSync: null == autoSync
          ? _value.autoSync
          : autoSync // ignore: cast_nullable_to_non_nullable
              as bool,
      maxDriftMs: null == maxDriftMs
          ? _value.maxDriftMs
          : maxDriftMs // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomSettingsImplCopyWith<$Res>
    implements $RoomSettingsCopyWith<$Res> {
  factory _$$RoomSettingsImplCopyWith(
          _$RoomSettingsImpl value, $Res Function(_$RoomSettingsImpl) then) =
      __$$RoomSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool allowAllControl,
      bool enableChat,
      bool enableReactions,
      bool autoSync,
      int maxDriftMs});
}

/// @nodoc
class __$$RoomSettingsImplCopyWithImpl<$Res>
    extends _$RoomSettingsCopyWithImpl<$Res, _$RoomSettingsImpl>
    implements _$$RoomSettingsImplCopyWith<$Res> {
  __$$RoomSettingsImplCopyWithImpl(
      _$RoomSettingsImpl _value, $Res Function(_$RoomSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowAllControl = null,
    Object? enableChat = null,
    Object? enableReactions = null,
    Object? autoSync = null,
    Object? maxDriftMs = null,
  }) {
    return _then(_$RoomSettingsImpl(
      allowAllControl: null == allowAllControl
          ? _value.allowAllControl
          : allowAllControl // ignore: cast_nullable_to_non_nullable
              as bool,
      enableChat: null == enableChat
          ? _value.enableChat
          : enableChat // ignore: cast_nullable_to_non_nullable
              as bool,
      enableReactions: null == enableReactions
          ? _value.enableReactions
          : enableReactions // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSync: null == autoSync
          ? _value.autoSync
          : autoSync // ignore: cast_nullable_to_non_nullable
              as bool,
      maxDriftMs: null == maxDriftMs
          ? _value.maxDriftMs
          : maxDriftMs // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomSettingsImpl implements _RoomSettings {
  const _$RoomSettingsImpl(
      {this.allowAllControl = true,
      this.enableChat = true,
      this.enableReactions = true,
      this.autoSync = true,
      this.maxDriftMs = 150});

  factory _$RoomSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool allowAllControl;
  @override
  @JsonKey()
  final bool enableChat;
  @override
  @JsonKey()
  final bool enableReactions;
  @override
  @JsonKey()
  final bool autoSync;
  @override
  @JsonKey()
  final int maxDriftMs;

  @override
  String toString() {
    return 'RoomSettings(allowAllControl: $allowAllControl, enableChat: $enableChat, enableReactions: $enableReactions, autoSync: $autoSync, maxDriftMs: $maxDriftMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomSettingsImpl &&
            (identical(other.allowAllControl, allowAllControl) ||
                other.allowAllControl == allowAllControl) &&
            (identical(other.enableChat, enableChat) ||
                other.enableChat == enableChat) &&
            (identical(other.enableReactions, enableReactions) ||
                other.enableReactions == enableReactions) &&
            (identical(other.autoSync, autoSync) ||
                other.autoSync == autoSync) &&
            (identical(other.maxDriftMs, maxDriftMs) ||
                other.maxDriftMs == maxDriftMs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, allowAllControl, enableChat,
      enableReactions, autoSync, maxDriftMs);

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomSettingsImplCopyWith<_$RoomSettingsImpl> get copyWith =>
      __$$RoomSettingsImplCopyWithImpl<_$RoomSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomSettingsImplToJson(
      this,
    );
  }
}

abstract class _RoomSettings implements RoomSettings {
  const factory _RoomSettings(
      {final bool allowAllControl,
      final bool enableChat,
      final bool enableReactions,
      final bool autoSync,
      final int maxDriftMs}) = _$RoomSettingsImpl;

  factory _RoomSettings.fromJson(Map<String, dynamic> json) =
      _$RoomSettingsImpl.fromJson;

  @override
  bool get allowAllControl;
  @override
  bool get enableChat;
  @override
  bool get enableReactions;
  @override
  bool get autoSync;
  @override
  int get maxDriftMs;

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomSettingsImplCopyWith<_$RoomSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
