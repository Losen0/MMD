part of 'bloc_database_bloc.dart';

abstract class DatabaseEvent extends Equatable {}

class GetLocalDatabaseEvent extends DatabaseEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToDataBaseEvent extends DatabaseEvent {
  final ToDoTask task;
  AddToDataBaseEvent({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeletFromDataBaseEvent extends DatabaseEvent {
  final ToDoTask task;
  DeletFromDataBaseEvent({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
