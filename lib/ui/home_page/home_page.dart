import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/bloc_database/bloc_database_bloc.dart';
import 'package:todo_app/blocs/bloc_localization/languages_bloc.dart';
import 'package:todo_app/blocs/view_style_bloc/view_style_bloc.dart';
import 'package:todo_app/models/localizatoin_model/localization.dart';
import 'package:todo_app/models/task_model/tasks.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/image_assets.dart';
import 'package:todo_app/resources/localization.dart';
import 'package:todo_app/resources/text_resource.dart';
import 'package:todo_app/ui/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:todo_app/ui/home_page/widgets/home_page_widgets.dart';
import 'package:todo_app/ui/home_page/widgets/search_delegate_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  /// the next variables is used for taking Spaces in the home page using SizedBox widget
  static const SizedBox _space16 = SizedBox(height: AppSizes.size6);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///object from the widgets class
  final HomePageWidgets _homePageWidgets = HomePageWidgets();

  /// this flagForHomeStyle is to change from list mode to grid mode ant the opposite
  late bool flagForHomeStyle;

  late int currentLanguage;

  ///Leading Icon in the first line of the home Page "List Or Grid " Icons
  Widget _leadingMenuIcon() {
    return BlocBuilder<ViewStyleBloc, ViewStyleState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            flagForHomeStyle = !flagForHomeStyle;
            int send = flagForHomeStyle ? 1 : 0;
            BlocProvider.of<ViewStyleBloc>(context)
                .add(ChangeViewStyleEvent(currentStyle: send));
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
      },
    );
  }

  /// this is for the Search Icon Button which trigger the Search context
  Widget _searchIconButton(List<ToDoTask> bloc) {
    return Builder(builder: (context) {
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
    });
  }

  /// The next is the Row which contain the menu icon the title and the Search icon
  Widget _firstLineOfHomePageRowWidget(List<ToDoTask> bloc) {
    return Expanded(
      flex: AppSizesInt.num1,
      child: BlocBuilder<LanguagesBloc, LanguagesState>(
        builder: (context, state) {
          if (state is LanguagesLoadedState) {
            currentLanguage = state.currLanguage;
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                const SizedBox(width: AppSizes.size3),
                Flexible(flex: 2, child: _leadingMenuIcon()),
                const Spacer(),

                Expanded(
                    flex: 4,
                    child: _homePageWidgets.text(AppStrings.title, true)),

                const Spacer(),

                ///Switching Languages
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<LanguagesBloc>(context).add(
                          ChangeLanguageEvent(
                              locale: const Locale('ar', ''), currentIndex: 0));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.size11)),
                      child: SizedBox(
                        height: AppSizes.size14,
                        width: AppSizes.size38,
                        child: Center(
                          child: Text(
                            AppLocalization.of(context)
                                .getTranslatedValues(LocalizationKeys.lang),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(flex: 1, child: _searchIconButton(bloc)),
              ],
            ),
          );
        },
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DatabaseBloc()..add(GetLocalDatabaseEvent()),
        ),
        BlocProvider(
          create: (context) => ViewStyleBloc()..add(LoadViewStyleEvent()),
        )
      ],
      child: BlocBuilder<LanguagesBloc, LanguagesState>(
        builder: (context, state) {
          return BlocBuilder<ViewStyleBloc, ViewStyleState>(
            builder: (context, state) {
              if (state is LoadedViewStyleState) {
                flagForHomeStyle = state.currentStyle == 0 ? true : false;
              }
              return BlocBuilder<DatabaseBloc, DatabaseState>(
                builder: (context, state) {
                  late List<ToDoTask> bloc;
                  if (state is LoadedDatabaseState) {
                    bloc = state.list;
                  }
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
                                      LocalizationKeys.openingSentence,
                                      true,
                                      Theme.of(context).textTheme.labelMedium)),
                              HomePage._space16,
                              bloc.isEmpty
                                  ? Expanded(
                                      flex: AppSizesInt.size1,
                                      child: Center(
                                        child: _homePageWidgets.text(
                                            LocalizationKeys
                                                .databaseEmptyResponse,
                                            true,
                                            Theme.of(context)
                                                .textTheme
                                                .labelLarge),
                                      ),
                                    )
                                  : _tasksViewInHomePage(bloc),
                            ],
                          ),
                        ),
                        floatingActionButton:
                            _homePageWidgets.floatingActionButton(),
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
              );
            },
          );
        },
      ),
    );
  }
}
