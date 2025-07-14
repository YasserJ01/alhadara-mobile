class AttendanceModel {
  final int enrollment;
  final int lesson;
  final String attendance;

  AttendanceModel({
    required this.enrollment,
    required this.lesson,
    required this.attendance,
  });

  Map<String, dynamic> toJson() {
    return {
      'enrollment': enrollment,
      'lesson': lesson,
      'attendance': attendance,
    };
  }
}