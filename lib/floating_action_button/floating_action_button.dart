import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc_database/bloc_database_bloc.dart';
import '../resources/color_resources.dart';
import '../resources/text_resource.dart';
import '../todo_model/tasks.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _discription = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizedBox space = const SizedBox(
      height: 5,
    );
    //final _provider = Provider.of<TasksProvider>(context);
    return BlocProvider<DatabaseBloc>(
      create: (context) => DatabaseBloc()..add(GetLocalDatabaseEvent()),
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          if (kDebugMode) {
            print(state);
            print("FROM MODAAAAALLL $state");
          }

          late List<ToDoTask> bloc;
          if (state is AddedSuccessfullyState) bloc = state.list;
          if (state is LoadedDatabaseState) bloc = state.list;
          if (state is DeletedSuccessfullyState) bloc = state.list;
          return Form(
            key: _globalKey,
            child: Card(
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
                      const SizedBox(
                        height: 5,
                      ),
                      space,
                      Text(
                        AppStrings.todoTitle,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      space,
                      TextFormField(
                        controller: _title,
                        validator: (value) {
                          //create messages content to show valid text
                          if (value == null || value.isEmpty) {
                            return "Enter title";
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.subtitle2,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: ColorManager.secondary),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorManager.secondary, width: 3),
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
                      space,
                      space,
                      Text(
                        AppStrings.Task,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      space,
                      TextFormField(
                        controller: _discription,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Discription can't be empty";
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.subtitle2,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: ColorManager.secondary),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorManager.secondary, width: 3),
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
                                final bool isValid =
                                    _globalKey.currentState!.validate();
                                if (isValid) {
                                  int id;
                                  if (bloc.isNotEmpty) {
                                    id = bloc.last.id + 1;
                                  } else {
                                    id = 0;
                                  }
                                  ToDoTask task = ToDoTask(
                                      id: id,
                                      title: _title.text,
                                      discription: _discription.text,
                                      complete: 0);
                                  context
                                      .read<DatabaseBloc>()
                                      .add(AddToDataBaseEvent(task: task));
                                  // print(title);
                                  // print(discription);
                                  _globalKey.currentState!.save();
                                  id++;
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
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
        },
      ),
    );
  }
}
