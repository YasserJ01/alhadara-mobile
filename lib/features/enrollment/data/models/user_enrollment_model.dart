//TODO : add other fields
class UserEnrollment {
  final int id;
  final int student;
  final String studentName;
  final int course;
  final String courseTitle;
  final int scheduleSlot;
  final String status;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final double amountPaid;
  final double remainingBalance;
  final double courseProgress;
  final int lessonsCount;
  final double attendance;
  final DateTime startDate;
  final DateTime endDate;

  UserEnrollment(
      {required this.id,
      required this.student,
      required this.studentName,
      required this.course,
      required this.courseTitle,
      required this.scheduleSlot,
      required this.status,
      required this.paymentStatus,
      required this.enrollmentDate,
      required this.amountPaid,
      required this.remainingBalance,
      required this.courseProgress,
      required this.lessonsCount,
      required this.attendance,
      required this.startDate,
      required this.endDate});

  factory UserEnrollment.fromJson(Map<String, dynamic> json) {
    return UserEnrollment(
      id: json['id'],
      student: json['student'],
      studentName: json['student_name'],
      course: json['course'],
      courseTitle: json['course_title'],
      scheduleSlot: json['schedule_slot'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      enrollmentDate: DateTime.parse(json['enrollment_date']),
      amountPaid: double.parse(json['amount_paid']),
      remainingBalance: json['remaining_balance'].toDouble(),
      courseProgress: json['course_progress'].toDouble(),
      lessonsCount: json['lessons_count'],
      attendance: json['attendance_percentage'].toDouble(),
      startDate: DateTime.parse(json['schedule_slot_display']['validity_period']['start']),
      endDate: DateTime.parse(json['schedule_slot_display']['validity_period']['end']),
    );
  }
}
