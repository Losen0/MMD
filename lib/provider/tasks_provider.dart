import 'package:flutter/material.dart';

import '../todo/tasks.dart';

class TasksProvider extends ChangeNotifier {
  List<todoTask> _list = [
    todoTask(title: 'Param', discription: 'discription'),
    todoTask(title: 'Param2', discription: 'discription2'),
    todoTask(title: 'Param3', discription: 'discription3'),
    todoTask(title: 'Param4', discription: 'discription4'),
    todoTask(title: 'Param5', discription: 'discription5'),
    todoTask(title: 'Param6', discription: 'discription6'),
  ];
  List getTasks() {
    return _list;
  }

  void addToList(String str1, String str2) {
    _list.add(todoTask(title: str1, discription: str2));
  }

  void delete(String str1, String str2) {
    int length = _list.length;
    for (int i = 0; i < length; i++) {
      var item = _list[i];
      if (item.title == str1 && item.discription == str2) _list.removeAt(i);
    }
  }
}
