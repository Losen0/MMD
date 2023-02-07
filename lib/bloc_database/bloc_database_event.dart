part of 'bloc_database_bloc.dart';

@immutable
abstract class DatabaseEvent extends Equatable {}

class GetLocalDatabaseEvent extends DatabaseEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddToDataBaseEvent extends DatabaseEvent {
  final todoTask task;

  AddToDataBaseEvent({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeletFromDataBaseEvent extends DatabaseEvent {
  final todoTask task;

  DeletFromDataBaseEvent({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}
