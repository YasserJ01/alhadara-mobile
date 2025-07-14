// features/courses/data/datasources/enrollment_remote_data_source.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../../../../core/network/api_client.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/token.dart';
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../models/bulletin_post_model.dart';
import '../models/enroll_model.dart';
import '../models/homework_model.dart';
import '../models/lesson_model.dart';
import '../models/news_feed_model.dart';
import '../models/user_enrollment_model.dart';

abstract class EnrollmentRemoteDataSource {
  Future<EnrollModel> enrollInCourse({
    required int courseId,
    required int scheduleSlotId,
    required String notes,
  });

  Future<List<UserEnrollment>> getEnrollments();

  Future<void> processPayment(int enrollmentId, double amount);

  Future<List<LessonModel>> getLessons(int scheduleSlotId);

  Future<List<HomeworkModel>> getHomeworkByLessonId(int lessonId);

  Future<List<NewsFeedModel>> getNewsFeed(int scheduleSlotId);

  Future<Map<String, dynamic>> createLesson({
    required String title,
    String? notes,
    File? file,
    String? link,
    required int courseId,
    required int scheduleSlotId,
    required String lessonDate,
    required String status,
  });

  Future<void> createHomework({
    required String title,
    required String description,
    required String formLink,
    required DateTime deadline,
    required int lessonId,
    required int maxScore,
    required bool isMandatory,
  });

  Future<void> createBulkAttendance({
    required List<Map<String, dynamic>> records,
  });

  Future<void> publishPost(BulletinPostModel post);

}

