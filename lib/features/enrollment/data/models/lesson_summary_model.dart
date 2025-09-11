// features/lessons/data/models/lesson_summary_model.dart

import '../../domain/entities/lesson_summary.dart';

class LessonSummaryModel extends LessonSummary {
  const LessonSummaryModel({
    required super.id,
    required super.title,
    required super.lessonDate,
    required super.lessonOrder,
    required super.status,
    required super.homework,
    required super.attended,
    super.attendanceRate,
  });

  factory LessonSummaryModel.fromJson(Map<String, dynamic> json) {
    return LessonSummaryModel(
      id: json['id'],
      title: json['title'],
      lessonDate: json['lesson_date'],
      lessonOrder: json['lesson_order'],
      status: json['status'],
      homework: (json['homework'] as List)
          .map((hw) => LessonSummaryHomeworkModel.fromJson(hw))
          .toList(),
      attended: json['attended'],
      attendanceRate: json['attendance_rate'],
    );
  }
}

class LessonSummaryHomeworkModel extends LessonSummaryHomework {
  const LessonSummaryHomeworkModel({required super.id, required super.title});

  factory LessonSummaryHomeworkModel.fromJson(Map<String, dynamic> json) {
    return LessonSummaryHomeworkModel(
      id: json['id'],
      title: json['title'],
    );
  }
}