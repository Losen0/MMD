import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/bloc_theme_mode_classes/theme_mode_bloc.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/app_theme.dart';
import 'package:todo_app/resources/text_resource.dart';
import 'package:todo_app/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_widgets.dart';

class BottomBarForNavigation extends StatefulWidget {
  const BottomBarForNavigation({Key? key}) : super(key: key);

  @override
  State<BottomBarForNavigation> createState() => _BottomBarForNavigationState();
}

///this is used to manage the shape and icons of the bottom navigation bar
///the navigation bar consist of only 2 iconButtons --> home , themeMode
class _BottomBarForNavigationState extends State<BottomBarForNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: AppSizes.size38,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: AbsorbPointer(
                child: TextButton.icon(
                  icon: const IconDependOnMode(
                    name: AppStrings.navigationBar1,
                    icon: 0,
                  ),
                  onPressed: () {},
                  label: const Text(''),
                ),
              ),
            ),

            ///using BlocBuilder raped only on the Theme Mode Icon
            BlocBuilder<ThemeModeBloc, ThemeModeState>(
              builder: (context, state) {
                if (state is LoadedThemeState) {
                  int themeMode = state.index;
                  return Expanded(
                    child: TextButton.icon(
                      icon: themeMode == 0
                          ? const IconDependOnMode(
                              name: AppStrings.navigationBar3,
                              icon: 2,
                            )
                          : const IconDependOnMode(
                              name: AppStrings.navigationBar2, icon: 1),
                      onPressed: () {
                        context.read<ThemeModeBloc>().add(
                              ThemeChangeEvent(
                                  theme: AppTheme.values[themeMode]),
                            );
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
