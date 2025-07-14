// domain/entities/quiz_entity.dart
import 'package:equatable/equatable.dart';
import '../../data/models/quiz_model.dart';

class QuizEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final ScheduleSlotEntity scheduleSlot;
  final int timeLimitMinutes;
  final int passingScore;
  final int maxAttempts;
  final bool isActive;
  final String createdAt;
  final int questionsCount;
  final int userAttemptsCount;
  final bool isAvailable;
  final String availabilityMessage;

  const QuizEntity({
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

  factory QuizEntity.fromModel(QuizModel model) {
    return QuizEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      scheduleSlot: ScheduleSlotEntity.fromModel(model.scheduleSlot),
      timeLimitMinutes: model.timeLimitMinutes,
      passingScore: model.passingScore,
      maxAttempts: model.maxAttempts,
      isActive: model.isActive,
      createdAt: model.createdAt,
      questionsCount: model.questionsCount,
      userAttemptsCount: model.userAttemptsCount,
      isAvailable: model.isAvailable,
      availabilityMessage: model.availabilityMessage,
    );
  }

  @override
  List<Object?> get props => [
    id, title, description, scheduleSlot, timeLimitMinutes, passingScore,
    maxAttempts, isActive, createdAt, questionsCount, userAttemptsCount,
    isAvailable, availabilityMessage
  ];
}

class ScheduleSlotEntity extends Equatable {
  final int id;
  final int course;
  final String courseTitle;

  const ScheduleSlotEntity({
    required this.id,
    required this.course,
    required this.courseTitle,
  });

  factory ScheduleSlotEntity.fromModel(ScheduleSlot model) {
    return ScheduleSlotEntity(
      id: model.id,
      course: model.course,
      courseTitle: model.courseTitle,
    );
  }

  @override
  List<Object?> get props => [id, course, courseTitle];
}