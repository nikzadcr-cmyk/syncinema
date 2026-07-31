import 'dart:async';
import 'dart:collection';

class LatencyMonitor {
  final int _maxSamples = 20;
  final Queue<int> _samples = Queue<int>();
  
  int _currentPing = 0;
  int get currentPing => _currentPing;
  
  double get averagePing {
    if (_samples.isEmpty) return 0;
    return _samples.reduce((a, b) => a + b) / _samples.length;
  }
  
  int get minPing => _samples.isEmpty ? 0 : _samples.reduce((a, b) => a < b ? a : b);
  int get maxPing => _samples.isEmpty ? 0 : _samples.reduce((a, b) => a > b ? a : b);
  
  String get quality {
    final avg = averagePing;
    if (avg < 50) return 'Excellent';
    if (avg < 100) return 'Good';
    if (avg < 200) return 'Fair';
    if (avg < 400) return 'Poor';
    return 'Bad';
  }
  
  double get qualityScore {
    // 0..1
    final avg = averagePing;
    if (avg <= 30) return 1.0;
    if (avg <= 50) return 0.9;
    if (avg <= 100) return 0.75;
    if (avg <= 200) return 0.5;
    if (avg <= 400) return 0.25;
    return 0.1;
  }
  
  void addSample(int rttMs) {
    _currentPing = rttMs;
    _samples.addLast(rttMs);
    if (_samples.length > _maxSamples) {
      _samples.removeFirst();
    }
  }
  
  void reset() {
    _samples.clear();
    _currentPing = 0;
  }
}
