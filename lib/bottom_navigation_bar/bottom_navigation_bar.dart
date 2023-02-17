import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc_theme_mode_classes/theme_mode_bloc.dart';
import 'package:todo_app/resources/app_theme.dart';
import '../resources/color_resources.dart';

class BottomBarForNavigation extends StatefulWidget {
  const BottomBarForNavigation({Key? key}) : super(key: key);

  @override
  State<BottomBarForNavigation> createState() => _BottomBarForNavigationState();
}

class _BottomBarForNavigationState extends State<BottomBarForNavigation> {
  var selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final _provider = Provider.of<Themes>(context);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        // color:
        //     _provider.theme ? ColorManager.primary : ColorManager.darkPrimary,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: TextButton.icon(
                //  iconSize: 50.0,
                // padding: EdgeInsets.only(left: 28.0),
                icon: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Icon(
                        Icons.home_outlined,
                        color: selectedPageIndex == 0
                            ? ColorManager.secondary
                            : ColorManager.grey1,
                        size: 35,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 10,
                            color: selectedPageIndex == 0
                                ? ColorManager.secondary
                                : ColorManager.grey1,
                          ),
                        ))
                  ],
                ),
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 0;
                  });
                },
                label: const Text(''),
              ),
            ),
            BlocBuilder<ThemeModeBloc, ThemeModeState>(
              builder: (context, state) {
                if (state is LoadedThemeState) {
                  int themeMode = state.index;
                  return Expanded(
                    child: TextButton.icon(
                      //  iconSize: 50.0,
                      // padding: EdgeInsets.only(left: 28.0),
                      icon: themeMode == 0
                          ? Mode(
                              name: "Night light",
                              isSelected: selectedPageIndex,
                              icon: 1,
                            )
                          : Mode(
                              name: "Day light",
                              isSelected: selectedPageIndex,
                              icon: 0),
                      onPressed: () {
                        if (kDebugMode) {
                          print("MAIN THEME MODE 1 $themeMode");
                        }

                        setState(() {
                          //_bloc.add(OnChange());
                          //  _provider.change(_provider.theme);
                          context.read<ThemeModeBloc>().add(ThemeChangeEvent(
                              theme: AppTheme.values[themeMode]));
                        });
                        if (kDebugMode) {
                          print("MAIN THEME MODE 2 $themeMode");
                        }
                      },
                      label: const Text(''),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Mode extends StatelessWidget {
  final int isSelected;
  final String name;
  final int icon;

  const Mode(
      {Key? key,
      required this.name,
      required this.isSelected,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Icon(
            icon == 0 ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: ColorManager.grey1,
            size: 35,
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 10,
                color: ColorManager.grey1,
              ),
            ))
      ],
    );
  }
}
