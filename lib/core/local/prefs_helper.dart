import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  /// Already become singleton during dependency injection
  // Singleton instance
  // static final PrefsHelper _instance = PrefsHelper._internal();
  //
  // factory PrefsHelper() => _instance;
  //
  // PrefsHelper._internal();

  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ---------------- BOOLEAN ----------------

  Future<bool?> getBoolValue(String key) async {
    await init();
    return _prefs?.getBool(key);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await init();
    await _prefs?.setBool(key, value);
  }

  // ---------------- STRING ----------------

  Future<String?> getStringValue(String key) async {
    await init();
    return _prefs?.getString(key);
  }

  Future<void> setStringValue(String key, String value) async {
    await init();
    await _prefs?.setString(key, value);
  }

  // ---------------- INTEGER (NEW) ----------------

  Future<int?> getIntValue(String key) async {
    await init();
    return _prefs?.getInt(key);
  }

  Future<void> setIntValue(String key, int value) async {
    await init();
    await _prefs?.setInt(key, value);
  }
}
