// domain/entities/attendance_entity.dart
class AttendanceEntity {
  final int enrollment;
  final int lesson;
  final String attendance;

  AttendanceEntity({
    required this.enrollment,
    required this.lesson,
    required this.attendance,
  });
}