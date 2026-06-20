import 'package:shared_preferences/shared_preferences.dart';

/// Local data source for auth state persistence.
class AuthLocalDatasource {
  static const _keyIsLoggedIn = 'is_logged_in';
  static const _keyUserEmail = 'user_email';
  static const _keyUserId = 'user_id';

  final SharedPreferences _prefs;

  AuthLocalDatasource(this._prefs);

  Future<void> saveLoginState({
    required String userId,
    required String email,
  }) async {
    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyUserEmail, email);
    await _prefs.setString(_keyUserId, userId);
  }

  bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;
  String? get userEmail => _prefs.getString(_keyUserEmail);
  String? get userId => _prefs.getString(_keyUserId);

  Future<void> clearLoginState() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserEmail);
    await _prefs.remove(_keyUserId);
  }
}
