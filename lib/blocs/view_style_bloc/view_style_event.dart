part of 'view_style_bloc.dart';

@immutable
abstract class ViewStyleEvent extends Equatable {}

///User want to Load current viewStyle
class LoadViewStyleEvent extends ViewStyleEvent {
  @override
  List<Object?> get props => [];
}

///User want to change current viewStyle
class ChangeViewStyleEvent extends ViewStyleEvent {
  final int currentStyle;

  ChangeViewStyleEvent({required this.currentStyle});
  @override
  List<Object?> get props => [currentStyle];
}
