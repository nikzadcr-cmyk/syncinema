import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../constants/app_constants.dart';

class FileUtils {
  static String getExtension(String path) {
    return path.split('.').last.toLowerCase();
  }

  static String getFileName(String path) {
    return path.split('/').last.split('\\').last;
  }

  static String getFileNameWithoutExt(String path) {
    final name = getFileName(path);
    final dot = name.lastIndexOf('.');
    return dot == -1 ? name : name.substring(0, dot);
  }

  static bool isVideoFile(String path) {
    return AppConstants.supportedVideoExts.contains(getExtension(path));
  }

  static bool isAudioFile(String path) {
    return AppConstants.supportedAudioExts.contains(getExtension(path));
  }

  static bool isSubtitleFile(String path) {
    return AppConstants.supportedSubtitleExts.contains(getExtension(path));
  }

  static bool isSupportedMedia(String path) {
    return isVideoFile(path) || isAudioFile(path);
  }

  static Future<String> formatFileSize(int bytes) async {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  static Future<int> getFileSize(String path) async {
    try {
      final file = File(path);
      return await file.length();
    } catch (_) {
      return 0;
    }
  }

  static Future<Directory> getTempDir() async {
    return await getTemporaryDirectory();
  }

  // Create a unique room ID similar to YouTube/Agora
  static String generateRoomId() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rand = DateTime.now().microsecondsSinceEpoch;
    final buf = StringBuffer();
    var num = rand;
    for (int i = 0; i < 6; i++) {
      buf.write(chars[num % chars.length]);
      num ~/= chars.length;
      if (num == 0) num = DateTime.now().microsecondsSinceEpoch + i * 9973;
    }
    return buf.toString();
  }
}
