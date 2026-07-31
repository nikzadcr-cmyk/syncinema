import 'package:freezed_annotation/freezed_annotation.dart';
import 'audio_track.dart';
import 'subtitle_track.dart';

part 'media_file.freezed.dart';
part 'media_file.g.dart';

@freezed
class MediaFile with _$MediaFile {
  const factory MediaFile({
    required String path,
    required String name,
    required int size,
    required Duration duration,
    @Default([]) List<AudioTrackInfo> audioTracks,
    @Default([]) List<SubtitleTrackInfo> subtitleTracks,
    String? thumbnailPath,
    DateTime? createdAt,
    String? mimeType,
  }) = _MediaFile;

  factory MediaFile.fromJson(Map<String, dynamic> json) => _$MediaFileFromJson(json);
}

extension MediaFileX on MediaFile {
  bool get isVideo {
    final ext = path.split('.').last.toLowerCase();
    return ['mp4','mkv','mov','avi','webm','m4v','3gp','flv','wmv'].contains(ext);
  }
  
  bool get isAudio => !isVideo;
  
  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024*1024) return '${(size/1024).toStringAsFixed(1)} KB';
    if (size < 1024*1024*1024) return '${(size/(1024*1024)).toStringAsFixed(1)} MB';
    return '${(size/(1024*1024*1024)).toStringAsFixed(2)} GB';
  }
  
  String get formattedDuration {
    final h = duration.inHours;
    final m = duration.inMinutes.remainder(60).toString().padLeft(2,'0');
    final s = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }
}
