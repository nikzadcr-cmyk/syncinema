import 'package:flutter_test/flutter_test.dart';
import 'package:syncinema/features/sync/domain/entities/sync_event.dart';
import 'package:syncinema/features/sync/engine/sync_engine.dart';

void main() {
  group('SyncEngine', () {
    late SyncEngine engine;
    late List<SyncEvent> sentEvents;
    late PlaybackState appliedState;

    setUp(() {
      sentEvents = [];
      appliedState = const PlaybackState();
      engine = SyncEngine(
        sendEvent: (e) => sentEvents.add(e),
        applyState: (pos, playing, speed) async {
          appliedState = PlaybackState(
            isPlaying: playing,
            positionMs: pos.inMilliseconds.toDouble(),
            speed: speed,
          );
        },
      );
      engine.init(roomId: 'ABC123', userId: 'user1', isHost: true);
    });

    tearDown(() {
      engine.dispose();
    });

    test('sendPlay creates correct event', () {
      engine.sendPlay(const Duration(seconds: 10), speed: 1.0);
      expect(sentEvents.length, 1);
      expect(sentEvents.first.type, SyncEventType.play);
      expect(sentEvents.first.positionMs, 10000);
      expect(sentEvents.first.isPlaying, true);
    });

    test('sendPause creates pause event', () {
      engine.sendPause(const Duration(seconds: 5));
      expect(sentEvents.first.type, SyncEventType.pause);
      expect(sentEvents.first.isPlaying, false);
    });

    test('sendSeek creates seek event', () {
      engine.sendSeek(const Duration(seconds: 30), isPlaying: true);
      expect(sentEvents.first.type, SyncEventType.seek);
      expect(sentEvents.first.positionMs, 30000);
    });

    test('handleRemoteEvent applies state', () async {
      final event = SyncEvent(
        type: SyncEventType.play,
        roomId: 'ABC123',
        userId: 'user2',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        positionMs: 15000,
        isPlaying: true,
        speed: 1.0,
      );
      engine.handleRemoteEvent(event);
      // Allow async apply
      await Future.delayed(const Duration(milliseconds: 100));
      expect(appliedState.positionMs, 15000);
      expect(appliedState.isPlaying, true);
    });

    test('ignores own events', () async {
      final event = SyncEvent(
        type: SyncEventType.play,
        roomId: 'ABC123',
        userId: 'user1', // same as self
        timestamp: DateTime.now().millisecondsSinceEpoch,
        positionMs: 20000,
        isPlaying: true,
      );
      engine.handleRemoteEvent(event);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(appliedState.positionMs, 0); // not applied
    });
  });

  group('SyncEvent', () {
    test('isPlaybackEvent', () {
      const play = SyncEvent(type: SyncEventType.play, roomId: 'r', userId: 'u', timestamp: 0);
      const pause = SyncEvent(type: SyncEventType.pause, roomId: 'r', userId: 'u', timestamp: 0);
      const ping = SyncEvent(type: SyncEventType.ping, roomId: 'r', userId: 'u', timestamp: 0);
      expect(play.isPlaybackEvent, true);
      expect(pause.isPlaybackEvent, true);
      expect(ping.isPlaybackEvent, false);
    });
  });
}
