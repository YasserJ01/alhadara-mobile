// features/courses/data/models/enroll_model.dart
import '../../domain/entities/enrollment.dart';

class EnrollModel extends EnrollEntity {
  const EnrollModel({
    required super.id,
    required super.course,
    required super.scheduleSlot,
    required super.notes,
    required super.enrollmentDate,
  });

  factory EnrollModel.fromJson(Map<String, dynamic> json) {
    return EnrollModel(
      id: json['id'],
      course: json['course'],
      scheduleSlot: json['schedule_slot'],
      notes: json['notes'] ?? '',
      enrollmentDate: DateTime.parse(json['enrollment_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course': course,
      'schedule_slot': scheduleSlot,
      'notes': notes,
    };
  }
}