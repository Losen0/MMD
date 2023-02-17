part of 'theme_mode_bloc.dart';

@immutable
abstract class ThemeModeEvent extends Equatable {}

class GetCurrentThemeEvent extends ThemeModeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ThemeChangeEvent extends ThemeModeEvent {
  final AppTheme theme;
  ThemeChangeEvent({required this.theme});
  @override
  // TODO: implement props
  List<Object?> get props => [theme];
}
