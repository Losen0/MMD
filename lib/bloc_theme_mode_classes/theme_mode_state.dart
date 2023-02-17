part of 'theme_mode_bloc.dart';

@immutable
abstract class ThemeModeState extends Equatable {}

class ThemeModeInitial extends ThemeModeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedThemeState extends ThemeModeState {
  final ThemeData themeData;
  final int index;
  LoadedThemeState({required this.themeData, required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [themeData];
}
