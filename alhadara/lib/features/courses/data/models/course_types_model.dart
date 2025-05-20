import 'package:equatable/equatable.dart';
import 'package:alhadara/features/courses/domain/entites/course_types.dart';



class CourseTypesModel extends Equatable {
  final int id;
  final String name;
  final int department;
  final String department_name;


  const CourseTypesModel({
    required this.id,
    required this.name,
    required this.department,
    required this.department_name,
  });

  factory CourseTypesModel.fromJson(Map<String, dynamic> json) {
    return CourseTypesModel(
      id: json['id'],
      name: json['name'],
      department: json['department'],
      department_name: json['department_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department':department,
      'department_name': department_name,
    };
  }

  @override
  List<Object> get props => [id, name, department,department_name];

  CourseTypes toEntity() {
    return CourseTypes(
      id: id,
      name: name,
      department: department,
      department_name:department_name,
    );
  }
}