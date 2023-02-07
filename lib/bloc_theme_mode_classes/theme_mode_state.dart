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
  LoadedThemeState({required this.themeData});
  @override
  // TODO: implement props
  List<Object?> get props => [themeData];
}
