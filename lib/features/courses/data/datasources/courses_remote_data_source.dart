import 'dart:convert';
import 'dart:io';
import 'package:project2/features/courses/data/models/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:project2/errors/failures.dart';
import 'package:project2/features/courses/data/models/course_types_model.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/token.dart';
import '../models/course_schedule_model.dart';
import '../models/department_model.dart';

//datasource
abstract class CoursesRemoteDataSource {
  Future<List<DepartmentModel>> getDepartments();

  Future<List<CourseTypesModel>> getCourseTypes(int department);

  Future<List<CourseModel>> getCourses(int department, int courseType);

  Future<List<CourseScheduleModel>> getCourseSchedule(int courseId);

  Future<List<CourseModel>> getRecommendedCourses();

  Future<List<CourseModel>> getDealsCourses();
}

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final http.Client client;
  final ApiClient apiClient;
  static const Duration _requestTimeout = Duration(seconds: 10);

  CoursesRemoteDataSourceImpl(this.client, this.apiClient);

  @override
  Future<List<DepartmentModel>> getDepartments() async {
    try {
      print('Fetching departments from remote API...');
      final response = await client.get(
        Uri.parse(
            'https://optimum-kodiak-hardy.ngrok-free.app/api/courses/departments/?lang=ar'),
        // Uri.parse('http://192.168.1.3:8000/api/courses/departments/?lang=ar'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(_requestTimeout);
      print('Response status: ${response.statusCode}'); // Debug
      print('Response body: ${response.body}'); // Debug

      return _handleResponse(response);
    } on SocketException {
      print('Network error: No internet connection');
      throw NetworkFailure('No internet connection');
    } on HttpException catch (e) {
      print('HTTP error: $e');
      throw ServerFailure();
    } on FormatException catch (e) {
      print('JSON parsing error: $e');
      throw DataFormatFailure();
    } catch (e) {
      print('Unexpected error in remote data source: $e');
      if (e.toString().contains('TimeoutException')) {
        throw NetworkFailure('Request timeout');
      }
      throw ServerFailure();
    }
  }

  List<DepartmentModel> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final dynamic responseBody = json.decode(response.body);

      // Handle empty response with message
      if (responseBody is Map && responseBody.containsKey('message')) {
        print('Empty response received: ${responseBody['message']}');
        return [];
      }

      // Handle normal list response
      if (responseBody is List) {
        final departments = responseBody
            .map((json) =>
                DepartmentModel.fromJson(json as Map<String, dynamic>))
            .toList();

        print('Successfully parsed ${departments.length} departments');
        return departments;
      }

      print('Unexpected response format: ${responseBody.runtimeType}');
      throw DataFormatFailure();
    } else if (response.statusCode == 404) {
      print('Departments not found (404)');
      return []; // Return empty list for 404
    } else if (response.statusCode >= 500) {
      print('Server error: ${response.statusCode}');
      throw ServerFailure();
    } else {
      print('HTTP error: ${response.statusCode}');
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseTypesModel>> getCourseTypes(int department) async {
    final response = await client.get(
      Uri.parse(
          'https://optimum-kodiak-hardy.ngrok-free.app/api/courses/course-types/?department=$department'),
      // Uri.parse(
      //     'http://192.168.1.3:8000/api/courses/course-types/?department=$department'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print('Response status: ${response.statusCode}'); // Debug
    print('Response body: ${response.body}'); // Debug

    if (response.statusCode == 200) {
      final dynamic responseBody = json.decode(response.body);

      // Handle empty response case
      if (responseBody is Map && responseBody.containsKey('message')) {
        return []; // Return empty list when no courses found
      }

      // Handle normal list response
      if (responseBody is List) {
        return responseBody
            .map((json) => CourseTypesModel.fromJson(json))
            .toList();
      }
      throw DataFormatFailure();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseModel>> getCourses(int department, int courseType) async {
    // final response = await client.get(
    //   Uri.parse(
    //       'http://10.0.2.2:8000/api/courses/courses/?department=$department&course_type=$courseType'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'JWT ${Token.token}'
    //   },
    // );
    final response = await apiClient.authenticatedRequest(
      method: 'GET',
      endpoint:
          '/api/courses/courses/?department=$department&course_type=$courseType&lang=ar',
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic responseBody = json.decode(response.body);
      if (responseBody is Map && responseBody.containsKey('message')) {
        return [];
      }
      if (responseBody is List) {
        return responseBody.map((json) => CourseModel.fromJson(json)).toList();
      }
      throw DataFormatFailure();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseScheduleModel>> getCourseSchedule(int courseId) async {
    // final response = await client.get(
    //   Uri.parse(
    //       'http://10.0.2.2:8000/api/courses/schedule-slots/?course=$courseId'),
    //   headers: {'Content-Type': 'application/json'},
    // );
    final response = await apiClient.authenticatedRequest(
      method: 'GET',
      endpoint: '/api/courses/schedule-slots/?course=$courseId',
    );

    print('Response status: ${response.statusCode}'); // Debug
    print('Response body: ${response.body}'); // Debug

    if (response.statusCode == 200) {
      final dynamic responseBody = json.decode(response.body);

      // Handle empty response case
      if (responseBody is Map && responseBody.containsKey('message')) {
        return []; // Return empty list when no courses found
      }

      // Handle normal list response
      if (responseBody is List) {
        return responseBody
            .map((json) => CourseScheduleModel.fromJson(json))
            .toList();
      }
      throw DataFormatFailure();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseModel>> getRecommendedCourses() async {
    // final response = await client.get(
    //   Uri.parse('http://10.0.2.2:8000/api/courses/courses/recommendations/'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'JWT ${Token.token}'
    //   },
    // );
    final response = await apiClient.authenticatedRequest(
      method: 'GET',
      endpoint: '/api/courses/courses/recommendations/',
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic responseBody = json.decode(response.body);
      if (responseBody is Map && responseBody.containsKey('message')) {
        return [];
      }
      if (responseBody is List) {
        return responseBody.map((json) => CourseModel.fromJson(json)).toList();
      }
      throw DataFormatFailure();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseModel>> getDealsCourses() async {
    final response = await apiClient.authenticatedRequest(
      method: 'GET',
      endpoint: '/api/courses/courses/deals/?lang=ar',
    );
    // final response = await client.get(
    //   Uri.parse('http://10.0.2.2:8000/api/courses/courses/deals/?lang=ar'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'JWT ${Token.token}'
    //   },
    // );

    print('Deals response status: ${response.statusCode}');
    print('Deals response body: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic responseBody = json.decode(response.body);
      if (responseBody is Map && responseBody.containsKey('message')) {
        return [];
      }
      if (responseBody is List) {
        return responseBody.map((json) => CourseModel.fromJson(json)).toList();
      }
      throw DataFormatFailure();
    } else {
      throw ServerFailure();
    }
  }
}
