// models/quiz_question_model.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'quiz_question_model.g.dart';

@JsonSerializable()
class QuizQuestionResponse extends Equatable {
  @JsonKey(name: 'quiz_id')
  final int quizId;
  @JsonKey(name: 'quiz_title')
  final String quizTitle;
  @JsonKey(name: 'time_limit_minutes')
  final int timeLimitMinutes;
  final List<QuizQuestion> questions;

  const QuizQuestionResponse({
    required this.quizId,
    required this.quizTitle,
    required this.timeLimitMinutes,
    required this.questions,
  });

  factory QuizQuestionResponse.fromJson(Map<String, dynamic> json) => _$QuizQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QuizQuestionResponseToJson(this);

  @override
  List<Object?> get props => [quizId, quizTitle, timeLimitMinutes, questions];
}

@JsonSerializable()
class QuizQuestion extends Equatable {
  final int order;
  final String text;
  @JsonKey(name: 'question_type')
  final String questionType;
  final int points;
  final List<QuizChoice> choices;

  const QuizQuestion({
    required this.order,
    required this.text,
    required this.questionType,
    required this.points,
    required this.choices,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => _$QuizQuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuizQuestionToJson(this);

  @override
  List<Object?> get props => [order, text, questionType, points, choices];
}

@JsonSerializable()
class QuizChoice extends Equatable {
  final int order;
  final String text;

  const QuizChoice({
    required this.order,
    required this.text,
  });

  factory QuizChoice.fromJson(Map<String, dynamic> json) => _$QuizChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$QuizChoiceToJson(this);

  @override
  List<Object?> get props => [order, text];
}
