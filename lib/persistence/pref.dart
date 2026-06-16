import 'package:shared_preferences/shared_preferences.dart';
import 'package:xin_se_cai_ji/common/values/keys.dart';

class PrefUtil {
  static late SharedPreferences _prefs;

  static Future<void> initPref() async {
    _prefs = await SharedPreferences.getInstance();
    // 初始化默认值
    if (!_prefs.containsKey(PrefKeys.firstStart)) {
      await _prefs.setBool(PrefKeys.firstStart, true);
    }
    if (!_prefs.containsKey(PrefKeys.themeMode)) {
      await _prefs.setInt(PrefKeys.themeMode, 0);
    }
    if (!_prefs.containsKey(PrefKeys.lock)) {
      await _prefs.setBool(PrefKeys.lock, false);
    }
    if (!_prefs.containsKey(PrefKeys.fontScale)) {
      await _prefs.setDouble(PrefKeys.fontScale, 1.0);
    }
  }

  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  static T getValue<T>(String key) {
    return _prefs.get(key) as T;
  }

  static Future<void> setValue<T>(String key, T value) async {
    if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is String) {
      await _prefs.setString(key, value);
    }
  }
}
