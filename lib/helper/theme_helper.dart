import 'package:shared_preferences/shared_preferences.dart';

class ThemeCashHelper {
  Future<SharedPreferences> getShared() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> cacheThemeMode(int themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("ThemeMode", themeMode);
    print("CAshed");
  }

  Future<int?> getCachedThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('ThemeMode');
  }
}
