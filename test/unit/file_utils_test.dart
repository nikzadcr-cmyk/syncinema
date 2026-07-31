import 'package:flutter_test/flutter_test.dart';
import 'package:syncinema/core/utils/file_utils.dart';

void main() {
  group('FileUtils', () {
    test('getExtension', () {
      expect(FileUtils.getExtension('/path/to/video.mp4'), 'mp4');
      expect(FileUtils.getExtension('movie.MKV'), 'mkv');
    });

    test('getFileName', () {
      expect(FileUtils.getFileName('/home/user/video.mp4'), 'video.mp4');
    });

    test('isVideoFile', () {
      expect(FileUtils.isVideoFile('movie.mp4'), true);
      expect(FileUtils.isVideoFile('movie.mkv'), true);
      expect(FileUtils.isVideoFile('song.mp3'), false);
    });

    test('isAudioFile', () {
      expect(FileUtils.isAudioFile('song.mp3'), true);
      expect(FileUtils.isAudioFile('track.flac'), true);
      expect(FileUtils.isAudioFile('video.mp4'), false);
    });

    test('isSupportedMedia', () {
      expect(FileUtils.isSupportedMedia('video.mp4'), true);
      expect(FileUtils.isSupportedMedia('audio.mp3'), true);
      expect(FileUtils.isSupportedMedia('doc.pdf'), false);
    });

    test('generateRoomId produces 6 chars', () {
      final id = FileUtils.generateRoomId();
      expect(id.length, 6);
      expect(RegExp(r'^[A-Z0-9]{6}$').hasMatch(id), true);
    });
  });
}
