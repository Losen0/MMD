import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/bloc_database/bloc_database_bloc.dart';
import 'package:todo_app/models/task_model/tasks.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/image_assets.dart';
import 'package:todo_app/resources/text_resource.dart';
import 'package:todo_app/ui/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:todo_app/ui/home_page/widgets/home_page_widgets.dart';
import 'package:todo_app/ui/home_page/widgets/search_delegate_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///object from the widgets class
  final HomePageWidgets _homePageWidgets = HomePageWidgets();

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

  /// The next is the Row which contain the menu icon the title and the Search icon
  Widget _firstLineOfHomePageRowWidget(List<ToDoTask> bloc) {
    return Expanded(
      flex: AppSizesInt.num1,
      child: Row(
        children: [
          _leadingMenuIcon(),
          const Spacer(),
          _homePageWidgets.text(AppStrings.title, false),
          const Spacer(),
          _searchIconButton(bloc),
        ],
      ),
    );
  }

  ///Home Page Tasks View Options
  Widget _tasksViewInHomePage(List<ToDoTask> bloc) {
    return Expanded(
      flex: AppSizesInt.size3,
      child: SizedBox(
        height: AppNumbers.homePageTasksListHeight,
        child: flagForHomeStyle
            ? _homePageWidgets.listViewOption(bloc)
            : _homePageWidgets.gridViewOption(bloc),
      ),
    );
  }

  ///***********************************Main Build Widget*************************//
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
                          child: _homePageWidgets.text(
                              AppStrings.openingSentence,
                              true,
                              Theme.of(context).textTheme.labelMedium)),
                      _space16,
                      bloc.isEmpty
                          ? Expanded(
                              flex: AppSizesInt.size1,
                              child: _homePageWidgets.text(
                                  AppStrings.databaseEmptyResponse,
                                  false,
                                  Theme.of(context).textTheme.labelLarge),
                            )
                          : _tasksViewInHomePage(bloc),
                    ],
                  ),
                ),
                floatingActionButton: _homePageWidgets.floatingActionButton(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: const BottomBarForNavigation(),
              ),
            );
          }

          /// if nothing of the previous states is emitted
          return const Center(
              child: SizedBox(
                  height: AppSizes.size38,
                  width: AppSizes.size38,
                  child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
