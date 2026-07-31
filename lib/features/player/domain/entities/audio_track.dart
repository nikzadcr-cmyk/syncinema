import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_track.freezed.dart';
part 'audio_track.g.dart';

@freezed
class AudioTrackInfo with _$AudioTrackInfo {
  const factory AudioTrackInfo({
    required String id,
    required int index,
    required String language,
    required String title,
    @Default(false) bool isDefault,
    String? codec,
    int? channels,
  }) = _AudioTrackInfo;

  factory AudioTrackInfo.fromJson(Map<String, dynamic> json) => _$AudioTrackInfoFromJson(json);
}

extension AudioTrackLang on AudioTrackInfo {
  String get displayLanguage {
    const map = {
      'en': 'English', 'fa': 'فارسی', 'per': 'فارسی', 'fas': 'فارسی',
      'ar': 'العربية', 'fr': 'Français', 'de': 'Deutsch', 'es': 'Español',
      'tr': 'Türkçe', 'ja': '日本語', 'ko': '한국어', 'ru': 'Русский',
      'und': 'Unknown', 'unknown': 'Unknown',
    };
    return map[language.toLowerCase()] ?? language;
  }
}
