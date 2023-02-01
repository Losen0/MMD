import 'package:flutter/material.dart';
import 'package:todo_app/resources/color_resources.dart';

class Themes {
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
    ),
    scaffoldBackgroundColor: ColorManager.black,
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: ColorManager.white, fontSize: 32, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(
          color: ColorManager.white, fontSize: 20, fontWeight: FontWeight.w400),
      bodyText2: TextStyle(color: ColorManager.primary, fontSize: 16),
      subtitle1: TextStyle(
          color: ColorManager.white, fontWeight: FontWeight.bold, fontSize: 24),
      subtitle2: TextStyle(
        color: ColorManager.black,
        fontSize: 15,
      ),
      headline6: TextStyle(
          color: ColorManager.black, fontSize: 15, fontWeight: FontWeight.bold),
      //  bodySmall: TextStyle(color: ColorManager.black, fontSize: 15),
    ),
    iconTheme: IconThemeData(
      color: ColorManager.white,
    ),
  );
  static final lightTheme = ThemeData(
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
