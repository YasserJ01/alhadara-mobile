// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAttemptModel _$QuizAttemptModelFromJson(Map<String, dynamic> json) =>
    QuizAttemptModel(
      id: (json['id'] as num).toInt(),
      quiz: (json['quiz'] as num).toInt(),
      quizTitle: json['quiz_title'] as String,
      user: (json['user'] as num).toInt(),
      userName: json['user_name'] as String,
      startedAt: json['started_at'] as String,
      timeRemaining: (json['time_remaining'] as num).toInt(),
    );

Map<String, dynamic> _$QuizAttemptModelToJson(QuizAttemptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quiz': instance.quiz,
      'quiz_title': instance.quizTitle,
      'user': instance.user,
      'user_name': instance.userName,
      'started_at': instance.startedAt,
      'time_remaining': instance.timeRemaining,
    };
