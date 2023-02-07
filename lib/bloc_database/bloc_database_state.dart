part of 'bloc_database_bloc.dart';

@immutable
abstract class DatabaseState extends Equatable {}

class DatabaseInitial extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedDatabaseState extends DatabaseState {
  final List<todoTask> list;

  LoadedDatabaseState({required this.list});

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}

class DeletedSuccessfullyState extends DatabaseState {
  final todoTask task;

  DeletedSuccessfullyState({required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class AddedSuccessfullyState extends DatabaseState {
  final todoTask task;

  AddedSuccessfullyState({required this.task});
  @override
  // TODO: implement props
  List<Object?> get props => [task];
}
