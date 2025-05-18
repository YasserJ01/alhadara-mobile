import 'package:equatable/equatable.dart';

class CourseTypes extends Equatable {
  final int id;
  final String name;
  final int department;
  final String department_name;

  const CourseTypes({
    required this.id,
    required this.name,
    required this.department,
    required this.department_name,
  });

  @override
  List<Object> get props => [id, name, department, department_name];
}
