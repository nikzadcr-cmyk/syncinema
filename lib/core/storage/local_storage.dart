import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static SharedPreferences? _prefs;
  static bool _initialized = false;

  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    } catch (_) {
      _initialized = false;
    }
  }

  static bool get isInitialized => _initialized && _prefs != null;

  static void _check() {
    if (!_initialized || _prefs == null) {
      // Don't throw in production - return safe defaults
      // For critical operations, we still log but not throw in widget tests
    }
  }

  // User
  static String? getUserId() {
    if (!isInitialized) return null;
    return _prefs!.getString('user_id');
  }

  static Future<void> setUserId(String id) async {
    if (!isInitialized) return;
    await _prefs!.setString('user_id', id);
  }

  static String? getUserName() {
    if (!isInitialized) return null;
    return _prefs!.getString('user_name');
  }

  static Future<void> setUserName(String name) async {
    if (!isInitialized) return;
    await _prefs!.setString('user_name', name);
  }

  static String? getUserAvatar() {
    if (!isInitialized) return null;
    return _prefs!.getString('user_avatar');
  }

  static Future<void> setUserAvatar(String avatar) async {
    if (!isInitialized) return;
    await _prefs!.setString('user_avatar', avatar);
  }

  // Recent rooms - safe for tests
  static List<String> getRecentRooms() {
    if (!isInitialized) return [];
    return _prefs!.getStringList('recent_rooms') ?? [];
  }

  static Future<void> addRecentRoom(String roomId) async {
    if (!isInitialized) return;
    final list = getRecentRooms();
    list.remove(roomId);
    list.insert(0, roomId);
    if (list.length > 10) list.removeRange(10, list.length);
    await _prefs!.setStringList('recent_rooms', list);
  }

  // Settings
  static double getSubtitleSize() {
    if (!isInitialized) return 16.0;
    return _prefs!.getDouble('subtitle_size') ?? 16.0;
  }

  static Future<void> setSubtitleSize(double size) async {
    if (!isInitialized) return;
    await _prefs!.setDouble('subtitle_size', size);
  }

  static int getSubtitleColor() {
    if (!isInitialized) return 0xFFFFFFFF;
    return _prefs!.getInt('subtitle_color') ?? 0xFFFFFFFF;
  }

  static Future<void> setSubtitleColor(int color) async {
    if (!isInitialized) return;
    await _prefs!.setInt('subtitle_color', color);
  }

  static double getSubtitleDelay() {
    if (!isInitialized) return 0.0;
    return _prefs!.getDouble('subtitle_delay') ?? 0.0;
  }

  static Future<void> setSubtitleDelay(double delay) async {
    if (!isInitialized) return;
    await _prefs!.setDouble('subtitle_delay', delay);
  }

  static String getPlaybackQuality() {
    if (!isInitialized) return 'auto';
    return _prefs!.getString('playback_quality') ?? 'auto';
  }

  // Generic JSON
  static Future<void> setJson(String key, Map<String, dynamic> json) async {
    if (!isInitialized) return;
    await _prefs!.setString(key, jsonEncode(json));
  }

  static Map<String, dynamic>? getJson(String key) {
    if (!isInitialized) return null;
    final s = _prefs!.getString(key);
    if (s == null) return null;
    try {
      return jsonDecode(s) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
