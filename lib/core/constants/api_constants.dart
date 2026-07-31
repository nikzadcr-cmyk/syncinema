class ApiConstants {
  // Deployed backend URL
  static const String prodWsBase = 'wss://syncinema-backend.amirhosin-torkk.workers.dev';
  static const String prodHttpBase = 'https://syncinema-backend.amirhosin-torkk.workers.dev';
  static const String localWsBase = 'ws://localhost:8787';
  
  // Current env - prod deployed
  static const String wsBaseUrl = prodWsBase;
  static const String httpBaseUrl = prodHttpBase;
  
  static const String roomEndpoint = '/room';
  static const String healthEndpoint = '/health';
  
  static String roomWsUrl(String roomId) => '$wsBaseUrl/room/$roomId/websocket';
  static String roomHttpUrl(String roomId) => '$httpBaseUrl/room/$roomId';
  
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

enum AppEnvironment { dev, prod }

class EnvConfig {
  static AppEnvironment env = AppEnvironment.prod;
  static bool get isDev => env == AppEnvironment.dev;
  static String get wsBase => env == AppEnvironment.dev 
      ? ApiConstants.localWsBase 
      : ApiConstants.prodWsBase;
  static String get httpBase => env == AppEnvironment.dev
      ? 'http://localhost:8787'
      : ApiConstants.prodHttpBase;
}
