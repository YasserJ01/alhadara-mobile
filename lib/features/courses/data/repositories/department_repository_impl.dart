import 'dart:io';

import 'package:project2/features/courses/domain/entites/course.dart';
import 'package:project2/features/courses/domain/entites/course_types.dart';

import '../../../../errors/failures.dart';
import '../../domain/entites/course_schedule.dart';
import '../../domain/entites/department.dart';
import '../../domain/repositories/courses_repository.dart';
import '../datasources/courses_remote_data_source.dart';

class DepartmentRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource remoteDataSource;

  DepartmentRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<Department>> getDepartments() async {
    try {
      final models = await remoteDataSource.getDepartments();
      print('Repository received models: $models'); // Debug
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e'); // Debug
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e'); // Debug
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e'); // Debug
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseTypes>> getCourseTypes(int department) async {
    try {
      final models = await remoteDataSource.getCourseTypes(department);
      print('Repository received models: $models'); // Debug
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e'); // Debug
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e'); // Debug
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e'); // Debug
      throw ServerFailure();
    }
  }

  @override
  Future<List<Course>> getCourses(int department, int courseType) async {
    try {
      final models = await remoteDataSource.getCourses(department, courseType);
      print('Repository received models: $models');
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e');
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e');
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e');
      throw ServerFailure();
    }
  }

  @override
  Future<List<CourseSchedule>> getCourseSchedule(int courseId) async {
    try {
      final models = await remoteDataSource.getCourseSchedule(courseId);
      print('Repository received models: $models'); // Debug
      return models.map((model) => model.toEntity()).toList();
    } on FormatException catch (e) {
      print('Repository format error: $e'); // Debug
      throw DataFormatFailure();
    } on HttpException catch (e) {
      print('Repository HTTP error: $e'); // Debug
      throw ServerFailure();
    } catch (e) {
      print('Repository unexpected error: $e'); // Debug
      throw ServerFailure();
    }
  }
}
