import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/blocs/bloc_localization/languages_bloc.dart';
import 'package:todo_app/blocs/bloc_theme_mode_classes/theme_mode_bloc.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/ui/splash_screen/splash_screen.dart';

import 'models/localizatoin_model/localization.dart';

void main() async {
  WidgetsFlutterBinding();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ///wrapped with Theme builder to manage the app theme Mode
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeModeBloc()..add(GetCurrentThemeEvent()),
        ),
        BlocProvider(
          create: (context) => LanguagesBloc()..add(LoadLanguageEvent()),
        ),
      ],
      child: BlocBuilder<LanguagesBloc, LanguagesState>(
        builder: (context, state) {
          final Locale locale;
          if (state is LanguagesLoadedState) {
            locale = state.locale;
            return BlocBuilder<ThemeModeBloc, ThemeModeState>(
                builder: (context, state) {
              if (state is LoadedThemeState) {
                return ScreenUtilInit(
                  designSize: const Size(
                      AppNumbers.screenUtilHeight, AppNumbers.screenUtilWidth),
                  builder: (BuildContext context, Widget? child) => MaterialApp(
                    locale: locale,
                    localizationsDelegates: const [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en', 'US'), // English
                      Locale('ar'), // Arabic
                    ],
                    debugShowCheckedModeBanner: false,
                    theme: state.themeData,
                    home: const SplashScreen(),
                  ),
                );
              }

              ///**** if something went wrong with the theme bloc this circular indicator will work
              return const Center(
                child: SizedBox(
                  height: AppNumbers.mainPageSizedBoxHeight,
                  width: AppNumbers.mainPageSizedBoxWidth,
                  child: CircularProgressIndicator(),
                ),
              );
            });
          } else {
            return Container(
                color: Colors.white,
                child: const Center(
                    child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator())));
          }
        },
      ),
    );
  }
}
