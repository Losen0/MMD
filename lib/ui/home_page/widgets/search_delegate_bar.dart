import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/tasks.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/image_assets.dart';

class Search extends SearchDelegate {
  /// result list will contain all Tasks that match users input
  List<ToDoTask> result = [];

  /// allTasks is all tasks from the Database
  final List<ToDoTask> allTasks;
  Search({required this.allTasks});

  /// searchAllTasksToGetResult we will search in it for results
  late List<ToDoTask> searchAllTasksToGetResult = allTasks;

  ///searchAllTasksForSuggesstions will suggest any text the user inter that match any task in the Database
  late List<ToDoTask> searchAllTasksForSuggesstions = allTasks;

  ///This is the footer Icon that close the search if the query input is empty or clear the query if it's not empty
  @override
  List<Widget>? buildActions(BuildContext context) {
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

  ///this is the leading icon used to close the search context
  /// useles commit
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  /// this is to show the results after pressing search Or ok
  @override
  Widget buildResults(BuildContext context) {
    ///first we need to check that the result is empty to fill it only with the wright ones
    if (result.isNotEmpty) {
      result.clear();
    }

    ///here we've made 3 words for title,discription and query
    String word1 = "";
    String word2 = "";
    String word3 = "";

    ///this for loop is to check if any character of title or discription of any task that matches the user input
    ///
    ///we converted every character into lowercase so we get wright answers when user input upper or lover case characters
    for (int i = 0; i < searchAllTasksToGetResult.length; i++) {
      word1 = searchAllTasksToGetResult[i].discription.toLowerCase();
      if (kDebugMode) {
        print(word1);
      }
      word3 = searchAllTasksToGetResult[i].title.toLowerCase();
      word2 = query.toLowerCase();
      if (word1.contains(word2) || word3.contains(word2)) {
        result.add(searchAllTasksToGetResult[i]);
      }
    }

    ///check if there is any results if
    ///No
    if (result.isEmpty || query.isEmpty) {
      return Center(
        child: Text(
          "$query Not Fount",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      ///yes
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          padding: const EdgeInsets.all(AppSizes.size3),
          itemExtent: AppSizes.size48,
          itemCount: result.length,
          itemBuilder: (context, ind) => SizedBox(
            height: AppSizes.size48,
            width: AppSizes.size95,
            child: Card(
              // color: ColorManager.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.size4)),
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
                  const SizedBox(width: AppSizes.size3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        result[ind].title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        "   ${result[ind].discription}",
                        style: Theme.of(context).textTheme.bodySmall,
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
                      size: AppSizes.size13,
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

  /// this is to show suggestions while the user is typing
  @override
  Widget buildSuggestions(BuildContext context) {
    ///used to build the UI suggestions and is filled from any matches between the database and the searchAllTasksForSuggesstions List
    List<String> suggestions = [];

    ///we converted every character into lowercase so we get wright answers when user input upper or lover case characters
    final input = query.toLowerCase();
    String word1, word2;

    ///this for loop is to check if any character of title or discription of any task that matches the user input
    for (var item in searchAllTasksForSuggesstions) {
      word1 = item.title.toLowerCase();
      word2 = item.discription.toLowerCase();
      if (word1.contains(input) && input != '') {
        suggestions.add(word1);
      }
      if (word2.contains(input) && input != '') {
        suggestions.add(word2);
      }
    }

    ///check if there is any matching suggestions
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
        padding: const EdgeInsets.all(AppSizes.size3),
        itemExtent: AppSizes.size48,
        itemCount: suggestions.length,
        itemBuilder: (context, ind) => InkWell(
          onTap: () {
            query = suggestions[ind];
          },
          child: SizedBox(
            height: AppSizes.size48,
            width: AppSizes.size95,
            child: Text(
              suggestions[ind],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
