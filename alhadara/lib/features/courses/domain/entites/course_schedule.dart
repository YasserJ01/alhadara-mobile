// domain/entities/course_schedule.dart

class CourseSchedule {
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

  CourseSchedule({
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

  // Helper method to get abbreviated days
  List<String> get abbreviatedDays => daysOfWeek.map((day) {
    return day.substring(0, 1).toUpperCase();
  }).toList();

  // Format time to 12-hour format
  String get formattedStartTime {
    final timeParts = startTime.split(':');
    int hour = int.parse(timeParts[0]);
    final minute = timeParts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : hour;
    hour = hour == 0 ? 12 : hour;
    return '$hour:$minute $period';
  }

  String get formattedEndTime {
    final timeParts = endTime.split(':');
    int hour = int.parse(timeParts[0]);
    final minute = timeParts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : hour;
    hour = hour == 0 ? 12 : hour;
    return '$hour:$minute $period';
  }

  // Format date to display format
  String get formattedStartDate {
    return "${validFrom.month}/${validFrom.day}/${validFrom.year}";
  }
}