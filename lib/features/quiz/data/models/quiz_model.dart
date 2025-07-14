// models/quiz_model.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'quiz_model.g.dart';


@JsonSerializable()
class QuizModel extends Equatable {
  final int id;
  final String title;
  final String description;
  @JsonKey(name: 'schedule_slot')
  final ScheduleSlot scheduleSlot;
  @JsonKey(name: 'time_limit_minutes')
  final int timeLimitMinutes;
  @JsonKey(name: 'passing_score')
  final int passingScore;
  @JsonKey(name: 'max_attempts')
  final int maxAttempts;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'questions_count')
  final int questionsCount;
  @JsonKey(name: 'user_attempts_count')
  final int userAttemptsCount;
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @JsonKey(name: 'availability_message')
  final String availabilityMessage;

  const QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.scheduleSlot,
    required this.timeLimitMinutes,
    required this.passingScore,
    required this.maxAttempts,
    required this.isActive,
    required this.createdAt,
    required this.questionsCount,
    required this.userAttemptsCount,
    required this.isAvailable,
    required this.availabilityMessage,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => _$QuizModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);

  @override
  List<Object?> get props => [
    id, title, description, scheduleSlot, timeLimitMinutes, passingScore,
    maxAttempts, isActive, createdAt, questionsCount, userAttemptsCount,
    isAvailable, availabilityMessage
  ];
}

@JsonSerializable()
class ScheduleSlot extends Equatable {
  final int id;
  final int course;
  @JsonKey(name: 'course_title')
  final String courseTitle;

  const ScheduleSlot({
    required this.id,
    required this.course,
    required this.courseTitle,
  });

  factory ScheduleSlot.fromJson(Map<String, dynamic> json) => _$ScheduleSlotFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleSlotToJson(this);

  @override
  List<Object?> get props => [id, course, courseTitle];
}
