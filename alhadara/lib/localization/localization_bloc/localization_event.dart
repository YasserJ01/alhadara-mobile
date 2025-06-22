part of 'localization_bloc.dart';

abstract class LocalizationEvent {
  const LocalizationEvent();
}

class ChangeLocale extends LocalizationEvent {
  final Locale locale;
  const ChangeLocale(this.locale);
}