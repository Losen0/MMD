part of 'bloc_database_bloc.dart';

abstract class DatabaseState extends Equatable {}

///Handling returned states
///this is the response to the user's desire "Events"
class DatabaseInitial extends DatabaseState {
  @override
  List<Object?> get props => [];
}

///Getting the all tasks from Database
class LoadedDatabaseState extends DatabaseState {
  final List<ToDoTask> list;
  LoadedDatabaseState({required this.list});
  @override
  List<Object?> get props => [list];
}

///Deleting  a task from Database
class DeletedSuccessfullyState extends DatabaseState {
  final List<ToDoTask> list;

  DeletedSuccessfullyState({required this.list});
  @override
  List<Object?> get props => [list];
}

///Adding a new task to Database
class AddedSuccessfullyState extends DatabaseState {
  final List<ToDoTask> list;

  AddedSuccessfullyState({required this.list});
  @override
  List<Object?> get props => [list];
}
