import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/resources/app_theme.dart';

class ThemeCashHelper {
  Future<SharedPreferences> getShared() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> cacheThemeMode(int themeMode) async {
    final prefs = await getShared();
    prefs.setInt("ThemeMode", themeMode);
  }

  Future<int?> getCachedThemeMode() async {
    final SharedPreferences prefs = await getShared();
    return prefs.getInt('ThemeMode');
  }
}
