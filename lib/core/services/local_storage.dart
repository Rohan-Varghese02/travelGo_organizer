import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String firstLaunchKey = 'first launch';

  static Future<bool> isFirstLaunch() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(firstLaunchKey) ?? true;
  }

  static Future<void> setFirstLaunch() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(firstLaunchKey, false);
  }
}
