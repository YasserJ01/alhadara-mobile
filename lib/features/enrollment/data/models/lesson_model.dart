// models/lesson_model.dart
import 'package:equatable/equatable.dart';

class LessonModel extends Equatable {
  final int id;
  final String title;
  final String notes;
  final int course;
  final int scheduleSlot;
  final int lessonOrder;
  final DateTime lessonDate;
  final String status;
  final bool hasHomework;

  const LessonModel(
      {required this.id,
      required this.title,
      required this.notes,
      required this.course,
      required this.scheduleSlot,
      required this.lessonOrder,
      required this.lessonDate,
      required this.status,
      required this.hasHomework});

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      title: json['title'] as String,
      notes: json['notes'] as String,
      course: json['course'] as int,
      scheduleSlot: json['schedule_slot'] as int,
      lessonOrder: json['lesson_order'] as int,
      lessonDate: DateTime.parse(json['lesson_date'] as String),
      status: json['status'] as String,
      hasHomework: json['has_homework'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
      'course': course,
      'schedule_slot': scheduleSlot,
      'lesson_order': lessonOrder,
      'lesson_date': lessonDate.toIso8601String().split('T')[0],
      'status': status,
      'has_homework': hasHomework,
    };
  }

  @override
  List<Object> get props => [
        id,
        title,
        notes,
        course,
        scheduleSlot,
        lessonOrder,
        lessonDate,
        status,
        hasHomework,
      ];
}
