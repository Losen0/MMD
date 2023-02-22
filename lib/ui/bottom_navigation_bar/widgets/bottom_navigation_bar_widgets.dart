import 'package:flutter/material.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/color_resources.dart';

import '../../../models/localizatoin_model/localization.dart';

///This Class is Used to make Icons in BottomNavigationBar
///it takes string and int
enum BottomAppBarIcons {
  homeIcon,
  dayLightIcon,
  nightLightIcon,
}

class IconDependOnMode extends StatelessWidget {
  ///this is the text used under the icon
  final String name;

  ///this variable is used to define which icon the Ui need
  final int iconIndex;

  const IconDependOnMode(
      {Key? key, required this.name, required this.iconIndex})
      : super(key: key);

  ///this List contains all possible icons
  final List<IconData> _iconList = const [
    Icons.home_outlined,
    Icons.light_mode_outlined,
    Icons.dark_mode_outlined
  ];

  ///this list contains all possible colors
  final List<Color> _colorList = const [
    ColorManager.secondary,
    ColorManager.grey1,
    ColorManager.darkGrey,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.num3),
      child: Column(
        children: [
          Expanded(
            flex: AppSizesInt.num3,
            child: Icon(
              _iconList[iconIndex],
              color: _colorList[iconIndex],
              size: AppSizes.size16,
            ),
          ),
          Expanded(
            flex: AppSizesInt.num1,
            child: Text(
              AppLocalization.of(context).getTranslatedValues(name),
              style: TextStyle(
                fontSize: AppSizes.size3,
                color: _colorList[iconIndex],
              ),
            ),
          )
        ],
      ),
    );
  }
}
