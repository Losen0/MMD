import 'package:flutter/material.dart';
import 'package:todo_app/Helper/local_database_helper.dart';

import '../todo/tasks.dart';

class TasksProvider extends ChangeNotifier {
  List<todoTask> _list = [];
  void getTasks(List<todoTask> lt) {
    _list = lt;
    // notifyListeners();
  }

  List get TaskList => _list;

  Future<bool> addToList(todoTask Task) async {
    try {
      await DataBaseHelper.instance.addToDatabase(Task);
      _list.add(Task);
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> delete(int idd) async {
    try {
      await DataBaseHelper.instance.removeFromDatabase(idd);
      _list.removeWhere((item) => item.id == idd);
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
