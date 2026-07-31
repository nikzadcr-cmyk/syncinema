import 'dart:developer' as dev;

enum LogLevel { debug, info, warning, error }

class AppLogger {
  static const String _name = 'Syncinema';
  static bool enabled = true;
  
  static void debug(String message, {Object? data, StackTrace? stack}) {
    _log(LogLevel.debug, message, data: data, stack: stack);
  }
  
  static void info(String message, {Object? data}) {
    _log(LogLevel.info, message, data: data);
  }
  
  static void warning(String message, {Object? data, StackTrace? stack}) {
    _log(LogLevel.warning, message, data: data, stack: stack);
  }
  
  static void error(String message, {Object? error, StackTrace? stack}) {
    _log(LogLevel.error, message, data: error, stack: stack);
  }
  
  static void _log(LogLevel level, String message, {Object? data, StackTrace? stack}) {
    if (!enabled) return;
    final prefix = '[${level.name.toUpperCase()}]';
    dev.log('$prefix $message ${data != null ? '| $data' : ''}',
        name: _name,
        error: data is Exception || data is Error ? data : null,
        stackTrace: stack,
        level: _levelToInt(level));
  }
  
  static int _levelToInt(LogLevel level) {
    switch (level) {
      case LogLevel.debug: return 500;
      case LogLevel.info: return 800;
      case LogLevel.warning: return 900;
      case LogLevel.error: return 1000;
    }
  }
}
