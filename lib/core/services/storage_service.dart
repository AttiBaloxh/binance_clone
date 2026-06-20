import 'package:shared_preferences/shared_preferences.dart';

/// Abstraction over SharedPreferences for simple key-value storage.
class StorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ──────────────────────────────────────
  // String
  // ──────────────────────────────────────
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  // ──────────────────────────────────────
  // Bool
  // ──────────────────────────────────────
  Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  // ──────────────────────────────────────
  // Int
  // ──────────────────────────────────────
  Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  // ──────────────────────────────────────
  // Double
  // ──────────────────────────────────────
  Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  double? getDouble(String key) => _prefs.getDouble(key);

  // ──────────────────────────────────────
  // StringList
  // ──────────────────────────────────────
  Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // ──────────────────────────────────────
  // Removal
  // ──────────────────────────────────────
  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();

  bool containsKey(String key) => _prefs.containsKey(key);

  // ──────────────────────────────────────
  // Storage Keys
  // ──────────────────────────────────────
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserEmail = 'user_email';
  static const String keyRememberMe = 'remember_me';
  static const String keyThemeMode = 'theme_mode';
  static const String keyCurrency = 'currency';
  static const String keyWatchlist = 'watchlist';
  static const String keyHideBalance = 'hide_balance';
}
