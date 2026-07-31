import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static late SharedPreferences _prefs;
  static bool _initialized = false;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  static void _check() {
    if (!_initialized) throw Exception('LocalStorage not initialized');
  }

  // User
  static String? getUserId() {
    _check();
    return _prefs.getString('user_id');
  }

  static Future<void> setUserId(String id) async {
    _check();
    await _prefs.setString('user_id', id);
  }

  static String? getUserName() {
    _check();
    return _prefs.getString('user_name');
  }

  static Future<void> setUserName(String name) async {
    _check();
    await _prefs.setString('user_name', name);
  }

  static String? getUserAvatar() {
    _check();
    return _prefs.getString('user_avatar');
  }

  static Future<void> setUserAvatar(String avatar) async {
    _check();
    await _prefs.setString('user_avatar', avatar);
  }

  // Recent rooms
  static List<String> getRecentRooms() {
    _check();
    return _prefs.getStringList('recent_rooms') ?? [];
  }

  static Future<void> addRecentRoom(String roomId) async {
    _check();
    final list = getRecentRooms();
    list.remove(roomId);
    list.insert(0, roomId);
    if (list.length > 10) list.removeRange(10, list.length);
    await _prefs.setStringList('recent_rooms', list);
  }

  // Settings
  static double getSubtitleSize() {
    _check();
    return _prefs.getDouble('subtitle_size') ?? 16.0;
  }

  static Future<void> setSubtitleSize(double size) async {
    _check();
    await _prefs.setDouble('subtitle_size', size);
  }

  static int getSubtitleColor() {
    _check();
    return _prefs.getInt('subtitle_color') ?? 0xFFFFFFFF;
  }

  static Future<void> setSubtitleColor(int color) async {
    _check();
    await _prefs.setInt('subtitle_color', color);
  }

  static double getSubtitleDelay() {
    _check();
    return _prefs.getDouble('subtitle_delay') ?? 0.0;
  }

  static Future<void> setSubtitleDelay(double delay) async {
    _check();
    await _prefs.setDouble('subtitle_delay', delay);
  }

  static String getPlaybackQuality() {
    _check();
    return _prefs.getString('playback_quality') ?? 'auto';
  }

  // Generic JSON
  static Future<void> setJson(String key, Map<String, dynamic> json) async {
    _check();
    await _prefs.setString(key, jsonEncode(json));
  }

  static Map<String, dynamic>? getJson(String key) {
    _check();
    final s = _prefs.getString(key);
    if (s == null) return null;
    try {
      return jsonDecode(s) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
