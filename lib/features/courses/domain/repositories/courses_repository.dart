import 'package:project2/features/courses/domain/entites/course.dart';
import 'package:project2/features/courses/domain/entites/course_schedule.dart';
import 'package:project2/features/courses/domain/entites/course_types.dart';

import '../entites/department.dart';

abstract class CoursesRepository {
  Future<List<Department>> getDepartments();
  Future<List<CourseTypes>> getCourseTypes(int department);
  Future<List<Course>> getCourses(int department, int courseType);
  Future<List<CourseSchedule>> getCourseSchedule(int courseID);
}