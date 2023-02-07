import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/Helper/theme_helper.dart';
import 'package:todo_app/resources/app_theme.dart';

part 'theme_mode_event.dart';
part 'theme_mode_state.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeModeState> {
  int themeState = 0;
  ThemeModeBloc() : super(ThemeModeInitial()) {
    on<ThemeModeEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetCurrentThemeEvent) {
        final themeModeIndex =
            await ThemeCashHelper().getCachedThemeMode() ?? 0;
        themeState = themeModeIndex;
        final themeMode = AppTheme.values
            .firstWhere((element) => element.index == themeModeIndex);
        emit(LoadedThemeState(themeData: appTheme[themeMode] as ThemeData));
      } else if (event is ThemeChangeEvent) {
        var themeModeIndex = event.theme.index;
        themeModeIndex == 0 ? themeModeIndex = 1 : themeModeIndex = 0;
        themeState = themeModeIndex;
        print(themeModeIndex);
        print(appTheme[AppTheme.values[themeModeIndex]]);
        print("CURRENT THEME =${AppTheme.values[themeState]} ");
        await ThemeCashHelper().cacheThemeMode(themeModeIndex);
        emit(LoadedThemeState(themeData: appTheme[event.theme] as ThemeData));
      }
    });
  }
}
