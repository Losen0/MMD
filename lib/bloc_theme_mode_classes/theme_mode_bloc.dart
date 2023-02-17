import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Helper/theme_helper.dart';
import 'package:todo_app/resources/app_theme.dart';

part 'theme_mode_event.dart';
part 'theme_mode_state.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeModeState> {
  ThemeModeBloc() : super(ThemeModeInitial()) {
    ///this is to get the value of the theme from the SharedPreferences  using Theme Helper
    on<ThemeModeEvent>((event, emit) async {
      final themeModeIndex = await ThemeCashHelper().getCachedThemeMode() ?? 0;
      final themeMode = AppTheme.values
          .firstWhere((element) => element.index == themeModeIndex);
      emit(LoadedThemeState(
          themeData: appTheme[themeMode] as ThemeData, index: themeModeIndex));
    });

    ///this is when the theme changes and it put the new value in SharedPreferences using Theme Helper
    on<ThemeChangeEvent>((event, emit) async {
      var themeModeIndex = event.theme.index;
      themeModeIndex == 0 ? themeModeIndex = 1 : themeModeIndex = 0;
      await ThemeCashHelper().cacheThemeMode(themeModeIndex);
      emit(LoadedThemeState(
          themeData: appTheme[AppTheme.values[themeModeIndex]] as ThemeData,
          index: themeModeIndex));
    });
  }
}
