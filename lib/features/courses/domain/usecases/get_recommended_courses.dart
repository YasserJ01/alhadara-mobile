// lib/features/courses/domain/usecases/get_recommended_courses.dart

import 'get_departments.dart';
import '../../../../errors/failures.dart';
import '../entites/course.dart';
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