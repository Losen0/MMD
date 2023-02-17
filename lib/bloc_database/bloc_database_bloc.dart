import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Helper/local_database_helper.dart';

import '../todo_model/tasks.dart';

part 'bloc_database_event.dart';
part 'bloc_database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final dp = DataBaseHelper.instance;
  DatabaseBloc() : super(DatabaseInitial()) {
    on<DatabaseEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetLocalDatabaseEvent) {
        final tasks2 = await dp.loadTasksFromDatabase();

        emit(LoadedDatabaseState(list: tasks2));
      } else if (event is AddToDataBaseEvent) {
        ToDoTask task = event.task;
        dp.addToDatabase(task);
        //emit(AddedSuccessfullyState(list: tasks2));
      } else if (event is DeletFromDataBaseEvent) {
        ToDoTask task = event.task;
        dp.removeFromDatabase(task.id);
        final tasks2 = await dp.loadTasksFromDatabase();
        emit(DeletedSuccessfullyState(list: tasks2));
      }
    });
  }
}
