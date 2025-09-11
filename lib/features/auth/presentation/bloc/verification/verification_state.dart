// presentation/bloc/verification_state.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entities/verification_entities.dart';

abstract class VerificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationStarted extends VerificationState {
  final VerificationResult result;

  VerificationStarted({required this.result});

  @override
  List<Object> get props => [result];
}

class VerificationSubmitting extends VerificationState {
  final String token;

  VerificationSubmitting({required this.token});

  @override
  List<Object> get props => [token];
}

class VerificationSuccess extends VerificationState {}

class VerificationError extends VerificationState {
  final String message;

  VerificationError({required this.message});

  @override
  List<Object> get props => [message];
}
