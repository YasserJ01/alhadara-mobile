// lib/features/courses/domain/usecases/get_deals_courses.dart
import 'get_departments.dart';
import 'package:equatable/equatable.dart';
import '../entites/course.dart';
import '../../../../errors/failures.dart';
import '../repositories/courses_repository.dart';

class GetDealsCourses implements UseCase<List<Course>, NoParams> {
  final CoursesRepository repository;

  GetDealsCourses(this.repository);

  @override
  Future<List<Course>> call(NoParams params) async {
    try {
      return await repository.getDealsCourses();
    } on Failure catch (e) {
      rethrow;
    } catch (e) {
      throw ServerFailure();
    }
  }
}