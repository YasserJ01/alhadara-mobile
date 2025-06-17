// data/models/course_schedule_model.dart
import 'package:equatable/equatable.dart';

import '../../domain/entites/course_schedule.dart';

class CourseScheduleModel extends Equatable {
  final int id;
  final int courseId;
  final String courseTitle;
  final int hallId;
  final String hallName;
  final List<String> daysOfWeek;
  final String startTime;
  final String endTime;
  final bool recurring;
  final DateTime validFrom;
  final DateTime validUntil;

  const CourseScheduleModel({
    required this.id,
    required this.courseId,
    required this.courseTitle,
    required this.hallId,
    required this.hallName,
    required this.daysOfWeek,
    required this.startTime,
    required this.endTime,
    required this.recurring,
    required this.validFrom,
    required this.validUntil,
  });

  factory CourseScheduleModel.fromJson(Map<String, dynamic> json) {
    return CourseScheduleModel(
      id: json['id'],
      courseId: json['course'],
      courseTitle: json['course_title'],
      hallId: json['hall'],
      hallName: json['hall_name'],
      daysOfWeek: List<String>.from(json['days_of_week']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      recurring: json['recurring'],
      validFrom: DateTime.parse(json['valid_from']),
      validUntil: DateTime.parse(json['valid_until']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course': courseId,
      'course_title': courseTitle,
      'hall': hallId,
      'hall_name': hallName,
      'days_of_week': daysOfWeek,
      'start_time': startTime,
      'end_time': endTime,
      'recurring': recurring,
      'valid_from': validFrom.toIso8601String(),
      'valid_until': validUntil.toIso8601String(),
    };
  }

  @override
  List<Object> get props => [
        id,
        courseId,
        courseTitle,
        hallId,
        hallName,
        daysOfWeek,
        startTime,
        endTime,
        recurring,
        validFrom,
        validUntil
      ];

  CourseSchedule toEntity() {
    return CourseSchedule(
        id: id,
        courseId: courseId,
        courseTitle: courseTitle,
        hallId: hallId,
        hallName: hallName,
        daysOfWeek: daysOfWeek,
        startTime: startTime,
        endTime: endTime,
        recurring: recurring,
        validFrom: validFrom,
        validUntil: validUntil,
    );
  }
}