class EnrollmentRemoteDataSourceImpl implements EnrollmentRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  EnrollmentRemoteDataSourceImpl(this.client, this.apiClient);

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
  Future<List<LessonModel>> getLessons(int scheduleSlotId) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'GET',
        endpoint: '/api/lessons/lessons/?schedule_slot=$scheduleSlotId',
      );
      // final response = await client.get(
      //   Uri.parse('http://10.0.2.2:8000/api/lessons/lessons/?schedule_slot=$scheduleSlotId'),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     // Add your auth headers here if needed
      //     // 'Authorization': 'Bearer $token',
      //   },
      // );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => LessonModel.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw NotFoundException(
            'Lessons not found for schedule slot $scheduleSlotId');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access to lessons');
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        throw ValidationnException('Invalid request parameters');
      } else {
        throw ServerException('Server error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ApiException ||
          e is ServerException ||
          e is UnauthorizedException ||
          e is ValidationnException ||
          e is NotFoundException) {
        rethrow;
      }
      throw ServerException('Failed to fetch lessons: ${e.toString()}');
    }
  }

  @override
  Future<List<HomeworkModel>> getHomeworkByLessonId(int lessonId) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'GET',
        endpoint: '/api/lessons/homework/?lesson=$lessonId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => HomeworkModel.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw NotFoundException('Homework not found for lesson $lessonId');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access');
      } else if (response.statusCode >= 500) {
        throw ServerException('Server error: ${response.statusCode}');
      } else {
        throw ApiException(
          'Failed to load homework',
          response.statusCode,
          response.body,
        );
      }
    } catch (e) {
      if (e is ApiException ||
          e is ServerException ||
          e is UnauthorizedException ||
          e is NotFoundException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<List<NewsFeedModel>> getNewsFeed(int scheduleSlotId) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'GET',
        endpoint: '/api/lessons/newsfeed?scheduleslot=$scheduleSlotId',
      );
      // final response = await dio.get(
      //   '/api/lessons/newsfeed',
      //   queryParameters: {'scheduleslot': scheduleSlotId},
      // );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => NewsFeedModel.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw NotFoundException('News feed not found');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access');
      } else if (response.statusCode >= 500) {
        throw ServerException('Server error: ${response.statusCode}');
      } else {
        throw ApiException(
          'Failed to load news feed',
          response.statusCode,
          response.body,
        );
      }
    } catch (e) {
      if (e is ApiException ||
          e is ServerException ||
          e is UnauthorizedException ||
          e is NotFoundException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> createLesson({
    required String title,
    String? notes,
    File? file,
    String? link,
    required int courseId,
    required int scheduleSlotId,
    required String lessonDate,
    required String status,
  }) async {
    try {
      if (file != null) {
        // Handle file upload with multipart request
        final uri = Uri.parse('${apiClient.baseUrl}/api/lessons/lessons/');
        var request = http.MultipartRequest('POST', uri);

        // Get access token
        final accessToken = await TokenService.getAccessToken();
        if (accessToken == null) {
          throw UnauthorizedException('No valid token available');
        }

        // Set headers
        request.headers['Authorization'] = 'JWT $accessToken';

        // Add fields
        request.fields.addAll({
          'title': title,
          'course': courseId.toString(),
          'schedule_slot': scheduleSlotId.toString(),
          'lesson_date': lessonDate,
          'status': status,
        });

        if (notes != null) request.fields['notes'] = notes;
        if (link != null) request.fields['link'] = link;

        // Add file
        request.files.add(await http.MultipartFile.fromPath('file', file.path));

        // Send request
        final response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 201) {
          return json.decode(responseBody);
        } else if (response.statusCode == 401) {
          throw UnauthorizedException('Unauthorized access');
        } else if (response.statusCode >= 500) {
          throw ServerException('Server error: ${response.statusCode}');
        } else {
          throw ApiException(
            'Failed to create lesson',
            response.statusCode,
            responseBody,
          );
        }
      } else {
        // Regular JSON request without file
        final response = await apiClient.authenticatedRequest(
          method: 'POST',
          endpoint: '/api/lessons/lessons/',
          jsonBody: {
            'title': title,
            'notes': notes,
            'link': link,
            'course': courseId,
            'schedule_slot': scheduleSlotId,
            'lesson_date': lessonDate,
            'status': status,
          },
        );

        if (response.statusCode == 201) {
          return json.decode(response.body);
        } else if (response.statusCode == 401) {
          throw UnauthorizedException('Unauthorized access');
        } else if (response.statusCode >= 500) {
          throw ServerException('Server error: ${response.statusCode}');
        } else {
          throw ApiException(
            'Failed to create lesson',
            response.statusCode,
            response.body,
          );
        }
      }
    } catch (e) {
      if (e is ApiException ||
          e is ServerException ||
          e is UnauthorizedException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }
  @override
  Future<void> createHomework({
    required String title,
    required String description,
    required String formLink,
    required DateTime deadline,
    required int lessonId,
    required int maxScore,
    required bool isMandatory,
  }) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '/api/lessons/homework/',
        jsonBody: {
          'title': title,
          'description': description,
          'form_link': formLink,
          'deadline': deadline.toIso8601String(),
          'lesson': lessonId,
          'max_score': maxScore,
          'is_mandatory': isMandatory,
        },
      );

      if (response.statusCode != 201) {
        if (response.statusCode == 401) {
          throw UnauthorizedException('Unauthorized access');
        } else if (response.statusCode >= 500) {
          throw ServerException('Server error: ${response.statusCode}');
        } else {
          throw ApiException(
            'Failed to create homework',
            response.statusCode,
            response.body,
          );
        }
      }
    } catch (e) {
      if (e is ApiException ||
          e is ServerException ||
          e is UnauthorizedException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }


  @override
  Future<void> createBulkAttendance({
    required List<Map<String, dynamic>> records,
  }) async {
    try {
      final response = await apiClient.authenticatedRequest(
        method: 'POST',
        endpoint: '/api/lessons/attendance/bulk/',
        jsonBody: {'records': records},
      );

      if (response.statusCode != 201) {
        if (response.statusCode == 401) {
          throw UnauthorizedException('Unauthorized access');
        } else if (response.statusCode >= 500) {
          throw ServerException('Server error: ${response.statusCode}');
        } else {
          throw ApiException(
            'Failed to create attendance',
            response.statusCode,
            response.body,
          );
        }
      }
    } catch (e) {
      if (e is ApiException ||
          e is ServerException ||
          e is UnauthorizedException) {
        rethrow;
      }
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> publishPost(BulletinPostModel post) async {
    try {
      final uri = Uri.parse('http://10.0.2.2:8000/api/lessons/newsfeed');

      var request = http.MultipartRequest('POST', uri);

      // Get access token
      final accessToken = await TokenService.getAccessToken();
      if (accessToken == null) {
        throw UnauthorizedException('No valid token available');
      }
      request.headers['Authorization'] = 'JWT $accessToken';
      // Add fields
      request.fields['scheduleslot'] = post.scheduleSlotId.toString();
      request.fields['type'] = post.type;
      request.fields['title'] = post.title;
      request.fields['content'] = post.content;

      // Handle file upload based on type
      if (post.type == 'file' && post.file != null) {
        final file = File(post.file!);
        if (await file.exists()) {
          request.files.add(await http.MultipartFile.fromPath(
            'file',
            file.path,
            filename: path.basename(file.path),
          ));
        }
      } else if (post.type == 'image' && post.image != null) {
        final file = File(post.image!);
        if (await file.exists()) {
          request.files.add(await http.MultipartFile.fromPath(
            'image',
            file.path,
            filename: path.basename(file.path),
          ));
        }
      }
      print('  - schedule_slot: ${post.scheduleSlotId}');


      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print('❌ DEBUG: Error response: $responseBody');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access');
      } else if (response.statusCode == 422) {
        final Map<String, dynamic> errorData = json.decode(responseBody);
        throw ValidationException(errorData);
      } else if (response.statusCode == 404) {
        throw NotFoundException('Resource not found');
      } else if (response.statusCode >= 500) {
        throw ServerException('Server error occurred');
      } else {
        throw ApiException(
          'Failed to publish post',
          response.statusCode,
          responseBody,
        );
      }
    } catch (e) {
      if (e is ApiException ||
          e is ServerException ||
          e is UnauthorizedException ||
          e is ValidationException ||
          e is NotFoundException) {
        rethrow;
      }
      throw ServerException('Network error occurred');
    }
  }
}
