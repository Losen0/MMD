import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/resources/localization.dart';

///enum class to help in locals for the app
enum AppLanguages {
  localeArabic,
  localeEnglish,
}

///the next is a map to return a local for the material app locale to use
///we have 2 languages in this app ar for arabic and en for english
final appLanguages = {
  AppLanguages.localeArabic: const Locale('ar', ''),
  AppLanguages.localeEnglish: const Locale('en', 'US'),
};

///this is to help in setting and getting the value to and from SharedPreferences
class LocalizationHelper {
  ///this Method is for making a SharedPreferences instance
  Future<SharedPreferences> getShared() async {
    return await SharedPreferences.getInstance();
  }

  ///this Method is for setting the old value into SharedPreferences
  Future<void> cacheLanguage(int appLanguage) async {
    final prefs = await getShared();
    prefs.setInt(LocalizationKeys.appLanguage, appLanguage);
    if (kDebugMode) {
      print("CAshed");
    }
  }

  ///this Method is for getting the new value from SharedPreferences
  Future<int?> getCachedAppLanguage() async {
    final SharedPreferences prefs = await getShared();
    return prefs.getInt(LocalizationKeys.appLanguage);
  }
}
