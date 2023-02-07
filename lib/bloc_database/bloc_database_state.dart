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
  final List<todoTask> list;

  DeletedSuccessfullyState({required this.list});
  @override
  // TODO: implement props
  List<Object?> get props => [list];
}

class AddedSuccessfullyState extends DatabaseState {
  final List<todoTask> list;

  AddedSuccessfullyState({required this.list});
  @override
  // TODO: implement props
  List<Object?> get props => [list];
}
