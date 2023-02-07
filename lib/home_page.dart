import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bloc_database/bloc_database_bloc.dart';
import 'package:todo_app/floating_action_button/floating_action_button.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/resources/color_resources.dart';
import 'package:todo_app/resources/image_assets.dart';
import 'package:todo_app/resources/text_resource.dart';
import 'package:todo_app/todo/tasks.dart';

import 'bottom_navigation_bar/bottom_navigation_bar.dart';

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

  void _onDelete(todoTask task) {
    //  context.read<DatabaseBloc>().add(DeletFromDataBaseEvent(task: task));
    // Provider.of<TasksProvider>(context, listen: false)
    //     .delete(id)
    //     .then((value) => {
    //           if (value)
    //             {
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(
    //                   content: Text(
    //                     'Data has been deleted',
    //                   ),
    //                 ),
    //               ),
    //             }
    //           else
    //             {
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(
    //                   content: Text(
    //                     'Data not deleted an error happened!',
    //                   ),
    //                 ),
    //               ),
    //             }
    //         });
  }

  @override
  Widget build(BuildContext context) {
    //   final _provider2 = Provider.of<TasksProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<DatabaseBloc>(
          create: (context) => DatabaseBloc()..add(GetLocalDatabaseEvent()),
          child: BlocBuilder<DatabaseBloc, DatabaseState>(
            builder: (context, state) {
              if (state is LoadedDatabaseState ||
                  state is AddedSuccessfullyState ||
                  state is DeletedSuccessfullyState) {
                final bloc = context.read<DatabaseBloc>().tasks;
                return Padding(
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
                              child: statee == 0
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
                                onPressed: () {
                                  showSearch(
                                      context: context, delegate: Search());
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
                                  padding: EdgeInsets.all(10),
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
                                                style: TextStyle(fontSize: 40),
                                              ),
                                              Text(
                                                "   ${bloc[ind].discription}",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              _onDelete(bloc[ind]);
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
                                          style: TextStyle(fontSize: 40),
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
                                                _onDelete(bloc[index]);
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
                                            style: TextStyle(fontSize: 18),
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
                );
              }
              return const Center(
                  child: SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator()));
            },
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
                return FloatingButton();
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
        bottomNavigationBar: BottomBarForNAvigation(),
      ),
    );
  }
}

class Search extends SearchDelegate {
  List<todoTask> result = [];
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
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    void _onDelete(int id) {
      Provider.of<TasksProvider>(context, listen: false)
          .delete(id)
          .then((value) => {
                if (value)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Data has been deleted',
                        ),
                      ),
                    ),
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Data not deleted an error happened!',
                        ),
                      ),
                    ),
                  }
              });
    }

    final _provider = Provider.of<TasksProvider>(context);

    // TODO: implement buildResults
    if (result.isNotEmpty) {
      result.clear();
    }
    final _xx = _provider.TaskList;
    String word1 = "";
    String word2 = "";
    String word3 = "";
    for (int i = 0; i < _xx.length; i++) {
      word1 = _xx[i].discription.toLowerCase();
      print(word1);
      word3 = _xx[i].title.toLowerCase();
      word2 = query.toLowerCase();
      if (word1.contains(word2) || word3.contains(word2)) {
        result.add(_xx[i]);
      }
    }
    if (result.isEmpty || query.isEmpty) {
      return Center(
        child: Text(
          "$query Not Fount",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemExtent: 100,
        itemCount: result.length,
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
                      result[ind].title,
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "   ${result[ind].discription}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _onDelete(result[ind].id);
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

  @override
  Widget buildSuggestions(BuildContext context) {
    void _onDelete(int id) {
      Provider.of<TasksProvider>(context, listen: false)
          .delete(id)
          .then((value) => {
                if (value)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Data has been deleted',
                        ),
                      ),
                    ),
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Data not deleted an error happened!',
                        ),
                      ),
                    ),
                  }
              });
    }

    // TODO: implement buildSuggestions

    List<todoTask> _suggestions = [];
    final input = query.toLowerCase();
    final _provider = Provider.of<TasksProvider>(context).TaskList;
    String word1, word2;
    for (var item in _provider) {
      word1 = item.title.toLowerCase();
      word2 = item.discription.toLowerCase();
      if (word1.contains(input) || word2.contains(input)) {
        _suggestions.add(item);
      }
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemExtent: 100,
        itemCount: _suggestions.length,
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
                      _suggestions[ind].title,
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "   ${_suggestions[ind].discription}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _onDelete(_suggestions[ind].id);
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

/*
*  SizedBox(
                        height: 450,
                        child: statee == 0
                            ? ListView.builder(
                                padding: EdgeInsets.all(10),
                                itemExtent: 100,
                                itemCount: _provider2.TaskList.length,
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
                                              _provider2.TaskList[ind].title,
                                              style: TextStyle(fontSize: 40),
                                            ),
                                            Text(
                                              "   ${_provider2.TaskList[ind].discription}",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            _onDelete(
                                                _provider2.TaskList[ind].id);
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
                                itemCount: _provider2.TaskList.length,
                                itemBuilder:
                                    (BuildContext context, int index) => Card(
                                  // color: ColorManager.secondary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridTile(
                                      header: Text(
                                        _provider2.TaskList[index].title,
                                        style: TextStyle(fontSize: 40),
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
                                              _onDelete(_provider2
                                                  .TaskList[index].id);
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
                                          _provider2
                                              .TaskList[index].discription,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      )
* */
