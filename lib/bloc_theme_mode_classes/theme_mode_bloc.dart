import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Helper/theme_helper.dart';
import 'package:todo_app/resources/app_theme.dart';

part 'theme_mode_event.dart';
part 'theme_mode_state.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeModeState> {
  ThemeModeBloc() : super(ThemeModeInitial()) {
    on<ThemeModeEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetCurrentThemeEvent) {
        final themeModeIndex =
            await ThemeCashHelper().getCachedThemeMode() ?? 0;
        final themeMode = AppTheme.values
            .firstWhere((element) => element.index == themeModeIndex);
        emit(LoadedThemeState(
            themeData: appTheme[themeMode] as ThemeData,
            index: themeModeIndex));
      } else if (event is ThemeChangeEvent) {
        var themeModeIndex = event.theme.index;
        themeModeIndex == 0 ? themeModeIndex = 1 : themeModeIndex = 0;
        await ThemeCashHelper().cacheThemeMode(themeModeIndex);
        emit(LoadedThemeState(
            themeData: appTheme[AppTheme.values[themeModeIndex]] as ThemeData,
            index: themeModeIndex));
      }
    });
  }
}
