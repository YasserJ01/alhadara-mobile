part of 'quiz_submission_bloc.dart';

abstract class QuizSubmissionEvent extends Equatable {
  const QuizSubmissionEvent();

  @override
  List<Object> get props => [];
}

class SubmitQuizAnswersEvent extends QuizSubmissionEvent {
  final int attemptId;
  final List<Map<String, dynamic>> answers;

  const SubmitQuizAnswersEvent({
    required this.attemptId,
    required this.answers,
  });

  @override
  List<Object> get props => [attemptId, answers];
}