// Events
import 'package:equatable/equatable.dart';

abstract class QuizAttemptEvent extends Equatable {
  const QuizAttemptEvent();

  @override
  List<Object> get props => [];
}

class StartQuizAttemptEvent extends QuizAttemptEvent {
  final int quizId;

  const StartQuizAttemptEvent({required this.quizId});

  @override
  List<Object> get props => [quizId];
}
