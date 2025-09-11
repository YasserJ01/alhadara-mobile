class BookingRequestEntity {
  final DateTime date;
  final String startTime;
  final String endTime;
  final int numberOfAttendees;
  final List<int> serviceIds;
  final String bookingType;

  BookingRequestEntity({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.numberOfAttendees,
    required this.serviceIds,
    required this.bookingType,
  });
}