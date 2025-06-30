class EnrollmentEntity {
  final int id;
  final String studentName;
  final String courseTitle;
  final int scheduleSlot;
  final String scheduleSlotDisplay;
  final String status;
  final String paymentStatus;
  // final String paymentMethod;
  // final String paymentMethodDisplay;
  final DateTime enrollmentDate;
  final double amountPaid;
  final double remainingBalance;
  // final bool isGuest;
  final double courseProgress;
  final int lessonsCount;
  final double attendance;

  EnrollmentEntity(
      {required this.id,
      required this.studentName,
      required this.courseTitle,
      required this.scheduleSlotDisplay,
      required this.scheduleSlot,
      required this.status,
      required this.paymentStatus,
      // required this.paymentMethod,
      // required this.paymentMethodDisplay,
      required this.enrollmentDate,
      required this.amountPaid,
      required this.remainingBalance,
      // required this.isGuest,
      required this.courseProgress,
      required this.lessonsCount,
      required this.attendance});
}
