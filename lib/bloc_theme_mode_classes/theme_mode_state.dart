part of 'theme_mode_bloc.dart';

///Handling returned states
///this is the response to the user's desire "Events"
@immutable
abstract class ThemeModeState extends Equatable {}

class ThemeModeInitial extends ThemeModeState {
  @override
  List<Object?> get props => [];
}

///Getting the App theme
class LoadedThemeState extends ThemeModeState {
  final ThemeData themeData;
  final int index;
  LoadedThemeState({required this.themeData, required this.index});
  @override
  List<Object?> get props => [themeData];
}
