import 'package:flutter/material.dart';
import 'package:todo_app/resources/app_numbers.dart';

import 'color_resources.dart';

enum AppTheme {
  lightTheme,
  darkTheme;
}

final appTheme = {
  /// App Light Theme
  /// start
  AppTheme.lightTheme: ThemeData(
    ///App Main Theme Secondary then Primary Color
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
    scaffoldBackgroundColor: ColorManager.primary,

    ///Bottom App Bar theme
    bottomAppBarColor: ColorManager.primary,

    ///Navigation Bar Theme
    navigationBarTheme:
        const NavigationBarThemeData(backgroundColor: ColorManager.white),

    ///Card THeme
    cardTheme: const CardTheme(color: ColorManager.secondary),

    ///SnackBar Theme
    ///start
    snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorManager.secondary,
        contentTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        )),

    ///end snackBar theme

    /// App Text themes
    /// start
    textTheme: const TextTheme(
      ///for Splash Screen texts
      ///start
      displayLarge: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size13,
          fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size10,
          fontWeight: FontWeight.bold),

      ///end Splash Screen texts

      ///Pages texts themes
      ///start
      labelLarge: TextStyle(
          color: ColorManager.secondary,
          fontSize: AppSizes.size14,
          fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          color: ColorManager.secondary,
          fontSize: AppSizes.size9,
          fontWeight: FontWeight.bold),

      /// end Pages texts themes

      /// Task Card Texts Theme
      /// start
      bodyLarge: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size10,
          fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size7,
          fontWeight: FontWeight.w300),

      /// end Task Card Texts Theme
      bodyMedium: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size6,
          fontWeight: FontWeight.bold),

      displaySmall: TextStyle(
          color: ColorManager.white, fontSize: 15, fontWeight: FontWeight.bold),

      labelSmall: TextStyle(
          color: ColorManager.white, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.secondary,
    ),

    ///end text Themes
  ),

  ///end App Light Theme

  ///*********************Dark Theme************************//
  ///start
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

      ///***************Text Theme*************
      textTheme: const TextTheme(
        ///for Splash Screen texts
        displayLarge: TextStyle(
            color: ColorManager.white,
            fontSize: AppSizes.size13,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            color: ColorManager.white,
            fontSize: AppSizes.size10,
            fontWeight: FontWeight.bold),

        ///***************************************///
        displaySmall: TextStyle(
            color: ColorManager.white,
            fontSize: 12,
            fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(
            color: ColorManager.white,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(
            color: ColorManager.white,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            color: ColorManager.white,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
            color: ColorManager.white,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
            color: ColorManager.white,
            fontSize: 12,
            fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
            color: ColorManager.white,
            fontSize: 16,
            fontWeight: FontWeight.bold),

        labelLarge: TextStyle(
            color: ColorManager.white,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
            color: ColorManager.white,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        labelSmall: TextStyle(
            color: ColorManager.white,
            fontSize: 24,
            fontWeight: FontWeight.bold),
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

  ///end App Dark Theme
};
