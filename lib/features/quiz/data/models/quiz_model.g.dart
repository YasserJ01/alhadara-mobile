// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      scheduleSlot:
          ScheduleSlot.fromJson(json['schedule_slot'] as Map<String, dynamic>),
      timeLimitMinutes: (json['time_limit_minutes'] as num).toInt(),
      passingScore: (json['passing_score'] as num).toInt(),
      maxAttempts: (json['max_attempts'] as num).toInt(),
      isActive: json['is_active'] as bool,
      createdAt: json['created_at'] as String,
      questionsCount: (json['questions_count'] as num).toInt(),
      userAttemptsCount: (json['user_attempts_count'] as num).toInt(),
      isAvailable: json['is_available'] as bool,
      availabilityMessage: json['availability_message'] as String,
    );

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'schedule_slot': instance.scheduleSlot,
      'time_limit_minutes': instance.timeLimitMinutes,
      'passing_score': instance.passingScore,
      'max_attempts': instance.maxAttempts,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'questions_count': instance.questionsCount,
      'user_attempts_count': instance.userAttemptsCount,
      'is_available': instance.isAvailable,
      'availability_message': instance.availabilityMessage,
    };

ScheduleSlot _$ScheduleSlotFromJson(Map<String, dynamic> json) => ScheduleSlot(
      id: (json['id'] as num).toInt(),
      course: (json['course'] as num).toInt(),
      courseTitle: json['course_title'] as String,
    );

Map<String, dynamic> _$ScheduleSlotToJson(ScheduleSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course': instance.course,
      'course_title': instance.courseTitle,
    };
