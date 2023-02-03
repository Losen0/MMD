import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/todo/tasks.dart';

class DataBaseHelper {
  DataBaseHelper._constructor();
  static final DataBaseHelper instance = DataBaseHelper._constructor();
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

  Future<List<todoTask>> _getTasks() async {
    Database db = await instance.database;
    try {
      var tasks = await db.query('Tasks', orderBy: 'id');
      List<todoTask> tasksList = tasks.isNotEmpty
          ? tasks.map((e) => todoTask.fromMap(e)).toList()
          : [];
      return tasksList;
    } catch (error) {
      print(error);
      List<todoTask> tasksList = [];
      return tasksList;
    }
  }

  Future<int> _add(todoTask Task) async {
    Database db = await instance.database;
    return await db.insert('Tasks', Task.toMap());
  }

  Future<int> _remove(int id) async {
    Database db = await instance.database;
    return await db.delete('Tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future addToDatabase(todoTask Task) async {
    await _add(Task);
  }

  Future removeFromDatabase(int id) async {
    await _remove(id);
  }

  Future<List<todoTask>> loadTasksFromDatabase() async {
    return await _getTasks();
  }
}
