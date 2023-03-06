part of 'languages_bloc.dart';

@immutable
abstract class LanguagesEvent extends Equatable {}

class LoadLanguageEvent extends LanguagesEvent {
  @override
  List<Object?> get props => [];
}

class ChangeLanguageEvent extends LanguagesEvent {
  final Locale locale;
  final int currentIndex;
  ChangeLanguageEvent({required this.locale, required this.currentIndex});
  @override
  List<Object?> get props => [];
}
