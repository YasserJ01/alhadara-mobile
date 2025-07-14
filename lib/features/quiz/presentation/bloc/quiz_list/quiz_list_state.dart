// States
import 'package:equatable/equatable.dart';

import '../../../domain/entities/quiz_entity.dart';

abstract class QuizListState extends Equatable {
  const QuizListState();

  @override
  List<Object> get props => [];
}

class QuizListInitial extends QuizListState {}

class QuizListLoading extends QuizListState {}

class QuizListLoaded extends QuizListState {
  final List<QuizEntity> quizzes;

  const QuizListLoaded({required this.quizzes});

  @override
  List<Object> get props => [quizzes];
}

class QuizListError extends QuizListState {
  final String message;

  const QuizListError({required this.message});

  @override
  List<Object> get props => [message];
}