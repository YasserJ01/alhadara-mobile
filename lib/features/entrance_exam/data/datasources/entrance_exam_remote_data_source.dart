// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../../../../core/network/api_client.dart';
// import '../../../../errors/expections.dart';
// import '../models/answer_model.dart';
// import '../models/choice_model.dart';
// import '../models/exam_attempt_model.dart';
// import '../models/question_model.dart';
//
// abstract class EntranceExamRemoteDataSource {
//   Future<StartExamResponse> startExamByQr(String qrCode);
//   Future<ExamAttempt> getExamAttempt(int attemptId);
//   Future<void> submitMcqAnswers(int attemptId, SubmitAnswersRequest request);
// }
//
// class EntranceExamRemoteDataSourceImpl implements EntranceExamRemoteDataSource {
//   final http.Client client;
//   final ApiClient apiClient;
//   final String baseUrl = 'https://optimum-kodiak-hardy.ngrok-free.app/api/entrance-exam';
//
//   EntranceExamRemoteDataSourceImpl({required this.client,required this.apiClient});
//
//   @override
//   Future<StartExamResponse> startExamByQr(String qrCode) async {
//     try {
//       final response = await apiClient.authenticatedRequest(
//         method: 'POST',
//         endpoint: '/api/entrance-exam/exams/start_by_qr/',
//         body: json.encode({'qr_code': qrCode}),
//       );
//       // final response = await client.post(
//       //   Uri.parse('$baseUrl/exams/start_by_qr/'),
//       //   headers: {
//       //     'Content-Type': 'application/json',
//       //   },
//       //   body: json.encode({'qr_code': qrCode}),
//       // );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return StartExamResponse(id: data['id']);
//       } else if (response.statusCode == 401) {
//         throw UnauthorizedException('Unauthorized access');
//       } else if (response.statusCode == 404) {
//         throw NotFoundException('QR code not found');
//       } else {
//         throw ServerException('Failed to start exam: ${response.statusCode}');
//       }
//     } catch (e) {
//       if (e is UnauthorizedException || e is NotFoundException || e is ServerException) {
//         rethrow;
//       }
//       throw NetworkException('Network error occurred: $e');
//     }
//   }
//
//   @override
//   Future<ExamAttempt> getExamAttempt(int attemptId) async {
//     try {
//       final response = await apiClient.authenticatedRequest(
//         method: 'GET',
//         endpoint: '/api/entrance-exam/attempts/$attemptId/',
//       );
//       // final response = await client.get(
//       //   Uri.parse('/api/entrance-exam/attempts/$attemptId/'),
//       //   headers: {
//       //     'Content-Type': 'application/json',
//       //   },
//       // );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return _mapToExamAttempt(data);
//       } else if (response.statusCode == 401) {
//         throw UnauthorizedException('Unauthorized access');
//       } else if (response.statusCode == 404) {
//         throw NotFoundException('Exam attempt not found');
//       } else {
//         throw ServerException('Failed to get exam attempt: ${response.statusCode}');
//       }
//     } catch (e) {
//       if (e is UnauthorizedException || e is NotFoundException || e is ServerException) {
//         rethrow;
//       }
//       throw NetworkException('Network error occurred: $e');
//     }
//   }
//
//   @override
//   Future<void> submitMcqAnswers(int attemptId, SubmitAnswersRequest request) async {
//     try {
//       // '/api/entrance-exam/attempts/$attemptId/'
//       final response = await apiClient.authenticatedRequest(
//         method: 'POST',
//         endpoint: '/api/entrance-exam/attempts/$attemptId/submit_mcq_bulk/',
//         body: json.encode({
//           'answers': request.answers.map((answer) => {
//             'question': answer.question,
//             'choice_index': answer.choiceIndex,
//           }).toList(),
//         }),
//       );
//       // final response = await client.post(
//       //   Uri.parse('/api/entrance-exam/attempts/$attemptId/submit_mcq_bulk/'),
//       //   headers: {
//       //     'Content-Type': 'application/json',
//       //   },
//       //   body: json.encode({
//       //     'answers': request.answers.map((answer) => {
//       //       'question': answer.question,
//       //       'choice_index': answer.choiceIndex,
//       //     }).toList(),
//       //   }),
//       // );
//
//       if (response.statusCode == 200) {
//         return;
//       } else if (response.statusCode == 401) {
//         throw UnauthorizedException('Unauthorized access');
//       } else if (response.statusCode == 404) {
//         throw NotFoundException('Exam attempt not found');
//       } else {
//         throw ServerException('Failed to submit answers: ${response.statusCode}');
//       }
//     } catch (e) {
//       if (e is UnauthorizedException || e is NotFoundException || e is ServerException) {
//         rethrow;
//       }
//       throw NetworkException('Network error occurred: $e');
//     }
//   }
//
//   ExamAttempt _mapToExamAttempt(Map<String, dynamic> json) {
//     return ExamAttempt(
//       id: json['id'],
//       studentName: json['student_name'],
//       examTitle: json['exam_title'],
//       languageName: json['language_name'],
//       achievedLevelDisplay: json['achieved_level_display'],
//       timeRemainingMcq: json['time_remaining_mcq'],
//       canAccessMcq: json['can_access_mcq'],
//       questions: (json['questions'] as List)
//           .map((q) => _mapToQuestion(q))
//           .toList(),
//       answers: (json['answers'] as List)
//           .map((a) => Answer(
//         question: a['question'],
//         choiceIndex: a['choice_index'],
//       ))
//           .toList(),
//       startedAt: DateTime.parse(json['started_at']),
//       mcqCompletedAt: json['mcq_completed_at'] != null
//           ? DateTime.parse(json['mcq_completed_at'])
//           : null,
//       status: json['status'],
//       mcqScore: json['mcq_score'],
//       totalScore: json['total_score'],
//     );
//   }
//
//   Question _mapToQuestion(Map<String, dynamic> json) {
//     return Question(
//       id: json['id'],
//       text: json['text'],
//       questionType: json['question_type'],
//       points: json['points'],
//       order: json['order'],
//       choices: (json['choices'] as List)
//           .map((c) => Choice(
//         id: c['id'],
//         text: c['text'],
//         order: c['order'],
//       ))
//           .toList(),
//     );
//   }
// }

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/network/api_client.dart';
import '../../../../errors/expections.dart';
import '../models/answer_model.dart';
import '../models/choice_model.dart';
import '../models/exam_attempt_model.dart';
import '../models/question_model.dart';


