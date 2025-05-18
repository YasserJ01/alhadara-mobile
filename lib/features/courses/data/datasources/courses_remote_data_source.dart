import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project2/errors/failures.dart';
import 'package:project2/features/courses/data/models/course_types_model.dart';
import '../models/department_model.dart';

abstract class CoursesRemoteDataSource {
  /// Calls the http://10.0.2.2/api/courses/departments/ endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<DepartmentModel>> getDepartments();

  Future<List<CourseTypesModel>> getCourseTypes(int department);
}



class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final http.Client client;

  CoursesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DepartmentModel>> getDepartments() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/courses/departments/'),
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
            .map((json) => DepartmentModel.fromJson(json))
            .toList();

      } throw DataFormatFailure();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseTypesModel>> getCourseTypes(int department) async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/courses/course-types/?department=$department'),
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

      } throw DataFormatFailure();
    } else {
      throw ServerFailure();
    }
  }
}


