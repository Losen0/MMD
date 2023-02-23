import 'package:flutter/material.dart';
import 'package:todo_app/resources/app_numbers.dart';

import 'color_resources.dart';

enum AppTheme {
  lightTheme,
  darkTheme;
}

final appTheme = {
  /// App Light Theme
  AppTheme.lightTheme: ThemeData(
    // useMaterial3: true,

    ///App Main Theme Secondary then Primary Color
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
    scaffoldBackgroundColor: ColorManager.primary,

    ///Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.white,
        textStyle: const TextStyle(
            fontSize: AppSizes.size13, color: ColorManager.secondary),
      ),
    ),

    ///Navigation Bar Theme
    navigationBarTheme:
        const NavigationBarThemeData(backgroundColor: ColorManager.white),

    ///Card THeme
    cardTheme: const CardTheme(color: ColorManager.secondary),

    ///SnackBar Theme
    snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorManager.secondary,
        contentTextStyle: TextStyle(
          fontSize: AppSizes.size5,
          fontWeight: FontWeight.bold,
        )),

    /// App Text themes
    textTheme: const TextTheme(
      ///for translating buttons
      titleSmall: TextStyle(
          color: ColorManager.primary,
          fontSize: AppSizes.size5,
          fontWeight: FontWeight.bold),

      ///for Splash Screen texts
      displayLarge: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size13,
          fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size10,
          fontWeight: FontWeight.bold),

      ///Pages texts themes
      labelLarge: TextStyle(
          color: ColorManager.secondary,
          fontSize: AppSizes.size14,
          fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          color: ColorManager.secondary,
          fontSize: AppSizes.size9,
          fontWeight: FontWeight.bold),

      /// Texts Task Card Theme
      bodyLarge: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size10,
          fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          color: ColorManager.white,
          fontSize: AppSizes.size7,
          fontWeight: FontWeight.w300),

      ///Search Text theme
      bodyMedium: TextStyle(
          color: ColorManager.darkGrey,
          fontSize: AppSizes.size6,
          fontWeight: FontWeight.bold),

      ///modal Bottom Sheet texts
      labelSmall: TextStyle(
          color: ColorManager.primary,
          fontSize: AppSizes.size7,
          fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          color: ColorManager.darkGrey,
          fontSize: AppSizes.size6,
          fontWeight: FontWeight.bold),
    ),

    ///Icon theme
    iconTheme: const IconThemeData(color: ColorManager.secondary),

    ///Divider
    dividerColor: ColorManager.primary,

    ///bottomSheet
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: ColorManager.primary),

    ///bottom APP Bar theme
    bottomAppBarTheme: const BottomAppBarTheme(color: ColorManager.primary),

    ///bottom Navigation Bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorManager.primary),
  ),

  ///end App Light Theme

  ///*********************Dark Theme************************//
  ///start
  AppTheme.darkTheme: ThemeData(
      // useMaterial3: true,

      ///App Main Theme Secondary then Primary Color
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
      scaffoldBackgroundColor: ColorManager.darkPrimary,

      ///Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: ColorManager.secondary,
            textStyle: const TextStyle(
              fontSize: AppSizes.size13,
            )),
      ),

      ///Navigation Bar
      navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: ColorManager.darkPrimary),

      ///Card Theme
      cardTheme: const CardTheme(color: ColorManager.darkGrey),

      ///***************Text Theme*************
      textTheme: const TextTheme(
        ///for translating buttons
        titleSmall: TextStyle(
            color: ColorManager.secondary,
            fontSize: AppSizes.size5,
            fontWeight: FontWeight.bold),

        ///for Splash Screen texts
        displayLarge: TextStyle(
            color: ColorManager.white,
            fontSize: AppSizes.size13,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            color: ColorManager.white,
            fontSize: AppSizes.size10,
            fontWeight: FontWeight.bold),

        ///Pages texts themes
        labelLarge: TextStyle(
            color: ColorManager.primary,
            fontSize: AppSizes.size14,
            fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
            color: ColorManager.primary,
            fontSize: AppSizes.size9,
            fontWeight: FontWeight.bold),

        /// Texts Task Card Theme
        bodyLarge: TextStyle(
            color: ColorManager.white,
            fontSize: AppSizes.size10,
            fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
            color: ColorManager.white,
            fontSize: AppSizes.size7,
            fontWeight: FontWeight.w300),

        ///Search Text theme
        bodyMedium: TextStyle(
            color: ColorManager.primary,
            fontSize: AppSizes.size6,
            fontWeight: FontWeight.bold),

        ///modal Bottom Sheet texts
        labelSmall: TextStyle(
            color: ColorManager.secondary,
            fontSize: AppSizes.size7,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: ColorManager.darkGrey,
            fontSize: AppSizes.size6,
            fontWeight: FontWeight.bold),
      ),

      ///Divider
      dividerColor: ColorManager.secondary,

      ///bottomSheetTheme
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: ColorManager.darkGrey),

      ///Icon Theme
      iconTheme: const IconThemeData(color: ColorManager.white),

      ///SnackBar Theme
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorManager.secondary,
        contentTextStyle: TextStyle(
          fontSize: AppSizes.size5,
          fontWeight: FontWeight.bold,
        ),
      ),

      ///bottom App Bar theme
      bottomAppBarTheme:
          const BottomAppBarTheme(color: ColorManager.darkPrimary),

      ///bottom Navigation Bar theme

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ColorManager.darkPrimary)),

  ///end App Dark Theme
};
