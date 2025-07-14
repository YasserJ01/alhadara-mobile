// domain/entities/quiz_attempt_entity.dart
import 'package:equatable/equatable.dart';

import '../../data/models/quiz_attempt_model.dart';

class QuizAttemptEntity extends Equatable {
  final int id;
  final int quiz;
  final String quizTitle;
  final int user;
  final String userName;
  final String startedAt;
  final int timeRemaining;

  const QuizAttemptEntity({
    required this.id,
    required this.quiz,
    required this.quizTitle,
    required this.user,
    required this.userName,
    required this.startedAt,
    required this.timeRemaining,
  });

  factory QuizAttemptEntity.fromModel(QuizAttemptModel model) {
    return QuizAttemptEntity(
      id: model.id,
      quiz: model.quiz,
      quizTitle: model.quizTitle,
      user: model.user,
      userName: model.userName,
      startedAt: model.startedAt,
      timeRemaining: model.timeRemaining,
    );
  }

  @override
  List<Object?> get props => [id, quiz, quizTitle, user, userName, startedAt, timeRemaining];
}