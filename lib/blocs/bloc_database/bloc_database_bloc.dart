import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/helpers/local_database_helper.dart';
import 'package:todo_app/models/tasks.dart';

part 'bloc_database_event.dart';
part 'bloc_database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final dp = DataBaseHelper.instance;
  DatabaseBloc() : super(DatabaseInitial()) {
    ///this is to load database and get all tasks saved in it
    on<GetLocalDatabaseEvent>((event, emit) async {
      final tasks2 = await dp.loadTasksFromDatabase();
      emit(LoadedDatabaseState(list: tasks2));
    });

    ///this is to add new task to database
    on<AddToDataBaseEvent>((event, emit) async {
      ToDoTask task = event.task;
      dp.addToDatabase(task);
    });

    ///this is to delete a task from database
    on<DeletFromDataBaseEvent>((event, emit) async {
      ToDoTask task = event.task;
      dp.removeFromDatabase(task.id);
      final tasks2 = await dp.loadTasksFromDatabase();
      emit(DeletedSuccessfullyState(list: tasks2));
    });
  }
}
