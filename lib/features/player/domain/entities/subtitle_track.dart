import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle_track.freezed.dart';
part 'subtitle_track.g.dart';

@freezed
class SubtitleTrackInfo with _$SubtitleTrackInfo {
  const factory SubtitleTrackInfo({
    required String id,
    required int index,
    required String language,
    required String title,
    @Default(false) bool isDefault,
    @Default(false) bool isExternal,
    @Default(false) bool isEmbedded,
    String? path, // for external
  }) = _SubtitleTrackInfo;

  factory SubtitleTrackInfo.fromJson(Map<String, dynamic> json) => _$SubtitleTrackInfoFromJson(json);
}

@freezed
class SubtitleStyleConfig with _$SubtitleStyleConfig {
  const factory SubtitleStyleConfig({
    @Default(16.0) double fontSize,
    @Default(0xFFFFFFFF) int color,
    @Default(0xFF000000) int backgroundColor,
    @Default(0.0) double backgroundOpacity,
    @Default(SubtitlePosition.bottom) SubtitlePosition position,
    @Default(0.0) double delayMs,
    @Default('Vazirmatn') String fontFamily,
    @Default(false) bool bold,
  }) = _SubtitleStyleConfig;

  factory SubtitleStyleConfig.fromJson(Map<String, dynamic> json) => _$SubtitleStyleConfigFromJson(json);
}

enum SubtitlePosition { top, center, bottom }
