import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../todo_model/tasks.dart';

//DataBaseHelper x = DataBaseHelper();

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper instance = DataBaseHelper._();
  static Database? _database;
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, 'Tasks.dp');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Tasks(
    id INTEGER PRIMARY KEY,
    title TEXT,
    discription TEXT,
    complete INTEGER
    )
    ''');
  }

  Future<List<ToDoTask>> _getTasks() async {
    Database db = await instance.database;
    try {
      var tasks = await db.query('Tasks', orderBy: 'id');
      List<ToDoTask> tasksList = tasks.isNotEmpty
          ? tasks.map((e) => ToDoTask.fromMap(e)).toList()
          : [];
      return tasksList;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      List<ToDoTask> tasksList = [];
      return tasksList;
    }
  }

  Future<int> _add(ToDoTask task) async {
    Database db = await instance.database;
    return await db.insert('Tasks', task.toMap());
  }

  Future<int> _remove(int id) async {
    Database db = await instance.database;
    return await db.delete('Tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future addToDatabase(ToDoTask task) async {
    await _add(task);
  }

  Future removeFromDatabase(int id) async {
    await _remove(id);
  }

  Future<List<ToDoTask>> loadTasksFromDatabase() async {
    return await _getTasks();
  }
}
