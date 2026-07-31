import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/room/presentation/pages/create_room_page.dart';
import '../../features/room/presentation/pages/join_room_page.dart';
import '../../features/room/presentation/pages/room_page.dart';
import '../../features/player/presentation/pages/player_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/room/presentation/pages/qr_scanner_page.dart';
import 'transition.dart';
import 'routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        pageBuilder: (context, state) => const PremiumTransition(
          child: HomePage(),
          name: 'home',
        ),
      ),
      GoRoute(
        path: AppRoutes.createRoom,
        name: 'createRoom',
        pageBuilder: (context, state) => const FadeSlideTransition(
          child: CreateRoomPage(),
          name: 'createRoom',
        ),
      ),
      GoRoute(
        path: AppRoutes.joinRoom,
        name: 'joinRoom',
        pageBuilder: (context, state) {
          final roomId = state.uri.queryParameters['roomId'];
          return FadeSlideTransition(
            child: JoinRoomPage(prefilledRoomId: roomId),
            name: 'joinRoom',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.scanQr,
        name: 'scanQr',
        pageBuilder: (context, state) => const FadeSlideTransition(
          child: QrScannerPage(),
          name: 'scanQr',
        ),
      ),
      GoRoute(
        path: '/room/:roomId',
        name: 'room',
        pageBuilder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return PremiumTransition(
            child: RoomPage(roomId: roomId),
            name: 'room',
          );
        },
        routes: [
          GoRoute(
            path: 'player',
            name: 'player',
            pageBuilder: (context, state) {
              final roomId = state.pathParameters['roomId']!;
              return PremiumTransition(
                child: PlayerPage(roomId: roomId),
                name: 'player',
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        pageBuilder: (context, state) => const FadeSlideTransition(
          child: SettingsPage(),
          name: 'settings',
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
              const SizedBox(height: 16),
              Text('Page not found: ${state.uri}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
});
