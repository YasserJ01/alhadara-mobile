// lib/features/search/domain/entities/search_result.dart
import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final List<Department> departments;
  final List<CourseType> courseTypes;
  final List<Course> courses;

  const SearchResult({
    required this.departments,
    required this.courseTypes,
    required this.courses,
  });

  @override
  List<Object> get props => [departments, courseTypes, courses];
}

class Department extends Equatable {
  final int id;
  final String name;
  final String description;

  const Department({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [id, name, description];
}

class CourseType extends Equatable {
  final int id;
  final String name;
  final int department;
  final String departmentName;

  const CourseType({
    required this.id,
    required this.name,
    required this.department,
    required this.departmentName,
  });

  @override
  List<Object> get props => [id, name, department, departmentName];
}

class Course extends Equatable {
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
  final String category;
  final bool isInWishlist;
  final int wishlistCount;

  const Course({
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
    required this.category,
    required this.isInWishlist,
    required this.wishlistCount,
  });

  @override
  List<Object> get props => [
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
    category,
    isInWishlist,
    wishlistCount,
  ];
}