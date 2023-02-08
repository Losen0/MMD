import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc_theme_mode_classes/theme_mode_bloc.dart';
import 'Bloc_database/bloc_database_bloc.dart';

void main() async {
  WidgetsFlutterBinding();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseBloc>(
          create: (BuildContext context) =>
              DatabaseBloc()..add(GetLocalDatabaseEvent()),
        ),
        BlocProvider<ThemeModeBloc>(
          create: (context) => ThemeModeBloc()..add(GetCurrentThemeEvent()),
        ),
      ],
      child:
          BlocBuilder<ThemeModeBloc, ThemeModeState>(builder: (context, state) {
        if (state is LoadedThemeState) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: (BuildContext context, Widget? child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              home: const MyHomePage(title: 'Flutterrrr Demo Home Page'),
            ),
          );
        }
        return Container();
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const SafeArea(
      child: Scaffold(
        body: SplashScreen(),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
