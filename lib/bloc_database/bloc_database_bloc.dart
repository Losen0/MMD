import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/Helper/local_database_helper.dart';

import '../todo/tasks.dart';

part 'bloc_database_event.dart';
part 'bloc_database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final dp = DataBaseHelper.instance;
  List<todoTask> tasks = [];
  DatabaseBloc() : super(DatabaseInitial()) {
    on<DatabaseEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetLocalDatabaseEvent) {
        //final dp = DataBaseHelper.instance;
        final tasks2 = await dp.loadTasksFromDatabase();
        tasks = tasks2;
        //print(tasks.length);
        //print(tasks[0].discription);
        emit(LoadedDatabaseState(list: tasks));
      } else if (event is AddToDataBaseEvent) {
        // final dp = DataBaseHelper.instance;
        todoTask task = event.task;
        tasks.add(task);
        dp.addToDatabase(task);
        emit(AddedSuccessfullyState(task: task));
      } else if (event is DeletFromDataBaseEvent) {
        for (int i = 0; i < tasks.length; i++) {
          if (tasks[i].id == event.task.id) {
            tasks.removeAt(i);
            break;
          }
        }
        todoTask task = event.task;
        dp.removeFromDatabase(task.id);
        emit(DeletedSuccessfullyState(task: task));
      }
    });
  }
}
