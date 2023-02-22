part of 'bloc_database_bloc.dart';

///Handling Database Bloc Events
///What can cause the page to be rebuild
abstract class DatabaseEvent extends Equatable {}

///user want to get Tasks from Database
class GetLocalDatabaseEvent extends DatabaseEvent {
  @override
  List<Object?> get props => [];
}

///user want to add a Task to Database

class AddToDataBaseEvent extends DatabaseEvent {
  final ToDoTask task;
  AddToDataBaseEvent({required this.task});

  @override
  List<Object?> get props => [];
}

///user want to delete a Task from  database
class DeletFromDataBaseEvent extends DatabaseEvent {
  final ToDoTask task;
  DeletFromDataBaseEvent({required this.task});

  @override
  List<Object?> get props => [];
}

///user want to change the view of the home page
class UpdateStyleOfViewEvent extends DatabaseEvent {
  final bool currentViewStyle;
  final List<ToDoTask> tasks;
  UpdateStyleOfViewEvent({required this.currentViewStyle, required this.tasks});

  @override
  List<Object?> get props => [currentViewStyle, tasks];
}
