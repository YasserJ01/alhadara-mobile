import 'package:equatable/equatable.dart';

import 'answer_model.dart';
import 'question_model.dart';

class ExamAttempt extends Equatable {
  final int id;
  final String studentName;
  final String examTitle;
  final String languageName;
  final String? achievedLevelDisplay;
  final int timeRemainingMcq;
  final bool canAccessMcq;
  final List<Question> questions;
  final List<Answer> answers;
  final DateTime startedAt;
  final DateTime? mcqCompletedAt;
  final String status;
  final int mcqScore;
  final int totalScore;

  const ExamAttempt({
    required this.id,
    required this.studentName,
    required this.examTitle,
    required this.languageName,
    this.achievedLevelDisplay,
    required this.timeRemainingMcq,
    required this.canAccessMcq,
    required this.questions,
    required this.answers,
    required this.startedAt,
    this.mcqCompletedAt,
    required this.status,
    required this.mcqScore,
    required this.totalScore,
  });

  @override
  List<Object?> get props => [
    id,
    studentName,
    examTitle,
    languageName,
    achievedLevelDisplay,
    timeRemainingMcq,
    canAccessMcq,
    questions,
    answers,
    startedAt,
    mcqCompletedAt,
    status,
    mcqScore,
    totalScore,
  ];
}