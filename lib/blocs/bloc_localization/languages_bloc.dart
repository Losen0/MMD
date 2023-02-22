import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/helpers/localization_helper.dart';

part 'languages_event.dart';
part 'languages_state.dart';

class LanguagesBloc extends Bloc<LanguagesEvent, LanguagesState> {
  LanguagesBloc() : super(LanguagesInitialState()) {
    on<LoadLanguageEvent>((event, emit) async {
      int language = await LocalizationHelper().getCachedAppLanguage() ?? 1;
      Locale locale = appLanguages[AppLanguages.values[language]] as Locale;
      if (kDebugMode) print(locale);
      emit(LanguagesLoadedState(locale: locale, currLanguage: language));
    });
    on<ChangeLanguageEvent>((event, emit) async {
      int newIndex = event.currentIndex;
      //newIndex == 1 ? newIndex = 0 : newIndex = 1;
      await LocalizationHelper().cacheLanguage(newIndex);
      Locale locale = event.locale;

      emit(LanguagesLoadedState(locale: locale, currLanguage: newIndex));
    });
  }
}
