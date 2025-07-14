// domain/entities/quiz_question_entity.dart
import 'package:equatable/equatable.dart';

import '../../data/models/quiz_question_model.dart';

class QuizQuestionEntity extends Equatable {
  final int quizId;
  final String quizTitle;
  final int timeLimitMinutes;
  final List<QuizQuestionItemEntity> questions;

  const QuizQuestionEntity({
    required this.quizId,
    required this.quizTitle,
    required this.timeLimitMinutes,
    required this.questions,
  });

  factory QuizQuestionEntity.fromModel(QuizQuestionResponse model) {
    return QuizQuestionEntity(
      quizId: model.quizId,
      quizTitle: model.quizTitle,
      timeLimitMinutes: model.timeLimitMinutes,
      questions: model.questions.map((q) => QuizQuestionItemEntity.fromModel(q)).toList(),
    );
  }

  @override
  List<Object?> get props => [quizId, quizTitle, timeLimitMinutes, questions];
}

class QuizQuestionItemEntity extends Equatable {
  final int order;
  final String text;
  final String questionType;
  final int points;
  final List<QuizChoiceEntity> choices;

  const QuizQuestionItemEntity({
    required this.order,
    required this.text,
    required this.questionType,
    required this.points,
    required this.choices,
  });

  factory QuizQuestionItemEntity.fromModel(QuizQuestion model) {
    return QuizQuestionItemEntity(
      order: model.order,
      text: model.text,
      questionType: model.questionType,
      points: model.points,
      choices: model.choices.map((c) => QuizChoiceEntity.fromModel(c)).toList(),
    );
  }

  @override
  List<Object?> get props => [order, text, questionType, points, choices];
}

class QuizChoiceEntity extends Equatable {
  final int order;
  final String text;

  const QuizChoiceEntity({
    required this.order,
    required this.text,
  });

  factory QuizChoiceEntity.fromModel(QuizChoice model) {
    return QuizChoiceEntity(
      order: model.order,
      text: model.text,
    );
  }

  @override
  List<Object?> get props => [order, text];
}