part of 'languages_bloc.dart';

@immutable
abstract class LanguagesEvent extends Equatable {}

class LoadLanguageEvent extends LanguagesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeLanguageEvent extends LanguagesEvent {
  final Locale locale;
  final int currentIndex;
  ChangeLanguageEvent({required this.locale, required this.currentIndex});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
