import 'dart:convert';
import 'package:project2/errors/expections.dart';
import 'package:project2/features/reset_password/data/models/security_question_model.dart';
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
      Uri.parse('https://alhadara-production.up.railway.app/api/core/reset-password/request_reset/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phoneNumber}),
    );
    print('Raw API response: ${response.body}');
    final responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody is Map<String, dynamic> &&
          responseBody['questions'] != null) {
        final questionsList = responseBody['questions'] as List;
        return questionsList
            .map((json) => SecurityQuestion.fromJson(json))
            .toList();
      }
    } else if (response.statusCode == 400) {
      if (responseBody.containsKey('phone')) {
        // Extract the first error message from the phone array
        final phoneError = (responseBody['phone'] as List).first;
        throw ValidationnException(phoneError);
      }
    } else if (response.statusCode == 429) {
      throw CacheException(responseBody['error']);
    } else {
      throw ServerException('Failed to login: ${response.statusCode}');
    }
    throw Exception('Invalid response format - missing questions array');
  }

  /*else {
        throw ServerException('Failed to login: ${response.statusCode}');
      }*/

  Future<ResetToken> validateSecurityAnswer({
    required String phoneNumber,
    required int questionId,
    required String answer,
  }) async {
    final response = await client.post(
      Uri.parse(
          'https://alhadara-production.up.railway.app/api/core/reset-password/validate_answers/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phone': phoneNumber,
        'question_id': questionId,
        'answer': answer,
      }),
    );
    final responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return ResetToken.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      print(response.body);
      if (responseBody.containsKey('answer')) {
        final phoneError = (responseBody['answer'] as List).first;
        throw ValidationnException(phoneError);
      }
    } else {
      throw Exception(
          'Failed to validate security answer ${response.statusCode}');
    }
    throw Exception('Invalid');
  }

  Future<void> confirmPasswordReset({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await client.post(
      Uri.parse('https://alhadara-production.up.railway.app/api/core/reset-password/confirm_reset/'),
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
