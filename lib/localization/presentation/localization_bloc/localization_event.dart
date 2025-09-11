// lib/presentation/blocs/localization/localization_event.dart
import 'package:equatable/equatable.dart';

import '../../domain/entities/language.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentLanguage extends LocalizationEvent {}

class ChangeLanguage extends LocalizationEvent {
  final Language language;

  const ChangeLanguage(this.language);

  @override
  List<Object> get props => [language];
}