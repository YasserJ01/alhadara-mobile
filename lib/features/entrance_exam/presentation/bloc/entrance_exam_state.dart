import 'package:equatable/equatable.dart';

import '../../data/models/exam_attempt_model.dart';
abstract class EntranceExamState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EntranceExamInitial extends EntranceExamState {}

class EntranceExamLoading extends EntranceExamState {}

class ExamStarted extends EntranceExamState {
  final int attemptId;

  ExamStarted(this.attemptId);

  @override
  List<Object> get props => [attemptId];
}

class ExamLoaded extends EntranceExamState {
  final ExamAttempt examAttempt;
  final Map<int, int> userAnswers;
  final int currentQuestionIndex;

  ExamLoaded({
    required this.examAttempt,
    required this.userAnswers,
    this.currentQuestionIndex = 0,
  });

  ExamLoaded copyWith({
    ExamAttempt? examAttempt,
    Map<int, int>? userAnswers,
    int? currentQuestionIndex,
  }) {
    return ExamLoaded(
      examAttempt: examAttempt ?? this.examAttempt,
      userAnswers: userAnswers ?? this.userAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }

  @override
  List<Object> get props => [examAttempt, userAnswers, currentQuestionIndex];
}

class ExamCompleted extends EntranceExamState {}

class EntranceExamError extends EntranceExamState {
  final String message;

  EntranceExamError(this.message);

  @override
  List<Object> get props => [message];
}

