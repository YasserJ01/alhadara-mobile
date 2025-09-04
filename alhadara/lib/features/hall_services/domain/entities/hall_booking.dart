class BookingCreateEntity {
  final int hall;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String bookingType;
  final int headcount;

  BookingCreateEntity({
    required this.hall,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.bookingType,
    required this.headcount,
  });
}

class BookingResponseEntity {
  final int id;
  final int hall;
  final String hallName;
  final String date;
  final String startTime;
  final String endTime;
  final String bookingType;
  final int headcount;
  final double calculatedPrice;

  BookingResponseEntity({
    required this.id,
    required this.hall,
    required this.hallName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.bookingType,
    required this.headcount,
    required this.calculatedPrice,
  });
}