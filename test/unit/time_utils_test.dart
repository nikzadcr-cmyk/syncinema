import 'package:flutter_test/flutter_test.dart';
import 'package:syncinema/core/utils/time_utils.dart';

void main() {
  group('TimeUtils', () {
    test('formatDuration without hours', () {
      expect(TimeUtils.formatDuration(const Duration(minutes: 2, seconds: 5)), '02:05');
    });

    test('formatDuration with hours', () {
      expect(TimeUtils.formatDuration(const Duration(hours: 1, minutes: 2, seconds: 3)), '1:02:03');
    });

    test('parseSrtTime', () {
      final d = TimeUtils.parseSrtTime('00:01:23,456');
      expect(d, const Duration(minutes: 1, seconds: 23, milliseconds: 456));
    });
  });
}
