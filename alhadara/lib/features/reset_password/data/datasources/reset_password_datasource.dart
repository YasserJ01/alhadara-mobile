import 'dart:convert';
import 'package:alhadara/features/reset_password/data/models/security_question_model.dart';
import 'package:http/http.dart' as http;

class PasswordResetApi {
  final String baseUrl = 'http://10.0.2.2/api/core/reset-password';
  final http.Client client;

  PasswordResetApi({required this.client});

  // Future<List<SecurityQuestion>?> requestSecurityQuestion(
  //     String phoneNumber) async {
  //   final response = await client.post(
  //     Uri.parse('http://10.0.2.2:8000/api/core/reset-password/request_reset/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'phone': phoneNumber}),
  //   );
  //   final responseBody = json.decode(response.body);

  //   if (response.statusCode == 200) {
  //     if (responseBody is List) {
  //       return responseBody
  //           .map((json) => SecurityQuestion.fromJson(json))
  //           .toList();
  //       // return responseBody.cast<Map<String, dynamic>>();
  //     } else if (responseBody is Map<String, dynamic>) {
  //       // If API returns a single question as object, wrap it in a list
  //       print("Not working");
  //     } else {
  //       throw Exception('Unexpected response format');
  //     }
  //     // List<dynamic> jsonList = jsonDecode(response.body);
  //     // return jsonList.map((json) => SecurityQuestion.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to fetch security question');
  //   }
  // }
  Future<List<SecurityQuestion>> requestSecurityQuestion(
      String phoneNumber) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/core/reset-password/request_reset/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phoneNumber}),
    );

    print('Raw API response: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      try {
        if (responseBody is Map<String, dynamic> &&
            responseBody['questions'] != null) {
          final questionsList = responseBody['questions'] as List;
          return questionsList
              .map((json) => SecurityQuestion.fromJson(json))
              .toList();
        }
        throw Exception('Invalid response format - missing questions array');
      } catch (e) {
        throw Exception('Failed to parse questions: $e');
      }
    } else {
      throw Exception(
          'Failed to fetch security question. Status: ${response.statusCode}');
    }
  }

  Future<ResetToken> validateSecurityAnswer({
    required String phoneNumber,
    required int questionId,
    required String answer,
  }) async {
    final response = await client.post(
      Uri.parse(
          'http://10.0.2.2:8000/api/core/reset-password/validate_answers/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phone': phoneNumber,
        'question_id': questionId,
        'answer': answer,
      }),
    );

    if (response.statusCode == 200) {
      return ResetToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to validate security answer');
    }
  }

Future<void> confirmPasswordReset({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/core/reset-password/confirm_reset/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'reset_token': resetToken,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  }

}
