import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncinema/features/room/domain/entities/room.dart';

void main() {
  group('Room flow integration', () {
    test('Room entity copyWith works', () {
      // Actually test real model creation
      final now = DateTime.now();
      final r = Room(id: 'ABC123', name: 'Test', hostId: 'u1', createdAt: now);
      final updated = r.copyWith(name: 'New Name');
      expect(updated.name, 'New Name');
      expect(updated.id, 'ABC123');
    });

    test('Room state transitions', () {
      final room = Room(
        id: 'XYZ789',
        name: 'Movie Night',
        hostId: 'host1',
        createdAt: DateTime.now(),
        state: RoomState.waiting,
      );
      final playing = room.copyWith(state: RoomState.playing);
      expect(playing.state, RoomState.playing);
    });
  });
}
