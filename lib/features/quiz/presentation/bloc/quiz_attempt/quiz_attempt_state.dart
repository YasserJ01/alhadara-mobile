// States
import 'package:equatable/equatable.dart';

import '../../../domain/entities/quiz_attempt_entity.dart';

abstract class QuizAttemptState extends Equatable {
  const QuizAttemptState();

  @override
  List<Object> get props => [];
}

class QuizAttemptInitial extends QuizAttemptState {}

class QuizAttemptLoading extends QuizAttemptState {}

class QuizAttemptStarted extends QuizAttemptState {
  final QuizAttemptEntity attempt;

  const QuizAttemptStarted({required this.attempt});

  @override
  List<Object> get props => [attempt];
}

class QuizAttemptError extends QuizAttemptState {
  final String message;

  const QuizAttemptError({required this.message});

  @override
  List<Object> get props => [message];
}