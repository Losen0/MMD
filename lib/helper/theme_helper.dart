import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

///this is to help in setting and getting the value to and from SharedPreferences
class ThemeCashHelper {
  ///this Method is for making a SharedPreferences instance
  Future<SharedPreferences> getShared() async {
    return await SharedPreferences.getInstance();
  }

  ///this Method is for setting the new value into SharedPreferences
  Future<void> cacheThemeMode(int themeMode) async {
    final prefs = await getShared();
    prefs.setInt("ThemeMode", themeMode);
    if (kDebugMode) {
      print("CAshed");
    }
  }

  ///this Method is for getting the new value from SharedPreferences
  Future<int?> getCachedThemeMode() async {
    final SharedPreferences prefs = await getShared();
    return prefs.getInt('ThemeMode');
  }
}
