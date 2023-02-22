part of 'view_style_bloc.dart';

@immutable
abstract class ViewStyleState extends Equatable {}

class ViewStyleInitial extends ViewStyleState {
  @override
  List<Object?> get props => [];
}

///get the current view style of the app
class LoadedViewStyleState extends ViewStyleState {
  final int currentStyle;

  LoadedViewStyleState({required this.currentStyle});
  @override
  List<Object?> get props => [currentStyle];
}
