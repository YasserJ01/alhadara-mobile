// import 'dart:convert';

// import 'package:alhadara/core/token.dart';
// import 'package:alhadara/errors/expections.dart';
// import 'package:alhadara/features/enrollments/data/models/enrollment_model.dart';
// import 'package:http/http.dart'as http;

// abstract class EnrollmentRemoteDataSource {
//   Future<List<Enrollment>> getEnrollments();
// }

// class EnrollmentRemoteDataSourceImpl implements EnrollmentRemoteDataSource {
//   final http.Client client;

//   EnrollmentRemoteDataSourceImpl({required this.client});

//   @override
//   Future<List<Enrollment>> getEnrollments() async {
//     final response = await client.get(
//       Uri.parse('http://10.0.2.2:8000/api/courses/enrollments/'),
//       headers: {'Content-Type': 'application/json',
//       'Authorization': 'JWT ${Token.token}'},
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       return jsonData.map((json) => Enrollment.fromJson(json)).toList();
//     } else {
//       throw ServerException();
//     }
//   }
// }
import 'dart:convert';

import 'package:alhadara/core/token.dart';
import 'package:alhadara/errors/expections.dart';
import 'package:alhadara/features/enrollments/data/models/enrollment_model.dart';
import 'package:http/http.dart' as http;

abstract class EnrollmentRemoteDataSource {
  Future<List<Enrollment>> getEnrollments();
  Future<void> processPayment(int enrollmentId, double amount);
}

class EnrollmentRemoteDataSourceImpl implements EnrollmentRemoteDataSource {
  final http.Client client;

  EnrollmentRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Enrollment>> getEnrollments() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/courses/enrollments/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Enrollment.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> processPayment(int enrollmentId, double amount) async {
    final response = await client.post(
      // http://127.0.0.1:8000/api/courses/enrollments/1/process_payment/
      Uri.parse('http://10.0.2.2:8000/api/courses/enrollments/$enrollmentId/process_payment/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${Token.token}'
      },
      body: json.encode({
        'amount': amount,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}