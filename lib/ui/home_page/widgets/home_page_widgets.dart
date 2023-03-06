import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/bloc_database/bloc_database_bloc.dart';
import 'package:todo_app/models/localizatoin_model/localization.dart';
import 'package:todo_app/models/task_model/tasks.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/color_resources.dart';
import 'package:todo_app/resources/image_assets.dart';
import 'package:todo_app/ui/floating_action_button/floating_action_button.dart';

class HomePageWidgets {
  /// the following is to for Texts in HomePage
  Widget text(String txt, bool translate, [TextStyle? textStyle]) {
    return Builder(builder: (context) {
      return FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.num3),
            child: Text(
              translate
                  ? AppLocalization.of(context).getTranslatedValues(txt)
                  : txt,
              style: textStyle ?? Theme.of(context).textTheme.labelLarge,
            ),
          ));
    });
  }

  /// List View Option to view tasks in the style of a list "one task per Row"
  Widget listViewOption(List<ToDoTask> bloc) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.size3),
      itemExtent: AppSizes.size48,
      itemCount: bloc.length,
      itemBuilder: (context, ind) => SizedBox(
        height: AppSizes.size48,
        width: AppSizes.size95,
        child: Card(
          // color: ColorManager.secondary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.size6)),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    context.read<DatabaseBloc>().add(DeletFromDataBaseEvent(
                          task: bloc[ind],
                        ));
                  },
                  icon: ImageIcon(
                    AssetImage(ImageAssets.checkBoxIcon),
                    size: AppSizes.size13,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.size3),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: text(bloc[ind].title, false,
                            Theme.of(context).textTheme.bodyLarge),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: text('   ${bloc[ind].discription}', false,
                            Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    context.read<DatabaseBloc>().add(DeletFromDataBaseEvent(
                          task: bloc[ind],
                        ));
                  },
                  icon: const Icon(
                    Icons.delete_outline_outlined,
                    size: AppSizes.size13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Grid View Option to view tasks in the style of a grid "two task per Row"
  Widget gridViewOption(List<ToDoTask> bloc) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppNumbers.crossAxisCount,
        childAspectRatio: AppNumbers.childAspectRatio,
        crossAxisSpacing: AppNumbers.crossAxisSpacing,
        mainAxisSpacing: AppNumbers.mainAxisSpacing,
      ),
      itemCount: bloc.length,
      itemBuilder: (BuildContext context, int index) => Card(
        // color: ColorManager.secondary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.size6)),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.size2),
          child: GridTile(
            header: Center(
              child: text(bloc[index].title, false,
                  Theme.of(context).textTheme.bodyLarge),
            ),
            footer: Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage(ImageAssets.checkBoxIcon),
                    size: AppSizes.size13,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<DatabaseBloc>().add(DeletFromDataBaseEvent(
                          task: bloc[index],
                        ));
                  },
                  icon: const Icon(
                    Icons.delete_outline_outlined,
                    size: AppSizes.size13,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            child: Center(
              child: text(bloc[index].discription, false,
                  Theme.of(context).textTheme.bodySmall),
            ),
          ),
        ),
      ),
    );
  }

  /// Floating Action Button Widget
  Widget floatingActionButton() {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () async {
          await showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (BuildContext context) {
              return const FloatingButton();
            },
          ).then((value) =>
              context.read<DatabaseBloc>().add(GetLocalDatabaseEvent()));
        },
        child: const Icon(
          Icons.add_circle,
          size: AppSizes.size38,
          color: ColorManager.secondary,
        ),
      );
    });
  }
}
