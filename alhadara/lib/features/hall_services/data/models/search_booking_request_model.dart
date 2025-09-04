class BookingRequestModel {
  final DateTime date;
  final String startTime;
  final String endTime;
  final int numberOfAttendees;
  final List<int> serviceIds;
  final String bookingType; 

  BookingRequestModel({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.numberOfAttendees,
    required this.serviceIds,
    required this.bookingType,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String().split('T')[0],
      'start_time': startTime,
      'end_time': endTime,
      'number_of_attendees': numberOfAttendees,
      'service_ids': serviceIds,
      'booking_type': bookingType,
    };
  }

  void printDebugInfo() {
    print('Date: ${date.toIso8601String().split('T')[0]}');
    print('Start Time: $startTime');
    print('End Time: $endTime');
    print('Attendees: $numberOfAttendees');
    print('Service IDs: $serviceIds');
    print('Booking Type: $bookingType');
  }
}