import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/bloc_database/bloc_database_bloc.dart';
import 'package:todo_app/models/task_model/tasks.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/color_resources.dart';
import 'package:todo_app/resources/text_resource.dart';
import 'package:todo_app/ui/floating_action_button/widgets/floating_action_button_widgets.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  ///the following variables are to control TextFormFields , check if they are filled and use its data
  final TextEditingController _title = TextEditingController();
  final TextEditingController _discription = TextEditingController();

  /// this variable is to control the form and trigger the validation for all TextFormFields
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  ///Use the following to make frequent height Spaces
  SizedBox space = const SizedBox(height: AppSizes.num5);
  SizedBox space10 = const SizedBox(height: AppSizes.size3);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DatabaseBloc>(
      create: (context) => DatabaseBloc()..add(GetLocalDatabaseEvent()),
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          late List<ToDoTask> bloc;
          if (state is LoadedDatabaseState) bloc = state.list;
          if (state is DeletedSuccessfullyState) bloc = state.list;
          return Form(
            key: _globalKey,
            child: Card(
              elevation: AppSizes.size8,
              shadowColor: ColorManager.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.size3)),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.num5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///this is to start the card with a centered line
                      const Center(
                          child: Divider(
                        height: AppSizes.num3,
                        thickness: AppSizes.num5,
                        indent: AppSizes.size48,
                        endIndent: AppSizes.size48,
                      )),
                      const SizedBox(height: AppSizes.size3),

                      ///Title for the First TextFormField
                      FloatingActionButtonWidgets.text(AppStrings.todoTitle,
                          true, Theme.of(context).textTheme.labelSmall),
                      space,

                      ///First TextFormField to put Task Title
                      TextFormField(
                        controller: _title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter title";
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.displaySmall,
                        enableSuggestions: true,
                        decoration: FloatingActionButtonWidgets
                            .inputDecorationForTextFormFields(
                                AppStrings.todoTitle2,
                                Theme.of(context).textTheme.displaySmall),
                      ),
                      space10,

                      ///Title for the Second TextFormField
                      FloatingActionButtonWidgets.text(AppStrings.task, true,
                          Theme.of(context).textTheme.labelSmall),
                      space,

                      ///Second TextFormField to put Task discription
                      TextFormField(
                        controller: _discription,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Discription can't be empty";
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.displaySmall,
                        enableSuggestions: true,
                        decoration: FloatingActionButtonWidgets
                            .inputDecorationForTextFormFields(AppStrings.task2,
                                Theme.of(context).textTheme.displaySmall),
                      ),
                      const SizedBox(height: AppSizes.size13),

                      ///******Button to submit new task
                      Center(
                        child: SizedBox(
                          width: AppSizes.size190,
                          height: AppSizes.size28,
                          child: ElevatedButton(
                              onPressed: () {
                                ///this is to check if the TextFormFields is filled and the new Task can be added to database
                                ///and Call DatabaseBloc and Send the new task to it through the AddToDataBaseEvent
                                if (_globalKey.currentState!.validate()) {
                                  int id;
                                  bloc.isEmpty ? id = 0 : id = bloc.last.id + 1;
                                  ToDoTask task = ToDoTask(
                                      id: id,
                                      title: _title.text,
                                      discription: _discription.text,
                                      complete: 0);
                                  context
                                      .read<DatabaseBloc>()
                                      .add(AddToDataBaseEvent(task: task));
                                  _globalKey.currentState!.save();
                                  id++;
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                AppStrings.showModalElevatedButtonText,
                                style: Theme.of(context).textTheme.labelLarge,
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
