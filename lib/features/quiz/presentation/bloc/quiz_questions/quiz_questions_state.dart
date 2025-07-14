// States
import 'package:equatable/equatable.dart';
import '../../../domain/entities/quiz_question_entity.dart';


abstract class QuizQuestionsState extends Equatable {
  const QuizQuestionsState();

  @override
  List<Object> get props => [];
}

class QuizQuestionsInitial extends QuizQuestionsState {}

class QuizQuestionsLoading extends QuizQuestionsState {}

class QuizQuestionsLoaded extends QuizQuestionsState {
  final QuizQuestionEntity questions;

  const QuizQuestionsLoaded({required this.questions});

  @override
  List<Object> get props => [questions];
}

class QuizQuestionsError extends QuizQuestionsState {
  final String message;

  const QuizQuestionsError({required this.message});

  @override
  List<Object> get props => [message];
}

