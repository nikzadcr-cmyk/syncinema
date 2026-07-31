// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MediaFile _$MediaFileFromJson(Map<String, dynamic> json) {
  return _MediaFile.fromJson(json);
}

/// @nodoc
mixin _$MediaFile {
  String get path => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  List<AudioTrackInfo> get audioTracks => throw _privateConstructorUsedError;
  List<SubtitleTrackInfo> get subtitleTracks =>
      throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get mimeType => throw _privateConstructorUsedError;

  /// Serializes this MediaFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaFileCopyWith<MediaFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaFileCopyWith<$Res> {
  factory $MediaFileCopyWith(MediaFile value, $Res Function(MediaFile) then) =
      _$MediaFileCopyWithImpl<$Res, MediaFile>;
  @useResult
  $Res call(
      {String path,
      String name,
      int size,
      Duration duration,
      List<AudioTrackInfo> audioTracks,
      List<SubtitleTrackInfo> subtitleTracks,
      String? thumbnailPath,
      DateTime? createdAt,
      String? mimeType});
}

/// @nodoc
class _$MediaFileCopyWithImpl<$Res, $Val extends MediaFile>
    implements $MediaFileCopyWith<$Res> {
  _$MediaFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? name = null,
    Object? size = null,
    Object? duration = null,
    Object? audioTracks = null,
    Object? subtitleTracks = null,
    Object? thumbnailPath = freezed,
    Object? createdAt = freezed,
    Object? mimeType = freezed,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      audioTracks: null == audioTracks
          ? _value.audioTracks
          : audioTracks // ignore: cast_nullable_to_non_nullable
              as List<AudioTrackInfo>,
      subtitleTracks: null == subtitleTracks
          ? _value.subtitleTracks
          : subtitleTracks // ignore: cast_nullable_to_non_nullable
              as List<SubtitleTrackInfo>,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaFileImplCopyWith<$Res>
    implements $MediaFileCopyWith<$Res> {
  factory _$$MediaFileImplCopyWith(
          _$MediaFileImpl value, $Res Function(_$MediaFileImpl) then) =
      __$$MediaFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String path,
      String name,
      int size,
      Duration duration,
      List<AudioTrackInfo> audioTracks,
      List<SubtitleTrackInfo> subtitleTracks,
      String? thumbnailPath,
      DateTime? createdAt,
      String? mimeType});
}

/// @nodoc
class __$$MediaFileImplCopyWithImpl<$Res>
    extends _$MediaFileCopyWithImpl<$Res, _$MediaFileImpl>
    implements _$$MediaFileImplCopyWith<$Res> {
  __$$MediaFileImplCopyWithImpl(
      _$MediaFileImpl _value, $Res Function(_$MediaFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? name = null,
    Object? size = null,
    Object? duration = null,
    Object? audioTracks = null,
    Object? subtitleTracks = null,
    Object? thumbnailPath = freezed,
    Object? createdAt = freezed,
    Object? mimeType = freezed,
  }) {
    return _then(_$MediaFileImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      audioTracks: null == audioTracks
          ? _value._audioTracks
          : audioTracks // ignore: cast_nullable_to_non_nullable
              as List<AudioTrackInfo>,
      subtitleTracks: null == subtitleTracks
          ? _value._subtitleTracks
          : subtitleTracks // ignore: cast_nullable_to_non_nullable
              as List<SubtitleTrackInfo>,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaFileImpl implements _MediaFile {
  const _$MediaFileImpl(
      {required this.path,
      required this.name,
      required this.size,
      required this.duration,
      final List<AudioTrackInfo> audioTracks = const [],
      final List<SubtitleTrackInfo> subtitleTracks = const [],
      this.thumbnailPath,
      this.createdAt,
      this.mimeType})
      : _audioTracks = audioTracks,
        _subtitleTracks = subtitleTracks;

  factory _$MediaFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaFileImplFromJson(json);

  @override
  final String path;
  @override
  final String name;
  @override
  final int size;
  @override
  final Duration duration;
  final List<AudioTrackInfo> _audioTracks;
  @override
  @JsonKey()
  List<AudioTrackInfo> get audioTracks {
    if (_audioTracks is EqualUnmodifiableListView) return _audioTracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audioTracks);
  }

  final List<SubtitleTrackInfo> _subtitleTracks;
  @override
  @JsonKey()
  List<SubtitleTrackInfo> get subtitleTracks {
    if (_subtitleTracks is EqualUnmodifiableListView) return _subtitleTracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtitleTracks);
  }

  @override
  final String? thumbnailPath;
  @override
  final DateTime? createdAt;
  @override
  final String? mimeType;

  @override
  String toString() {
    return 'MediaFile(path: $path, name: $name, size: $size, duration: $duration, audioTracks: $audioTracks, subtitleTracks: $subtitleTracks, thumbnailPath: $thumbnailPath, createdAt: $createdAt, mimeType: $mimeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaFileImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality()
                .equals(other._audioTracks, _audioTracks) &&
            const DeepCollectionEquality()
                .equals(other._subtitleTracks, _subtitleTracks) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      path,
      name,
      size,
      duration,
      const DeepCollectionEquality().hash(_audioTracks),
      const DeepCollectionEquality().hash(_subtitleTracks),
      thumbnailPath,
      createdAt,
      mimeType);

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaFileImplCopyWith<_$MediaFileImpl> get copyWith =>
      __$$MediaFileImplCopyWithImpl<_$MediaFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaFileImplToJson(
      this,
    );
  }
}

abstract class _MediaFile implements MediaFile {
  const factory _MediaFile(
      {required final String path,
      required final String name,
      required final int size,
      required final Duration duration,
      final List<AudioTrackInfo> audioTracks,
      final List<SubtitleTrackInfo> subtitleTracks,
      final String? thumbnailPath,
      final DateTime? createdAt,
      final String? mimeType}) = _$MediaFileImpl;

  factory _MediaFile.fromJson(Map<String, dynamic> json) =
      _$MediaFileImpl.fromJson;

  @override
  String get path;
  @override
  String get name;
  @override
  int get size;
  @override
  Duration get duration;
  @override
  List<AudioTrackInfo> get audioTracks;
  @override
  List<SubtitleTrackInfo> get subtitleTracks;
  @override
  String? get thumbnailPath;
  @override
  DateTime? get createdAt;
  @override
  String? get mimeType;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaFileImplCopyWith<_$MediaFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
