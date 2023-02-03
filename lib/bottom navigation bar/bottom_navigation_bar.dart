import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/resources/themes.dart';

import '../resources/color_resources.dart';

class BottomBarForNAvigation extends StatefulWidget {
  const BottomBarForNAvigation({Key? key}) : super(key: key);

  @override
  State<BottomBarForNAvigation> createState() => _BottomBarForNAvigationState();
}

class _BottomBarForNAvigationState extends State<BottomBarForNAvigation> {
  var _selectedpageindex = 0;

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<Themes>(context);
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 60,
        color:
            _provider.theme ? ColorManager.primary : ColorManager.darkPrimary,
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
                        color: _selectedpageindex == 0
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
                            color: _selectedpageindex == 0
                                ? ColorManager.secondary
                                : ColorManager.grey1,
                          ),
                        ))
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _selectedpageindex = 0;
                  });
                },
                label: Text(''),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                //  iconSize: 50.0,
                // padding: EdgeInsets.only(left: 28.0),
                icon: _provider.theme
                    ? Mode(
                        name: "Night light",
                        isSelected: _selectedpageindex,
                        icon: 1,
                      )
                    : Mode(
                        name: "Day light",
                        isSelected: _selectedpageindex,
                        icon: 0),
                onPressed: () {
                  setState(() {
                    _provider.change(_provider.theme);
                  });
                },
                label: Text(''),
              ),
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
              style: TextStyle(
                fontSize: 10,
                color: ColorManager.grey1,
              ),
            ))
      ],
    );
  }
}
