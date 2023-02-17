import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc_database/bloc_database_bloc.dart';
import 'package:todo_app/floating_action_button/floating_action_button.dart';
import 'package:todo_app/home_page/search_delegate_bar.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/color_resources.dart';
import 'package:todo_app/resources/image_assets.dart';
import 'package:todo_app/resources/text_resource.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';
import '../todo_model/tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// this flagForHomeStyle is to change from list mode to grid mode ant the opposite
  bool flagForHomeStyle = true;

  /// the next variables is used for taking Spaces in the home page using SizedBox widget
  static const SizedBox _space16 = SizedBox(height: AppSizes.size6);

  ///Leading Icon in the first line of the home Page "List Or Grid " Icons
  Widget _leadingMenuIcon() {
    return InkWell(
      onTap: () {
        setState(() {
          flagForHomeStyle = !flagForHomeStyle;
        });
      },
      child: flagForHomeStyle
          ? ImageIcon(
              AssetImage(ImageAssets.menuIcon),
              size: AppSizes.size15,
            )
          : const Icon(
              Icons.menu,
              size: AppSizes.size15,
            ),
    );
  }

  /// this is for the Search Icon Button which trigger the Search context
  Widget _searchIconButton(List<ToDoTask> bloc) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: Search(allTasks: bloc),
        );
      },
      icon: const Icon(
        Icons.search,
      ),
    );
  }

  /// the following is to for Texts in HomePage
  Widget _text(String txt, bool align, [TextStyle? textStyle]) {
    return FittedBox(
        alignment: align ? Alignment.centerLeft : Alignment.center,
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.num3),
          child: Text(
            txt,
            style: textStyle ?? Theme.of(context).textTheme.labelLarge,
          ),
        ));
  }

  /// The next is the Row which contain the menu icon the title and the Search icon
  Widget _firstLineOfHomePageRowWidget(List<ToDoTask> bloc) {
    return Expanded(
      flex: AppSizesInt.num1,
      child: Row(
        children: [
          _leadingMenuIcon(),
          const Spacer(),
          _text(AppStrings.title, false),
          const Spacer(),
          _searchIconButton(bloc),
        ],
      ),
    );
  }

  /// List View Option to view tasks in the style of a list "one task per Row"
  Widget _listViewOption(List<ToDoTask> bloc) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemExtent: 100,
      itemCount: bloc.length,
      itemBuilder: (context, ind) => SizedBox(
        height: 100,
        width: 200,
        child: Card(
          // color: ColorManager.secondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(ImageAssets.checkBoxIcon),
                  size: AppSizes.size13,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _text(bloc[ind].title, false,
                      Theme.of(context).textTheme.bodyLarge),
                  _text('   ${bloc[ind].discription}', false,
                      Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const Spacer(),
              IconButton(
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
            ],
          ),
        ),
      ),
    );
  }

  /// Grid View Option to view tasks in the style of a grid "two task per Row"
  Widget _gridViewOption(List<ToDoTask> bloc) {
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
            header: _text(bloc[index].title, false,
                Theme.of(context).textTheme.bodyLarge),
            footer: Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage(ImageAssets.checkBoxIcon),
                    size: 30,
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
            child: _text(bloc[index].discription, false,
                Theme.of(context).textTheme.bodySmall),
          ),
        ),
      ),
    );
  }

  ///Home Page Tasks View Options
  Widget _tasksViewInHomePage(List<ToDoTask> bloc) {
    return Expanded(
      flex: AppSizesInt.size3,
      child: SizedBox(
        height: AppNumbers.homePageTasksListHeight,
        child: flagForHomeStyle ? _listViewOption(bloc) : _gridViewOption(bloc),
      ),
    );
  }

  /// Floating Action Button Widget
  Widget _floatingActionButton() {
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
        size: AppSizes.size28,
        color: ColorManager.secondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ///*******In this page we have used the DatabaseBloc to manage its States**********
    ///the page will be built if one of the following states is emitted
    ///1.LoadedDatabaseState
    ///2.DeletedSuccessfullyState
    return BlocProvider<DatabaseBloc>(
      create: (context) => DatabaseBloc()..add(GetLocalDatabaseEvent()),
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          late List<ToDoTask> bloc;
          if (state is LoadedDatabaseState) bloc = state.list;
          if (state is DeletedSuccessfullyState) bloc = state.list;
          if (state is LoadedDatabaseState ||
              state is DeletedSuccessfullyState) {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppNumbers.homePagePaddingLeft,
                      AppNumbers.homePagePaddingTop,
                      AppNumbers.homePagePaddingRight,
                      AppNumbers.homePagePaddingBottom),

                  /// the following colum contains three main items 1. row containing (icon,txt,icon)
                  /// 2.text
                  /// 3.tasks view(list Or grid)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _firstLineOfHomePageRowWidget(bloc),
                      const SizedBox(height: AppSizes.size13),
                      Expanded(
                          flex: AppSizesInt.num1,
                          child: _text(AppStrings.openingSentence, true,
                              Theme.of(context).textTheme.labelMedium)),
                      _space16,
                      _tasksViewInHomePage(bloc),
                      // Spacer(),
                    ],
                  ),
                ),
                floatingActionButton: _floatingActionButton(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: const BottomBarForNavigation(),
              ),
            );
          }

          /// if nothing of the previous states is emitted
          return const Center(
              child: SizedBox(
                  height: AppSizes.size28,
                  width: AppSizes.size28,
                  child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
