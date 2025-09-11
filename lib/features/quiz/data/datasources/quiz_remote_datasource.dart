// data/datasources/quiz_remote_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_client.dart';
import '../../../../errors/expections.dart';
import '../models/quiz_answer_model.dart';
import '../models/quiz_model.dart';
import '../models/quiz_attempt_model.dart';
import '../models/quiz_question_model.dart';

abstract class QuizRemoteDataSource {
  Future<List<QuizModel>> getQuizzes(int scheduleSlotId);
  Future<QuizAttemptModel> startQuizAttempt(int quizId);
  Future<QuizQuestionResponse> getQuizQuestions(int quizId);
  Future<List<QuizAnswerModel>> submitAnswers({
    required int attemptId,
    required List<Map<String, dynamic>> answers,
  });
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;

  QuizRemoteDataSourceImpl(this.client, this.apiClient);

  @override
  Future<List<QuizModel>> getQuizzes(int scheduleSlotId) async {
    try {
      // final response = await client.get(
      //   Uri.parse('$baseUrl/quizzes/?schedule_slot=$scheduleSlotId'),
      //   headers: {'Content-Type': 'application/json'},
      // );
      final response = await apiClient.authenticatedRequest(
        method: 'GET',
        endpoint: '/api/quiz/quizzes/?schedule_slot=$scheduleSlotId&lang=ar',
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => QuizModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load quizzes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching quizzes: $e');
    }
  }

  @override
  Future<QuizAttemptModel> startQuizAttempt(int quizId) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '/api/quiz/quizzes/$quizId/start_attempt/',
        body: json.encode({'quiz_id': quizId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return QuizAttemptModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to start quiz attempt: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error starting quiz attempt: $e');
    }
  }

  @override
  Future<QuizQuestionResponse> getQuizQuestions(int quizId) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'GET',
        endpoint: '/api/quiz/quizzes/$quizId/questions_for_student/',
      );
      if (response.statusCode == 200) {
        return QuizQuestionResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load quiz questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching quiz questions: $e');
    }
  }

  @override
  Future<List<QuizAnswerModel>> submitAnswers({
    required int attemptId,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '/api/quiz/answers/bulk-submit/?attempt=$attemptId',
        jsonBody: {
          'attempt_id': attemptId,
          'answers': answers,
        },
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 201) {
        final List<dynamic> responseData = responseBody is List
            ? responseBody
            : [responseBody];
        return responseData.map((json) => QuizAnswerModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Session expired. Please login again.');
      } else if (response.statusCode == 400) {
        throw ValidationException(
          responseBody['errors'] is Map
              ? Map<String, dynamic>.from(responseBody['errors'])
              : {},
        );
      } else if (response.statusCode == 404) {
        throw NotFoundException('Quiz attempt not found');
      } else {
        throw ApiException(
          'Failed to submit answers',
          response.statusCode,
          responseBody,
        );
      }
    } on FormatException catch (_) {
      throw ServerException('Invalid server response format');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to submit answers: ${e.toString()}');
    }
  }
}

