import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/modes_provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/resources/color_resources.dart';
import 'package:todo_app/resources/image_assets.dart';
import 'package:todo_app/resources/text_resource.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int statee = 0;
  TextEditingController _title = TextEditingController();

  TextEditingController _discrip = TextEditingController();

  int _selectedpageindex = 0;
  static const SizedBox _space = SizedBox(
    height: 5,
  );
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<Modes>(context);
    final _provider2 = Provider.of<TasksProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (statee == 0)
                            statee = 1;
                          else
                            statee = 0;
                          print(statee);
                        });
                      },
                      child: statee == 1
                          ? ImageIcon(
                              AssetImage(ImageAssets.menuIcon),
                              size: 30,
                            )
                          : Icon(
                              Icons.menu,
                              size: 30,
                            ),
                    ),
                    Spacer(),
                    Text(
                      AppStrings.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  AppStrings.openingSentence,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              _space,
              _space,
              _space,
              Expanded(
                flex: 10,
                child: SizedBox(
                  height: 450,
                  child: statee == 0
                      ? ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemExtent: 100,
                          itemCount: _provider2.getTasks().length,
                          itemBuilder: (context, ind) => SizedBox(
                            height: 100,
                            width: 200,
                            child: Card(
                              color: ColorManager.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  _provider2.getTasks()[ind].title,
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: _provider2.getTasks().length,
                          itemBuilder: (BuildContext context, int index) =>
                              Card(
                            color: ColorManager.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: GridTile(
                              header: Text(
                                _provider2.getTasks()[index].title,
                                style: TextStyle(fontSize: 40),
                              ),
                              child: Center(
                                child: Text(
                                  _provider2.getTasks()[index].discription,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              footer: Row(
                                children: [
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete_outline_outlined,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              builder: (context) {
                return Card(
                  elevation: 20,
                  shadowColor: ColorManager.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              color: ColorManager.darkPrimary,
                              height: 3,
                              width: 150,
                            ),
                          ),
                          _space,
                          _space,
                          Text(
                            AppStrings.todoTitle,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          _space,
                          TextFrom(
                            hint: AppStrings.todoTitle2,
                          ),
                          _space,
                          _space,
                          Text(
                            AppStrings.Task,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          _space,
                          TextFrom(
                            hint: AppStrings.Task2,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _provider2.addToList(
                                        _title.text, _discrip.text);
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(fontSize: 30),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(
            Icons.add_circle,
            size: 60,
            color: ColorManager.secondary,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
            // color: ColorManager.black,
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
                    icon: _provider.ModeState == 0
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
                      print("hello");
                      if (_provider.ModeState == 0) {
                        _provider.setToDark();
                        print("provider  ${_provider.ModeState}");
                      } else {
                        _provider.setToLight();
                        print("MY NAME is SAM ${_provider.ModeState}");
                      }
                      setState(() {
                        _selectedpageindex = 1;
                      });
                    },
                    label: Text(''),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFrom extends StatelessWidget {
  late String hint;
  TextFrom({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.subtitle2,
      enableSuggestions: true,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.secondary),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.secondary, width: 3),
          borderRadius: BorderRadius.circular(5),
        ),
        errorStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.subtitle2,
        fillColor: Colors.white,
        filled: true,
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.secondary, width: 3),
          borderRadius: BorderRadius.circular(5),
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
            color:
                isSelected == 1 ? ColorManager.secondary : ColorManager.grey1,
            size: 35,
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 10,
                color: isSelected == 1
                    ? ColorManager.secondary
                    : ColorManager.grey1,
              ),
            ))
      ],
    );
  }
}
