// features/courses/data/models/course_model.dart
import 'package:alhadara/features/courses/domain/entites/course.dart';
import 'package:equatable/equatable.dart';

class CourseModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String price;
  final int duration;
  final int maxStudents;
  final bool certificationEligible;
  final int department;
  final String departmentName;
  final int courseType;
  final String courseTypeName;
  final String? teacherName;
  final String category;

  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.maxStudents,
    required this.certificationEligible,
    required this.department,
    required this.departmentName,
    required this.courseType,
    required this.courseTypeName,
    this.teacherName,
    required this.category,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      duration: json['duration'],
      maxStudents: json['max_students'],
      certificationEligible: json['certification_eligible'],
      department: json['department'],
      departmentName: json['department_name'],
      courseType: json['course_type'],
      courseTypeName: json['course_type_name'],
      teacherName: json['teacher_name'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'duration': duration,
      'max_students': maxStudents,
      'certification_eligible': certificationEligible,
      'department': department,
      'department_name': departmentName,
      'course_type': courseType,
      'course_type_name': courseTypeName,
      'teacher_name': teacherName,
      'category': category,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        duration,
        maxStudents,
        certificationEligible,
        department,
        departmentName,
        courseType,
        courseTypeName,
        teacherName,
        category,
      ];

  Course toEntity() {
    return Course(
      id: id,
      title: title,
      description: description,
      price: price,
      duration: duration,
      maxStudents: maxStudents,
      certificationEligible: certificationEligible,
      department: department,
      departmentName: departmentName,
      courseType: courseType,
      courseTypeName: courseTypeName,
      teacherName: teacherName,
      category: category,
    );
  }
}