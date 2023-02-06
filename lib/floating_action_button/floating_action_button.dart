import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Helper/local_database_helper.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/todo/tasks.dart';
import '../resources/color_resources.dart';
import '../resources/text_resource.dart';
import '../resources/themes.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  TextEditingController _title = TextEditingController();
  TextEditingController _discription = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  void _onSave(String title, String discription) async {
    final bool isValid = _globalKey.currentState!.validate();
    //close the keyboard if it still open
    if (isValid) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt('id') ?? 0;
      var Task =
          todoTask(id: id, title: title, discription: discription, complete: 0);

      print(title);
      print(discription);
      _globalKey.currentState!.save();
      id++;
      prefs.setInt('id', id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _space = SizedBox(
      height: 5,
    );
    //final _provider = Provider.of<TasksProvider>(context);
    final _provider2 = Provider.of<Themes>(context);
    return Form(
      key: _globalKey,
      child: Card(
        elevation: 20,
        color: _provider2.theme
            ? ColorManager.primary
            : ColorManager.sheetModelColorDarkMode,
        shadowColor: ColorManager.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                SizedBox(
                  height: 5,
                ),
                _space,
                Text(
                  AppStrings.todoTitle,
                  style: Theme.of(context).textTheme.headline6,
                ),
                _space,

// Form(key:_globalKey,child: child),
                TextFormField(
                  controller: _title,
                  validator: (value) {
                    //create messages content to show valid text
                    if (value == null || value.isEmpty) return "Enter title";
                  },
                  style: Theme.of(context).textTheme.subtitle2,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.secondary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorManager.secondary, width: 3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: AppStrings.todoTitle2,
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ColorManager.secondary, width: 3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                _space,
                _space,
                Text(
                  AppStrings.Task,
                  style: Theme.of(context).textTheme.headline6,
                ),
                _space,

                TextFormField(
                  controller: _discription,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Discription can't be empty";
                  },
                  style: Theme.of(context).textTheme.subtitle2,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.secondary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorManager.secondary, width: 3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: AppStrings.Task2,
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ColorManager.secondary, width: 3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
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
                          _onSave(_title.text, _discription.text);
                          setState(() => {});
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
      ),
    );
  }
}
