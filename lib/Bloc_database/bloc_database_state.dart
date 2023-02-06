part of 'bloc_database_bloc.dart';

@immutable
abstract class DatabaseState extends Equatable {}

class DatabaseInitial extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadedDatabaseState extends DatabaseState {
  final List<todoTask> list;

  LoadedDatabaseState({required this.list});

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}

class UpDateState extends DatabaseState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
