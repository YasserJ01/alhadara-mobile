// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizQuestionResponse _$QuizQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    QuizQuestionResponse(
      quizId: (json['quiz_id'] as num).toInt(),
      quizTitle: json['quiz_title'] as String,
      timeLimitMinutes: (json['time_limit_minutes'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizQuestionResponseToJson(
        QuizQuestionResponse instance) =>
    <String, dynamic>{
      'quiz_id': instance.quizId,
      'quiz_title': instance.quizTitle,
      'time_limit_minutes': instance.timeLimitMinutes,
      'questions': instance.questions,
    };

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) => QuizQuestion(
      order: (json['order'] as num).toInt(),
      text: json['text'] as String,
      questionType: json['question_type'] as String,
      points: (json['points'] as num).toInt(),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => QuizChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizQuestionToJson(QuizQuestion instance) =>
    <String, dynamic>{
      'order': instance.order,
      'text': instance.text,
      'question_type': instance.questionType,
      'points': instance.points,
      'choices': instance.choices,
    };

QuizChoice _$QuizChoiceFromJson(Map<String, dynamic> json) => QuizChoice(
      order: (json['order'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$QuizChoiceToJson(QuizChoice instance) =>
    <String, dynamic>{
      'order': instance.order,
      'text': instance.text,
    };
