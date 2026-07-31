import 'dart:io';
import 'package:media_kit/media_kit.dart';
import '../../features/player/domain/entities/media_file.dart';
import '../../features/player/domain/entities/audio_track.dart';
import '../../features/player/domain/entities/subtitle_track.dart';

class MediaMetadataExtractor {
  static Future<MediaFile> extractMetadata(String path) async {
    final file = File(path);
    final exists = await file.exists();
    if (!exists) throw Exception('File not found: $path');
    
    final size = await file.length();
    
    // Use media_kit to probe - open temporary player
    final player = Player();
    try {
      await player.open(Media(path), play: false);
      
      // Wait a bit for tracks to load (media_kit lazy loads)
      await Future.delayed(const Duration(milliseconds: 500));
      
      final duration = player.state.duration;
      final tracks = player.state.tracks;

      // Parse audio tracks
      final audioTracks = <AudioTrackInfo>[];
      for (int i = 0; i < tracks.audio.length; i++) {
        final t = tracks.audio[i];
        audioTracks.add(AudioTrackInfo(
          id: t.id,
          index: i,
          language: t.language ?? 'unknown',
          title: t.title ?? 'Track ${i + 1}',
          isDefault: i == 0,
        ));
      }

      // Parse subtitle tracks
      final subtitleTracks = <SubtitleTrackInfo>[];
      for (int i = 0; i < tracks.subtitle.length; i++) {
        final t = tracks.subtitle[i];
        subtitleTracks.add(SubtitleTrackInfo(
          id: t.id,
          index: i,
          language: t.language ?? 'unknown',
          title: t.title ?? 'Subtitle ${i + 1}',
          isDefault: false,
          isEmbedded: true,
        ));
      }

      return MediaFile(
        path: path,
        name: path.split('/').last,
        size: size,
        duration: duration,
        audioTracks: audioTracks,
        subtitleTracks: subtitleTracks,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      // Fallback - without track info
      return MediaFile(
        path: path,
        name: path.split('/').last,
        size: size,
        duration: Duration.zero,
        audioTracks: [],
        subtitleTracks: [],
        createdAt: DateTime.now(),
      );
    } finally {
      await player.dispose();
    }
  }

  static String detectLanguage(String code) {
    const langMap = {
      'en': 'English',
      'fa': 'فارسی',
      'per': 'فارسی',
      'fas': 'فارسی',
      'ar': 'العربية',
      'fr': 'Français',
      'de': 'Deutsch',
      'es': 'Español',
      'tr': 'Türkçe',
      'ja': '日本語',
      'ko': '한국어',
      'ru': 'Русский',
      'hin': 'हिन्दी',
      'und': 'Unknown',
      'unknown': 'Unknown',
    };
    return langMap[code.toLowerCase()] ?? code.toUpperCase();
  }
}
