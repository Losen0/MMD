part of 'theme_mode_bloc.dart';

///Handling Bloc Events
///What can cause the page to be rebuild
@immutable
abstract class ThemeModeEvent extends Equatable {}

///getting the theme
class GetCurrentThemeEvent extends ThemeModeEvent {
  @override
  List<Object?> get props => [];
}

///user want to change theme
class ThemeChangeEvent extends ThemeModeEvent {
  final AppTheme theme;
  ThemeChangeEvent({required this.theme});
  @override
  List<Object?> get props => [theme];
}
