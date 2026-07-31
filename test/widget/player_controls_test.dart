import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncinema/features/player/presentation/widgets/player_controls.dart';
import 'package:syncinema/features/player/providers/player_provider.dart';

void main() {
  testWidgets('PlayerControls displays time', (tester) async {
    const state = PlayerState(
      isPlaying: false,
      position: Duration(seconds: 10),
      duration: Duration(minutes: 2),
      speed: 1.0,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlayerControls(
            state: state,
            onPlayPause: () {},
            onSeek: (_) {},
            onSpeed: (_) {},
            onVolume: (_) {},
            onPickFile: () {},
            onPickSubtitle: () {},
            onShowSubSettings: () {},
            onShowAudioTracks: () {},
          ),
        ),
      ),
    );

    expect(find.text('00:10'), findsOneWidget);
    expect(find.text('02:00'), findsOneWidget);
  });

  testWidgets('PlayerControls play button toggles', (tester) async {
    bool played = false;
    const state = PlayerState(isPlaying: false, position: Duration.zero, duration: Duration(minutes: 1));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlayerControls(
            state: state,
            onPlayPause: () => played = true,
            onSeek: (_) {},
            onSpeed: (_) {},
            onVolume: (_) {},
            onPickFile: () {},
            onPickSubtitle: () {},
            onShowSubSettings: () {},
            onShowAudioTracks: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.play_arrow_rounded).first);
    expect(played, true);
  });
}
