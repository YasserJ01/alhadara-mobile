// // features/courses/domain/usecases/get_courses.dart
// import 'package:alhadara/features/courses/domain/entites/course.dart';
// import 'package:alhadara/features/courses/domain/repositories/courses_repository.dart';
// import 'package:alhadara/features/courses/domain/usecases/get_departments.dart';
// import 'package:alhadara/errors/failures.dart';

// class GetCourses implements UseCase<List<Course>, Params> {
//   final CoursesRepository repository;

//   GetCourses(this.repository);

//   @override
//   Future<Either<Failure, List<Course>>> call(Params params) async {
//     return await repository.getCourses(params.department, params.courseType);
//   }
// }

// class Params {
//   final int department;
//   final int courseType;

//   Params({required this.department, required this.courseType});
// }
// lib/features/courses/domain/usecases/get_courses.dart
import 'package:alhadara/features/courses/domain/usecases/get_departments.dart';
import 'package:equatable/equatable.dart';
import 'package:alhadara/features/courses/domain/entites/course.dart';
import '../../../../errors/failures.dart';
import '../repositories/courses_repository.dart';

class GetCourses implements UseCase<List<Course>, CourseParams> {
  final CoursesRepository repository;

  GetCourses(this.repository);

  @override
  Future<List<Course>> call(CourseParams params) async {
    try {
      return await repository.getCourses(params.department, params.courseType);
    } on Failure catch (e) {
      rethrow; // Re-throw specific failures
    } catch (e) {
      throw ServerFailure(); // Convert unexpected errors to ServerFailure
    }
  }
}

class CourseParams extends Equatable {
  final int department;
  final int courseType;

  const CourseParams({required this.department, required this.courseType});

  @override
  List<Object> get props => [department, courseType];
}