import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/Helper/local_database_helper.dart';

import '../todo/tasks.dart';

part 'bloc_database_event.dart';
part 'bloc_database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DatabaseInitial()) {
    on<DatabaseEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetLocalDatabaseEvent) {
        final dp = DataBaseHelper.instance;
        final tasks = await dp.loadTasksFromDatabase();
        emit(LoadedDatabaseState(list: tasks));
      } else if (event is AddToDataBaseEvent) {
        final dp = DataBaseHelper.instance;
        todoTask task = event.task;
        dp.addToDatabase(task);
        emit(UpDateState());
      } else if (event is DeletFromDataBaseEvent) {
        final dp = DataBaseHelper.instance;
        todoTask task = event.task;
        dp.removeFromDatabase(task.id);
        emit(UpDateState());
      }
    });
  }
}
