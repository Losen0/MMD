part of 'languages_bloc.dart';

@immutable
abstract class LanguagesState extends Equatable {}

class LanguagesInitialState extends LanguagesState {
  @override
  List<Object?> get props => [];
}

class LanguagesLoadedState extends LanguagesState {
  final Locale locale;
  final int currLanguage;

  LanguagesLoadedState({required this.locale, required this.currLanguage});

  @override
  // TODO: implement props
  List<Object?> get props => [locale];
}
