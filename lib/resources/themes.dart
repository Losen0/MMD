import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/resources/color_resources.dart';

class Themes extends ChangeNotifier {
  late bool theme;
  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theme = prefs.getBool('state') ?? true;
    change(theme);
  }

  ThemeMode themeMode = ThemeMode.light;
  void change(bool isOn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    theme = isOn ? false : true;
    if (isOn) {
      prefs.setBool('state', true);
    } else {
      prefs.setBool('state', false);
    }
    print(themeMode);
    notifyListeners();
  }

  static final darkTheme = ThemeData(
      dialogBackgroundColor: ColorManager.darkGrey,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ColorManager.darkPrimary,
      ),
      cardTheme: CardTheme(
        color: ColorManager.darkGrey,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
      ),
      scaffoldBackgroundColor: ColorManager.darkPrimary,
      textTheme: const TextTheme(
        headline1: TextStyle(
            color: ColorManager.white,
            fontSize: 32,
            fontWeight: FontWeight.bold),
        bodyText1: TextStyle(
            color: ColorManager.white,
            fontSize: 20,
            fontWeight: FontWeight.w400),
        bodyText2: TextStyle(color: ColorManager.secondary, fontSize: 16),
        headline2: TextStyle(color: ColorManager.secondary, fontSize: 32),
        subtitle1: TextStyle(
            color: ColorManager.white,
            fontWeight: FontWeight.bold,
            fontSize: 24),
        subtitle2: TextStyle(
          color: ColorManager.black,
          fontSize: 15,
        ),
        headline6: TextStyle(
            color: ColorManager.black,
            fontSize: 15,
            fontWeight: FontWeight.bold),
        //  bodySmall: TextStyle(color: ColorManager.black, fontSize: 15),
      ),
      iconTheme: IconThemeData(
        color: ColorManager.white,
      ),
      snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: ColorManager.secondary,
          contentTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )));
  static final lightTheme = ThemeData(
    dialogBackgroundColor: ColorManager.secondary,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ColorManager.white,
    ),
    cardTheme: CardTheme(
      color: ColorManager.secondary,
    ),
    snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorManager.secondary,
        contentTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        )),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
    ),
    scaffoldBackgroundColor: ColorManager.primary,
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: ColorManager.secondary,
          fontSize: 32,
          fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          color: ColorManager.secondary,
          fontSize: 20,
          fontWeight: FontWeight.w400),
      bodyText2: TextStyle(color: ColorManager.primary, fontSize: 16),
      subtitle1: TextStyle(
          color: ColorManager.primary,
          fontWeight: FontWeight.bold,
          fontSize: 24),
      subtitle2: TextStyle(
        color: ColorManager.black,
        fontSize: 15,
      ),
      headline6: TextStyle(
          color: ColorManager.grey2, fontSize: 15, fontWeight: FontWeight.bold),
      //  bodySmall: TextStyle(color: ColorManager.black, fontSize: 15),
    ),
    iconTheme: IconThemeData(
      color: ColorManager.secondary,
    ),
  );
}
