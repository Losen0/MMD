import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/splash_screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc_theme_mode_classes/theme_mode_bloc.dart';

void main() async {
  WidgetsFlutterBinding();
  // Bloc.observer = MyBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeModeBloc()..add(GetCurrentThemeEvent()),
      child:
          BlocBuilder<ThemeModeBloc, ThemeModeState>(builder: (context, state) {
        if (state is LoadedThemeState) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: (BuildContext context, Widget? child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              home: const SplashScreen(),
            ),
          );
        }
        return const Center(
            child: SizedBox(
                height: 100, width: 50, child: CircularProgressIndicator()));
      }),
    );
  }
}
