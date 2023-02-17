import 'package:flutter/material.dart';

import 'color_resources.dart';

enum AppTheme {
  lightTheme,
  darkTheme;
}

final appTheme = {
  AppTheme.lightTheme: ThemeData(
    bottomAppBarColor: ColorManager.primary,
    dialogBackgroundColor: ColorManager.secondary,
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: ColorManager.white,
    ),
    cardTheme: const CardTheme(
      color: ColorManager.secondary,
    ),
    snackBarTheme: const SnackBarThemeData(
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
    iconTheme: const IconThemeData(
      color: ColorManager.secondary,
    ),
  ),
  AppTheme.darkTheme: ThemeData(
      bottomAppBarColor: ColorManager.darkPrimary,
      // brightness: Brightness.dark,
      dialogBackgroundColor: ColorManager.darkGrey,
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: ColorManager.darkPrimary,
      ),
      cardTheme: const CardTheme(
        color: ColorManager.darkGrey,
      ),
      colorScheme: ColorScheme.fromSwatch(
        //  brightness: Brightness.dark,
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
      iconTheme: const IconThemeData(
        color: ColorManager.white,
      ),
      snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: ColorManager.secondary,
          contentTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ))),
};
