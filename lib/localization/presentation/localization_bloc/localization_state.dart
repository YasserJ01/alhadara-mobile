// lib/presentation/blocs/localization/localization_state.dart
import 'package:equatable/equatable.dart';

import '../../domain/entities/language.dart';

abstract class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object> get props => [];
}

class LocalizationInitial extends LocalizationState {}

class LocalizationLoading extends LocalizationState {}

class LocalizationLoaded extends LocalizationState {
  final Language currentLanguage;

  const LocalizationLoaded(this.currentLanguage);

  @override
  List<Object> get props => [currentLanguage];
}

class LocalizationError extends LocalizationState {
  final String message;

  const LocalizationError(this.message);

  @override
  List<Object> get props => [message];
}