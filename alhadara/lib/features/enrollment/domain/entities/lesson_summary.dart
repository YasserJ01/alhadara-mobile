// features/lessons/domain/entities/lesson_summary.dart
import 'package:equatable/equatable.dart';

class LessonSummary extends Equatable {
  final int id;
  final String title;
  final String lessonDate;
  final int lessonOrder;
  final String status;
  final List<Homework> homework;
  final bool attended;
  final double? attendanceRate;

  const LessonSummary({
    required this.id,
    required this.title,
    required this.lessonDate,
    required this.lessonOrder,
    required this.status,
    required this.homework,
    required this.attended,
    this.attendanceRate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        lessonDate,
        lessonOrder,
        status,
        homework,
        attended,
        attendanceRate,
      ];
}

class Homework extends Equatable {
  final int id;
  final String title;

  const Homework({required this.id, required this.title});

  @override
  List<Object> get props => [id, title];
}