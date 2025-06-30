// features/courses/data/datasources/enrollment_remote_data_source.dart
import 'dart:convert';
import 'package:alhadara/features/enrollment/data/models/lesson_summary_model.dart';
import 'package:alhadara/features/enrollment/domain/entities/lesson_summary.dart';
import 'package:http/http.dart' as http;
import '../../../../core/token.dart';
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../models/enroll_model.dart';
import '../models/user_enrollment_model.dart';

abstract class EnrollmentRemoteDataSource {
  Future<EnrollModel> enrollInCourse({
    required int courseId,
    required int scheduleSlotId,
    required String notes,
  });
  Future<List<UserEnrollment>> getEnrollments();
  Future<UserEnrollment> getEnrollmentDetails(int enrollmentId);
  Future<void> processPayment(int enrollmentId, double amount);
  Future<List<LessonSummary>> getLessonSummaries(int scheduleSlotId);

}

class EnrollmentRemoteDataSourceImpl implements EnrollmentRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  EnrollmentRemoteDataSourceImpl({required this.client});

  @override
  Future<EnrollModel> enrollInCourse({
    required int courseId,
    required int scheduleSlotId,
    required String notes,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/courses/enrollments/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'
      },
      body: json.encode({
        'course': courseId,
        'schedule_slot': scheduleSlotId,
        'notes': notes,
      }),
    );

    if (response.statusCode == 201) {
      return EnrollModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      final errorResponse = json.decode(response.body);
      if (errorResponse.containsKey('non_field_errors')) {
        throw ValidationnException(errorResponse['non_field_errors'][0]);
      }
      throw HttpFailure();
    } else {
      throw HttpFailure();
    }
  }
  // @override
  // Future<EnrollModel> enrollInCourse({
  //   required int courseId,
  //   required int scheduleSlotId,
  //   required String notes,
  // }) async {
  //   final response = await client.post(
  //     Uri.parse('$baseUrl/courses/enrollments/'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'JWT ${Token.token}'
  //     },
  //     body: json.encode({
  //       'course': courseId,
  //       'schedule_slot': scheduleSlotId,
  //       'notes': notes,
  //     }),
  //   );
  //
  //   if (response.statusCode == 201) {
  //     return EnrollModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw HttpFailure();
  //   }
  // }

  @override
  Future<List<UserEnrollment>> getEnrollments() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/courses/enrollments/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => UserEnrollment.fromJson(json)).toList();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<UserEnrollment> getEnrollmentDetails(int enrollmentId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/courses/enrollments/$enrollmentId/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'
      },
    );

    if (response.statusCode == 200) {
      return UserEnrollment.fromJson(json.decode(response.body));
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<void> processPayment(int enrollmentId, double amount) async {
    final response = await client.post(
      Uri.parse(
          'http://10.0.2.2:8000/api/courses/enrollments/$enrollmentId/process_payment/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'
      },
      body: json.encode({
        'amount': amount,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerFailure();
    }
  }
    @override
  Future<List<LessonSummary>> getLessonSummaries(int scheduleSlotId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/lessons/lessons/summary/?schedule_slot=$scheduleSlotId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => LessonSummaryModel.fromJson(json)).toList();
    } else {
      throw ServerFailure();
    }
  }
}
