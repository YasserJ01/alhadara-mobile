import 'package:alhadara/features/hall_services/domain/entities/hall_booking.dart';

class BookingCreateModel {
  final int hall;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String bookingType;
  final int headcount;

  BookingCreateModel({
    required this.hall,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.bookingType,
    required this.headcount,
  });

  Map<String, dynamic> toJson() {
    return {
      'hall': hall,
      'date': date.toIso8601String().split('T')[0], // YYYY-MM-DD format
      'start_time': _formatTimeString(startTime),
      'end_time': _formatTimeString(endTime),
      'booking_type': bookingType,
      'headcount': headcount,
    };
  }

  // Helper method to ensure proper time format (HH:MM:SS)
  String _formatTimeString(String timeStr) {
    // If it's already in HH:MM:SS format, return as is
    if (RegExp(r'^\d{2}:\d{2}:\d{2}$').hasMatch(timeStr)) {
      return timeStr;
    }
    
    // If it's in HH:MM format, add seconds
    if (RegExp(r'^\d{2}:\d{2}$').hasMatch(timeStr)) {
      return '$timeStr:00';
    }
    
    // If it's an ISO datetime string, extract time part
    if (timeStr.contains('T')) {
      try {
        final dateTime = DateTime.parse(timeStr);
        return '${dateTime.hour.toString().padLeft(2, '0')}:'
               '${dateTime.minute.toString().padLeft(2, '0')}:'
               '${dateTime.second.toString().padLeft(2, '0')}';
      } catch (e) {
        // If parsing fails, return the original string
        return timeStr;
      }
    }
    
    // Default: assume it's already in correct format or add :00 if needed
    return timeStr.contains(':') && timeStr.split(':').length == 2 
        ? '$timeStr:00' 
        : timeStr;
  }
}

class BookingResponseModel {
  final int id;
  final int hall;
  final String hallName;
  final String date;
  final String startTime;
  final String endTime;
  final String bookingType;
  final int headcount;
  final double calculatedPrice;

  BookingResponseModel({
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

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      id: json['id'],
      hall: json['hall'],
      hallName: json['hall_name'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      bookingType: json['booking_type'],
      headcount: json['headcount'],
      calculatedPrice: double.parse(json['calculated_price'].toString()),
    );
  }
  
  BookingResponseEntity toEntity() {
    return BookingResponseEntity(
      id: id,
      hall: hall,
      hallName: hallName,
      date: date,
      startTime: startTime,
      endTime: endTime,
      bookingType: bookingType,
      headcount: headcount,
      calculatedPrice: calculatedPrice,
    );
  }
}