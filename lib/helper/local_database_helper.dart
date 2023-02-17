import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../todo_model/tasks.dart';

///this is to help in setting and getting the Tasks  to and from Database "sqflite"

///all the functions are private so no one can access it outside it .... only three functions are
class DataBaseHelper {
  ///this is a private named constructor so no one can make new objects"only have one object named instance"
  DataBaseHelper._();

  ///made only one static object to be seen
  static final DataBaseHelper instance = DataBaseHelper._();
  static Database? _database;

  /// this method is make database
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  /// this method is get Database Path and initialize database
  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, 'Tasks.dp');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// this method is create database table with all its entities
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

  /// this method is private to get all tasks that is saved in the Database
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

  /// this method is private add new task to  database
  Future<int> _add(ToDoTask task) async {
    Database db = await instance.database;
    return await db.insert('Tasks', task.toMap());
  }

  /// this method is private remove task using its id database
  Future<int> _remove(int id) async {
    Database db = await instance.database;
    return await db.delete('Tasks', where: 'id = ?', whereArgs: [id]);
  }

  /// this method is public to add a task
  Future addToDatabase(ToDoTask task) async {
    await _add(task);
  }

  /// this method is public remove a task
  Future removeFromDatabase(int id) async {
    await _remove(id);
  }

  /// this method is public get all tasks
  Future<List<ToDoTask>> loadTasksFromDatabase() async {
    return await _getTasks();
  }
}
