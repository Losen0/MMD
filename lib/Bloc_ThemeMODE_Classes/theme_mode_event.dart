part of 'theme_mode_bloc.dart';

@immutable
abstract class ThemeModeEvent extends Equatable {}

class GetCurrentThemeEvent extends ThemeModeEvent {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ThemeChangeEvent extends ThemeModeEvent {
  final AppTheme theme;
  ThemeChangeEvent({required this.theme});
  @override
  // TODO: implement props
  List<Object?> get props => [theme];
}
