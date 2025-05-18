
import 'package:project2/features/courses/domain/entites/course_types.dart';

import '../entites/department.dart';

abstract class CoursesRepository {
  Future<List<Department>> getDepartments();
  Future<List<CourseTypes>> getCourseTypes(int department);
}