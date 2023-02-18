import 'package:flutter/material.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/color_resources.dart';

///This Class is Used to make Icons in BottomNavigationBar
///it takes string and int

class IconDependOnMode extends StatelessWidget {
  ///this is the text used under the icon
  final String name;

  ///this variable is used to define which icon the Ui need
  final int icon;

  const IconDependOnMode({Key? key, required this.name, required this.icon})
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
    ColorManager.grey1,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: AppSizesInt.num3,
          child: Icon(
            _iconList[icon],
            color: _colorList[icon],
            size: AppSizes.size16,
          ),
        ),
        Expanded(
            flex: AppSizesInt.num1,
            child: Text(
              name,
              style: TextStyle(
                fontSize: AppSizes.size3,
                color: _colorList[icon],
              ),
            ))
      ],
    );
  }
}
