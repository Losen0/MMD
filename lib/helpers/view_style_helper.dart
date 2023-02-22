import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/resources/text_resource.dart';

///this is to help in setting and getting the value to and from SharedPreferences
class ViewStyleHelper {
  ///this Method is for making a SharedPreferences instance
  Future<SharedPreferences> getShared() async {
    return await SharedPreferences.getInstance();
  }

  ///this Method is for setting the new value into SharedPreferences
  Future<void> cacheViewStyle(int appViewStyle) async {
    final prefs = await getShared();
    prefs.setInt(AppStrings.appViewStyle, appViewStyle);
    if (kDebugMode) {
      print("appViewStyle");
    }
  }

  ///this Method is for getting the old value from SharedPreferences
  Future<int?> getCachedViewStyle() async {
    final SharedPreferences prefs = await getShared();
    return prefs.getInt(AppStrings.appViewStyle);
  }
}
