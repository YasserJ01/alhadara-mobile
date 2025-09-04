import 'dart:convert';

import 'package:alhadara/core/token.dart';
import 'package:alhadara/features/hall_services/data/models/hall_booking.dart';
import 'package:alhadara/features/hall_services/data/models/search_booking_request_model.dart';
import 'package:alhadara/features/hall_services/data/models/result_hall_booking_model.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;

abstract class HallBookingRemoteDataSource {
  Future<List<HallBookingModel>> searchHalls(BookingRequestModel request);
  Future<List<ServiceModel>> getServices();
  Future<BookingResponseModel> createBooking(BookingCreateModel booking);
}

class HallBookingRemoteDataSourceImpl implements HallBookingRemoteDataSource {
  final http.Client client;

  HallBookingRemoteDataSourceImpl({required this.client});

  @override
  Future<List<HallBookingModel>> searchHalls(
      BookingRequestModel request) async {
    {
      final response = await client.post(
        Uri.parse('http://10.0.2.2:8000/api/courses/halls/search-for-booking/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => HallBookingModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load halls: ${response.statusCode}');
      }
    }
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    {
      final response = await client.get(
        Uri.parse('http://10.0.2.2:8000/api/courses/hall-services/'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    }
  }

  @override
  Future<BookingResponseModel> createBooking(BookingCreateModel booking) async {
    final bookingJson = booking.toJson();
    final requestBody = json.encode(bookingJson);
    print('Booking Request Body: $requestBody');
    print(
        'Booking Request JSON: $bookingJson'); // This shows the formatted JSON object

    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/courses/bookings/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}',
      },
      body: json.encode(booking.toJson()),
    );

    print('Booking Response status: ${response.statusCode}');
    print('Booking Response body: ${response.body}');
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return BookingResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to create booking: ${response.statusCode}');
    }
  }
}
