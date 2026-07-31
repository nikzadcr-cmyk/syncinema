class AppConstants {
  static const String appName = 'Syncinema';
  static const String appNameFa = 'سینکینما';
  static const String appVersion = '1.0.0';
  
  // Sync configuration
  static const Duration syncInterval = Duration(milliseconds: 200);
  static const Duration heartbeatInterval = Duration(seconds: 2);
  static const Duration reconnectDelay = Duration(seconds: 1);
  static const Duration maxDriftThreshold = Duration(milliseconds: 300);
  static const Duration autoSyncThreshold = Duration(milliseconds: 150);
  static const int maxReconnectAttempts = 10;
  
  // Player
  static const Duration controlsHideDuration = Duration(seconds: 3);
  static const Duration seekStep = Duration(seconds: 10);
  static const Duration longSeekStep = Duration(seconds: 30);
  
  // Room
  static const int maxRoomNameLength = 30;
  static const int maxUsersInRoom = 20;
  static const Duration typingIndicatorTimeout = Duration(seconds: 3);
  
  // File Support
  static const List<String> supportedVideoExts = [
    'mp4', 'mkv', 'mov', 'avi', 'webm', 'm4v', '3gp', 'flv', 'wmv'
  ];
  static const List<String> supportedAudioExts = [
    'mp3', 'flac', 'aac', 'ogg', 'wav', 'm4a', 'wma', 'opus', 'aiff'
  ];
  static const List<String> supportedSubtitleExts = [
    'srt', 'vtt', 'ass', 'ssa', 'sub'
  ];

  // Animations
  static const Duration animFast = Duration(milliseconds: 150);
  static const Duration animMedium = Duration(milliseconds: 300);
  static const Duration animSlow = Duration(milliseconds: 500);
  static const Duration animExtraSlow = Duration(milliseconds: 800);
}
