part of 'localization_bloc.dart';

abstract class LocalizationState {
  final Locale locale;
  const LocalizationState(this.locale);
}

class SelectedLocale extends LocalizationState {
  const SelectedLocale(Locale locale) : super(locale);
}