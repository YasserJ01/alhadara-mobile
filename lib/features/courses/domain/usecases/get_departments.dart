// lib/features/courses/domain/usecases/get_courses.dart

import 'package:equatable/equatable.dart';
import 'package:project2/features/courses/domain/entites/course_types.dart';
import '../../../../errors/failures.dart';
import '../entites/department.dart';
import '../repositories/courses_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDepartments implements UseCase<List<Department>, NoParams> {
  final CoursesRepository repository;

  GetDepartments(this.repository);

  @override
  Future<List<Department>> call(NoParams params) async {
    try {
      return await repository.getDepartments();
    } on Failure catch (e) {
      rethrow; // Re-throw specific failures
    } catch (e) {
      throw ServerFailure(); // Convert unexpected errors to ServerFailure
    }
  }
}
class GetCourseTypes implements UseCase<List<CourseTypes>, int> {
  final CoursesRepository repository;

  GetCourseTypes(this.repository);

  @override
  Future<List<CourseTypes>> call(int department) async {

    try {
      return await repository.getCourseTypes(department);
    } on Failure catch (e) {
      rethrow; // Re-throw specific failures
    } catch (e) {
      throw ServerFailure(); // Convert unexpected errors to ServerFailure
    }
  }
}