abstract class EntranceExamRemoteDataSource {
  Future<StartExamResponse> startExamByQr(String qrCode);
  Future<ExamAttempt> getExamAttempt(int attemptId);
  Future<void> submitMcqAnswers(int attemptId, SubmitAnswersRequest request);
}

class EntranceExamRemoteDataSourceImpl implements EntranceExamRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;
  final String baseUrl = 'https://optimum-kodiak-hardy.ngrok-free.app/api/entrance-exam';

  EntranceExamRemoteDataSourceImpl({required this.client,required this.apiClient});

  @override
  Future<StartExamResponse> startExamByQr(String qrCode) async {
    print('🚀 Starting exam with QR: $qrCode');
    print('📤 Request URL: $baseUrl/exams/start_by_qr/');

    final requestBody = {'qr_code': qrCode};
    print('📤 Request Body: ${json.encode(requestBody)}');

    try {
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '/api/entrance-exam/exams/start_by_qr/',
        body: json.encode(requestBody),
      );
      // final response = await client.post(
      //   Uri.parse('$baseUrl/exams/start_by_qr/'),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'ngrok-skip-browser-warning': 'true', // Add this for ngrok
      //   },
      //   body: json.encode(requestBody),
      // );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Headers: ${response.headers}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print('✅ Successfully started exam with ID: ${data['id']}');
        return StartExamResponse(id: data['id']);
      } else if (response.statusCode == 401) {
        print('❌ Unauthorized access');
        throw UnauthorizedException('Unauthorized access');
      } else if (response.statusCode == 404) {
        print('❌ QR code not found');
        throw NotFoundException('QR code not found');
      } else if (response.statusCode >= 500) {
        print('❌ Server error: ${response.statusCode}');
        throw ServerException('Server error: ${response.statusCode} - ${response.body}');
      } else {
        print('❌ Client error: ${response.statusCode}');
        throw ApiException('Failed to start exam', response.statusCode, response.body);
      }
    } catch (e) {
      print('💥 Exception occurred: $e');
      if (e is UnauthorizedException ||
          e is NotFoundException ||
          e is ServerException ||
          e is ApiException) {
        rethrow;
      }
      throw NetworkException('Network error occurred: $e');
    }
  }

  @override
  Future<ExamAttempt> getExamAttempt(int attemptId) async {
    print('🔍 Getting exam attempt: $attemptId');
    print('📤 Request URL: $baseUrl/attempts/$attemptId/');

    try {
      final response = await apiClient.authenticatedRequest(
        method: 'GET',
        endpoint: '/api/entrance-exam/attempts/$attemptId/',
      );
      // final response = await client.get(
      //   Uri.parse('$baseUrl/attempts/$attemptId/'),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'ngrok-skip-browser-warning': 'true',
      //   },
      // );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body Length: ${response.body.length} chars');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('✅ Successfully loaded exam attempt');
        return _mapToExamAttempt(data);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access');
      } else if (response.statusCode == 404) {
        throw NotFoundException('Exam attempt not found');
      } else if (response.statusCode >= 500) {
        throw ServerException('Server error: ${response.statusCode} - ${response.body}');
      } else {
        throw ApiException('Failed to get exam attempt', response.statusCode, response.body);
      }
    } catch (e) {
      print('💥 Exception in getExamAttempt: $e');
      if (e is UnauthorizedException ||
          e is NotFoundException ||
          e is ServerException ||
          e is ApiException) {
        rethrow;
      }
      throw NetworkException('Network error occurred: $e');
    }
  }

  @override
  Future<void> submitMcqAnswers(int attemptId, SubmitAnswersRequest request) async {
    print('📝 Submitting answers for attempt: $attemptId');
    print('📤 Request URL: $baseUrl/attempts/$attemptId/submit_mcq_bulk/');

    final requestBody = {
      'answers': request.answers.map((answer) => {
        'question': answer.question,
        'choice_index': answer.choiceIndex,
      }).toList(),
    };
    print('📤 Request Body: ${json.encode(requestBody)}');

    try {
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '/api/entrance-exam/attempts/$attemptId/submit_mcq_bulk/',
        body: json.encode(requestBody),
      );
      // final response = await client.post(
      //   Uri.parse('$baseUrl/attempts/$attemptId/submit_mcq_bulk/'),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'ngrok-skip-browser-warning': 'true',
      //   },
      //   body: json.encode(requestBody),
      // );

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('✅ Successfully submitted answers');
        return;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access');
      } else if (response.statusCode == 404) {
        throw NotFoundException('Exam attempt not found');
      } else if (response.statusCode >= 500) {
        throw ServerException('Server error: ${response.statusCode} - ${response.body}');
      } else {
        throw ApiException('Failed to submit answers', response.statusCode, response.body);
      }
    } catch (e) {
      print('💥 Exception in submitMcqAnswers: $e');
      if (e is UnauthorizedException ||
          e is NotFoundException ||
          e is ServerException ||
          e is ApiException) {
        rethrow;
      }
      throw NetworkException('Network error occurred: $e');
    }
  }

  ExamAttempt _mapToExamAttempt(Map<String, dynamic> json) {
    try {
      print('🔄 Mapping exam attempt data...');
      return ExamAttempt(
        id: json['id'],
        studentName: json['student_name'],
        examTitle: json['exam_title'],
        languageName: json['language_name'],
        achievedLevelDisplay: json['achieved_level_display'],
        timeRemainingMcq: json['time_remaining_mcq'],
        canAccessMcq: json['can_access_mcq'],
        questions: (json['questions'] as List)
            .map((q) => _mapToQuestion(q))
            .toList(),
        answers: (json['answers'] as List)
            .map((a) => Answer(
          question: a['question'],
          choiceIndex: a['choice_index'],
        ))
            .toList(),
        startedAt: DateTime.parse(json['started_at']),
        mcqCompletedAt: json['mcq_completed_at'] != null
            ? DateTime.parse(json['mcq_completed_at'])
            : null,
        status: json['status'],
        mcqScore: json['mcq_score'],
        totalScore: json['total_score'],
      );
    } catch (e) {
      print('💥 Error mapping exam attempt: $e');
      print('📄 JSON data: ${json.toString()}');
      throw JsonException('Failed to parse exam data: $e');
    }
  }

  Question _mapToQuestion(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      questionType: json['question_type'],
      points: json['points'],
      order: json['order'],
      choices: (json['choices'] as List)
          .map((c) => Choice(
        id: c['id'],
        text: c['text'],
        order: c['order'],
      ))
          .toList(),
    );
  }
}