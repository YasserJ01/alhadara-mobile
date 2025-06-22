// lib/features/courses/domain/usecases/get_recommended_courses.dart

import 'package:alhadara/features/courses/domain/usecases/get_departments.dart';
import 'package:equatable/equatable.dart';
import 'package:alhadara/features/courses/domain/entites/course.dart';
import '../../../../errors/failures.dart';
import '../repositories/courses_repository.dart';

class GetRecommendedCourses implements UseCase<List<Course>, NoParams> {
  final CoursesRepository repository;

  GetRecommendedCourses(this.repository);

  @override
  Future<List<Course>> call(NoParams params) async {
    try {
      return await repository.getRecommendedCourses();
    } on Failure catch (e) {
      rethrow; // Re-throw specific failures
    } catch (e) {
      throw ServerFailure(); // Convert unexpected errors to ServerFailure
    }
  }
}