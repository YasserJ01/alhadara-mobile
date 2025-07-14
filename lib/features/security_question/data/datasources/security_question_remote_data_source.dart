import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/security_question_model.dart';

abstract class SecurityQuestionRemoteDataSource {
  Future<List<SecurityQuestionModel>> getSecurityQuestions(String token);

  Future<void> submitSecurityAnswer({
    // Add this method signature
    required String token,
    required int questionId,
    required String answer,
  });
}

class SecurityQuestionRemoteDataSourceImpl
    implements SecurityQuestionRemoteDataSource {
  final http.Client client;

  SecurityQuestionRemoteDataSourceImpl(this.client);

  @override
  Future<List<SecurityQuestionModel>> getSecurityQuestions(String token) async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/core/security-questions/'),
      headers: {
        'Authorization': 'JWT $token',
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=utf-8', // Add charset
      },
    );

    if (response.statusCode == 200) {
      final utf8Decoded = utf8.decode(response.bodyBytes);

      print(response.body);
      final List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((json) => SecurityQuestionModel.fromJson(json))
          .toList();
    } else {
      print(response.body);
      throw Exception(
          'Failed to load security questions: ${response.statusCode}');
    }
  }

  @override
  Future<void> submitSecurityAnswer({
    required String token,
    required int questionId,
    required String answer,
  }) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8000/api/core/security-answers/'),
      headers: {
        'Authorization': 'JWT $token',
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({
        'question': questionId,
        'answer': answer,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to submit security answer');
    }
  }
}
