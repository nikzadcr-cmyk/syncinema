import 'package:flutter_test/flutter_test.dart';
import 'package:syncinema/core/network/latency_monitor.dart';

void main() {
  group('LatencyMonitor', () {
    test('initial state is zero', () {
      final monitor = LatencyMonitor();
      expect(monitor.currentPing, 0);
      expect(monitor.averagePing, 0);
      expect(monitor.quality, 'Excellent');
    });

    test('adds samples and calculates average', () {
      final monitor = LatencyMonitor();
      monitor.addSample(50);
      monitor.addSample(100);
      monitor.addSample(150);
      expect(monitor.currentPing, 150);
      expect(monitor.averagePing, 100);
    });

    test('quality based on ping', () {
      final monitor = LatencyMonitor();
      monitor.addSample(30);
      expect(monitor.quality, 'Excellent');
      monitor.addSample(80);
      monitor.addSample(90);
      expect(monitor.quality, 'Good'); // avg ~ 66

      final poor = LatencyMonitor();
      poor.addSample(300);
      expect(poor.quality, 'Poor');
    });

    test('min max', () {
      final m = LatencyMonitor();
      m.addSample(10);
      m.addSample(200);
      m.addSample(50);
      expect(m.minPing, 10);
      expect(m.maxPing, 200);
    });
  });
}
