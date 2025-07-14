part of 'quiz_submission_bloc.dart';

abstract class QuizSubmissionState extends Equatable {
  const QuizSubmissionState();

  @override
  List<Object> get props => [];
}

class QuizSubmissionInitial extends QuizSubmissionState {}

class QuizSubmissionLoading extends QuizSubmissionState {}

class QuizSubmissionSuccess extends QuizSubmissionState {
  final List<QuizAnswer> answers;

  const QuizSubmissionSuccess({required this.answers});

  @override
  List<Object> get props => [answers];
}

class QuizSubmissionError extends QuizSubmissionState {
  final String message;

  const QuizSubmissionError({required this.message});

  @override
  List<Object> get props => [message];
}