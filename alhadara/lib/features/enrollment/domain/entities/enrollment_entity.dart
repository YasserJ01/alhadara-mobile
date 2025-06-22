class EnrollmentEntity {
  final int id;
  final String studentName;
  final String courseTitle;
  final String scheduleSlotDisplay;
  final String status;
  final String paymentStatus;
  final DateTime enrollmentDate;
  final double amountPaid;
  final double remainingBalance;
  final String notes;

  EnrollmentEntity({
    required this.id,
    required this.studentName,
    required this.courseTitle,
    required this.scheduleSlotDisplay,
    required this.status,
    required this.paymentStatus,
    required this.enrollmentDate,
    required this.amountPaid,
    required this.remainingBalance,
    required this.notes,
  });
}