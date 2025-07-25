
class UserEnrollment {
  final int id;
  final int studentId;
  final String studentName;
  final int course;
  final String courseTitle;   
  final int scheduleSlot;
  // final String scheduleSlotDisplay;
  final String status;
  final String paymentStatus;
  // final String paymentMethod;
  // final String paymentMethodDisplay;
  final DateTime enrollmentDate;
  final double amountPaid;
  final double remainingBalance;
  final double courseProgress;
  final int lessonsCount;
  final double attendance;

  UserEnrollment({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.course,
    required this.courseTitle,
    required this.scheduleSlot,
    // required this.scheduleSlotDisplay,
    required this.status,
    required this.paymentStatus,
    // required this.paymentMethod,
    // required this.paymentMethodDisplay,
    required this.enrollmentDate,
    required this.amountPaid,
    required this.remainingBalance,
    // required this.isGuest,
    // required this.firstName,
    // required this.middleName,
    // required this.lastName,
    // required this.phone,
    // required this.enrolledBy,
    required this.courseProgress,
    required this.lessonsCount,
    required this.attendance
  });

  factory UserEnrollment.fromJson(Map<String, dynamic> json) {
    return UserEnrollment(
      id: json['id'],
      studentId: json['student'],
      studentName: json['student_name'],
      course: json['course'],
      courseTitle: json['course_title'],
      scheduleSlot: json['schedule_slot'],
      // scheduleSlotDisplay: json['schedule_slot_display'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      // paymentMethod: json['payment_method'],
      // paymentMethodDisplay: json['payment_method_display'],
      enrollmentDate: DateTime.parse(json['enrollment_date']),
      amountPaid: double.parse(json['amount_paid']),
      remainingBalance: json['remaining_balance'].toDouble(),
      // isGuest: json['is_guest'],
      // firstName: json['first_name'],
      // middleName: json['middle_name'],
      // lastName: json['last_name'],
      // phone: json['phone'],
      // enrolledBy: json['enrolled_by'],
      courseProgress: json['course_progress'].toDouble(),
      lessonsCount: json['lessons_count'],
      attendance: json['attendance_percentage'].toDouble()
    );
  }
}
