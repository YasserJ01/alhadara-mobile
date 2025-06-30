// features/courses/domain/entities/enrollment.dart
import 'package:equatable/equatable.dart';

class EnrollEntity extends Equatable {
  final int id;
  final int course;
  final int scheduleSlot;
  final String notes;
  final DateTime enrollmentDate;

  const EnrollEntity({
    required this.id,
    required this.course,
    required this.scheduleSlot,
    required this.notes,
    required this.enrollmentDate,
  });

  @override
  List<Object> get props => [
    id,
    course,
    scheduleSlot,
    notes,
    enrollmentDate,
  ];
}
