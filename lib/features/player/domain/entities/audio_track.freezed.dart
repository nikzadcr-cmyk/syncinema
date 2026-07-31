// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AudioTrackInfo _$AudioTrackInfoFromJson(Map<String, dynamic> json) {
  return _AudioTrackInfo.fromJson(json);
}

/// @nodoc
mixin _$AudioTrackInfo {
  String get id => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  String? get codec => throw _privateConstructorUsedError;
  int? get channels => throw _privateConstructorUsedError;

  /// Serializes this AudioTrackInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudioTrackInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioTrackInfoCopyWith<AudioTrackInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioTrackInfoCopyWith<$Res> {
  factory $AudioTrackInfoCopyWith(
          AudioTrackInfo value, $Res Function(AudioTrackInfo) then) =
      _$AudioTrackInfoCopyWithImpl<$Res, AudioTrackInfo>;
  @useResult
  $Res call(
      {String id,
      int index,
      String language,
      String title,
      bool isDefault,
      String? codec,
      int? channels});
}

/// @nodoc
class _$AudioTrackInfoCopyWithImpl<$Res, $Val extends AudioTrackInfo>
    implements $AudioTrackInfoCopyWith<$Res> {
  _$AudioTrackInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioTrackInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
    Object? language = null,
    Object? title = null,
    Object? isDefault = null,
    Object? codec = freezed,
    Object? channels = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      codec: freezed == codec
          ? _value.codec
          : codec // ignore: cast_nullable_to_non_nullable
              as String?,
      channels: freezed == channels
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioTrackInfoImplCopyWith<$Res>
    implements $AudioTrackInfoCopyWith<$Res> {
  factory _$$AudioTrackInfoImplCopyWith(_$AudioTrackInfoImpl value,
          $Res Function(_$AudioTrackInfoImpl) then) =
      __$$AudioTrackInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int index,
      String language,
      String title,
      bool isDefault,
      String? codec,
      int? channels});
}

/// @nodoc
class __$$AudioTrackInfoImplCopyWithImpl<$Res>
    extends _$AudioTrackInfoCopyWithImpl<$Res, _$AudioTrackInfoImpl>
    implements _$$AudioTrackInfoImplCopyWith<$Res> {
  __$$AudioTrackInfoImplCopyWithImpl(
      _$AudioTrackInfoImpl _value, $Res Function(_$AudioTrackInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioTrackInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
    Object? language = null,
    Object? title = null,
    Object? isDefault = null,
    Object? codec = freezed,
    Object? channels = freezed,
  }) {
    return _then(_$AudioTrackInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      codec: freezed == codec
          ? _value.codec
          : codec // ignore: cast_nullable_to_non_nullable
              as String?,
      channels: freezed == channels
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioTrackInfoImpl implements _AudioTrackInfo {
  const _$AudioTrackInfoImpl(
      {required this.id,
      required this.index,
      required this.language,
      required this.title,
      this.isDefault = false,
      this.codec,
      this.channels});

  factory _$AudioTrackInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioTrackInfoImplFromJson(json);

  @override
  final String id;
  @override
  final int index;
  @override
  final String language;
  @override
  final String title;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  final String? codec;
  @override
  final int? channels;

  @override
  String toString() {
    return 'AudioTrackInfo(id: $id, index: $index, language: $language, title: $title, isDefault: $isDefault, codec: $codec, channels: $channels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioTrackInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.codec, codec) || other.codec == codec) &&
            (identical(other.channels, channels) ||
                other.channels == channels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, index, language, title, isDefault, codec, channels);

  /// Create a copy of AudioTrackInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioTrackInfoImplCopyWith<_$AudioTrackInfoImpl> get copyWith =>
      __$$AudioTrackInfoImplCopyWithImpl<_$AudioTrackInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioTrackInfoImplToJson(
      this,
    );
  }
}

abstract class _AudioTrackInfo implements AudioTrackInfo {
  const factory _AudioTrackInfo(
      {required final String id,
      required final int index,
      required final String language,
      required final String title,
      final bool isDefault,
      final String? codec,
      final int? channels}) = _$AudioTrackInfoImpl;

  factory _AudioTrackInfo.fromJson(Map<String, dynamic> json) =
      _$AudioTrackInfoImpl.fromJson;

  @override
  String get id;
  @override
  int get index;
  @override
  String get language;
  @override
  String get title;
  @override
  bool get isDefault;
  @override
  String? get codec;
  @override
  int? get channels;

  /// Create a copy of AudioTrackInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioTrackInfoImplCopyWith<_$AudioTrackInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
