// entities/lesson.dart
import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  final int id;
  final String title;
  final String notes;
  final int course;
  final int scheduleSlot;
  final int lessonOrder;
  final DateTime lessonDate;
  final String status;
  final bool hasHomework;

  const Lesson({
    required this.id,
    required this.title,
    required this.notes,
    required this.course,
    required this.scheduleSlot,
    required this.lessonOrder,
    required this.lessonDate,
    required this.status,
    required this.hasHomework,
  });

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