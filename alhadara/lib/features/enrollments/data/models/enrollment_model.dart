class Enrollment {
  final int id;
  final int student;
  final String studentName;
  final int course;
  final String courseTitle;
  final int scheduleSlot;
  final String scheduleSlotDisplay;
  final String status;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final double amountPaid;
  final double remainingBalance;
  final String notes;

  Enrollment({
    required this.id,
    required this.student,
    required this.studentName,
    required this.course,
    required this.courseTitle,
    required this.scheduleSlot,
    required this.scheduleSlotDisplay,
    required this.status,
    required this.paymentStatus,
    required this.enrollmentDate,
    required this.amountPaid,
    required this.remainingBalance,
    required this.notes,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['id'],
      student: json['student'],
      studentName: json['student_name'],
      course: json['course'],
      courseTitle: json['course_title'],
      scheduleSlot: json['schedule_slot'],
      scheduleSlotDisplay: json['schedule_slot_display'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      enrollmentDate: DateTime.parse(json['enrollment_date']),
      amountPaid: double.parse(json['amount_paid']),
      remainingBalance: json['remaining_balance'].toDouble(),
      notes: json['notes'],
    );
  }
}