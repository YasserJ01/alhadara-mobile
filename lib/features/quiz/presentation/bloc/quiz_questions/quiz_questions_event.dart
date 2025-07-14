import 'package:equatable/equatable.dart';

// Events
abstract class QuizQuestionsEvent extends Equatable {
  const QuizQuestionsEvent();

  @override
  List<Object> get props => [];
}

class LoadQuizQuestionsEvent extends QuizQuestionsEvent {
  final int quizId;

  const LoadQuizQuestionsEvent({required this.quizId});

  @override
  List<Object> get props => [quizId];
}
