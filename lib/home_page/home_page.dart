import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc_database/bloc_database_bloc.dart';
import 'package:todo_app/floating_action_button/floating_action_button.dart';
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
  int statee = 0;

  static const SizedBox _space = SizedBox(
    height: 5,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DatabaseBloc>(
      create: (context) => DatabaseBloc()..add(GetLocalDatabaseEvent()),
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          if (kDebugMode) {
            print(state);
          }
          late List<ToDoTask> bloc;
          if (state is AddedSuccessfullyState) {
            bloc = state.list;
            if (kDebugMode) {
              print("ADDEDSUCC");
            }
          }
          if (state is LoadedDatabaseState) {
            bloc = state.list;
            if (kDebugMode) {
              print("LOADEDSUCCESS");
            }
          }
          if (state is DeletedSuccessfullyState) {
            bloc = state.list;
            if (kDebugMode) {
              print("DELETED SUCCESS");
            }
          }
          if (state is LoadedDatabaseState ||
              state is AddedSuccessfullyState ||
              state is DeletedSuccessfullyState) {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (statee == 0) {
                                    statee = 1;
                                  } else {
                                    statee = 0;
                                  }
                                  if (kDebugMode) {
                                    print(statee);
                                  }
                                });
                              },
                              child: statee == 0
                                  ? ImageIcon(
                                      AssetImage(ImageAssets.menuIcon),
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.menu,
                                      size: 30,
                                    ),
                            ),
                            const Spacer(),
                            Text(
                              AppStrings.title,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  showSearch(
                                      context: context,
                                      delegate: Search(allTasks: bloc));
                                },
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
                                  padding: const EdgeInsets.all(10),
                                  itemExtent: 100,
                                  itemCount: bloc.length,
                                  itemBuilder: (context, ind) => SizedBox(
                                    height: 100,
                                    width: 200,
                                    child: Card(
                                      // color: ColorManager.secondary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const ImageIcon(
                                              AssetImage('assets/img_4.png'),
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                bloc[ind].title,
                                                style: const TextStyle(
                                                    fontSize: 40),
                                              ),
                                              Text(
                                                "   ${bloc[ind].discription}",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<DatabaseBloc>()
                                                  .add(DeletFromDataBaseEvent(
                                                    task: bloc[ind],
                                                  ));
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
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
                                  itemCount: bloc.length,
                                  itemBuilder:
                                      (BuildContext context, int index) => Card(
                                    // color: ColorManager.secondary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GridTile(
                                        header: Text(
                                          bloc[index].title,
                                          style: const TextStyle(fontSize: 40),
                                        ),
                                        footer: Row(
                                          children: [
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const ImageIcon(
                                                AssetImage('assets/img_4.png'),
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                context
                                                    .read<DatabaseBloc>()
                                                    .add(DeletFromDataBaseEvent(
                                                      task: bloc[index],
                                                    ));
                                              },
                                              icon: const Icon(
                                                Icons.delete_outline_outlined,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            bloc[index].discription,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      // Spacer(),
                    ],
                  ),
                ),
                floatingActionButton: InkWell(
                  onTap: () async {
                    await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (BuildContext context) {
                        return const FloatingButton();
                      },
                    ).then((value) => context
                        .read<DatabaseBloc>()
                        .add(GetLocalDatabaseEvent()));
                  },
                  child: const Icon(
                    Icons.add_circle,
                    size: 60,
                    color: ColorManager.secondary,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: const BottomBarForNavigation(),
              ),
            );
          }
          return const Center(
              child: SizedBox(
                  height: 60, width: 60, child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class Search extends SearchDelegate {
  List<ToDoTask> result = [];
  final List<ToDoTask> allTasks;
  Search({required this.allTasks});
  late List<ToDoTask> xx = allTasks;
  late List<ToDoTask> provider = allTasks;
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (result.isNotEmpty) {
      result.clear();
    }

    String word1 = "";
    String word2 = "";
    String word3 = "";
    if (kDebugMode) {
      print("SEARCH BAR ${xx[0].title}");
    }
    for (int i = 0; i < xx.length; i++) {
      word1 = xx[i].discription.toLowerCase();
      if (kDebugMode) {
        print(word1);
      }
      word3 = xx[i].title.toLowerCase();
      word2 = query.toLowerCase();
      if (word1.contains(word2) || word3.contains(word2)) {
        result.add(xx[i]);
      }
    }
    if (result.isEmpty || query.isEmpty) {
      return Center(
        child: Text(
          "$query Not Fount",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemExtent: 100,
          itemCount: result.length,
          itemBuilder: (context, ind) => SizedBox(
            height: 100,
            width: 200,
            child: Card(
              // color: ColorManager.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const ImageIcon(
                      AssetImage('assets/img_4.png'),
                      size: 30,
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
                      Text(
                        result[ind].title,
                        style: const TextStyle(fontSize: 40),
                      ),
                      Text(
                        "   ${result[ind].discription}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      //_onDelete(result[ind].id);
                    },
                    icon: const Icon(
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
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    List<ToDoTask> suggestions = [];
    final input = query.toLowerCase();

    String word1, word2;
    for (var item in provider) {
      word1 = item.title.toLowerCase();
      word2 = item.discription.toLowerCase();
      if ((word1.contains(input) || word2.contains(input)) && input != '') {
        if (kDebugMode) {
          print(input);
          print('$word1 22');
          print('$word2 22');
        }
        suggestions.add(item);
      }
    }
    if (suggestions.isEmpty || query.isEmpty) {
      return Center(
        child: Text(
          "$query Not Fount",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemExtent: 100,
        itemCount: suggestions.length,
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
                  icon: const ImageIcon(
                    AssetImage('assets/img_4.png'),
                    size: 30,
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
                    Text(
                      suggestions[ind].title,
                      style: const TextStyle(fontSize: 40),
                    ),
                    Text(
                      "   ${suggestions[ind].discription}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    //_onDelete(_suggestions[ind].id);
                  },
                  icon: const Icon(
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
    );
  }
}
