
import 'package:alhadara/features/courses/domain/entites/course.dart';
import 'package:alhadara/features/courses/domain/entites/course_types.dart';

import '../entites/department.dart';

abstract class CoursesRepository {
  Future<List<Department>> getDepartments();
  Future<List<CourseTypes>> getCourseTypes(int department);
  Future<List<Course>> getCourses(int department, int courseType);
}