abstract class AppRoutes {
  static const String home = '/';
  static const String createRoom = '/create-room';
  static const String joinRoom = '/join-room';
  static const String room = '/room/:roomId';
  static const String player = '/room/:roomId/player';
  static const String settings = '/settings';
  static const String scanQr = '/scan-qr';

  static String roomPath(String roomId) => '/room/$roomId';
  static String playerPath(String roomId) => '/room/$roomId/player';
}
