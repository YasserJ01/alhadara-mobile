// lib/features/search/data/models/search_result_model.dart
import '../../domain/entities/search_result.dart';

class SearchResultModel extends SearchResult {
  const SearchResultModel({
    required super.departments,
    required super.courseTypes,
    required super.courses,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      departments: (json['departments'] as List<dynamic>?)
          ?.map((e) => DepartmentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      courseTypes: (json['course_types'] as List<dynamic>?)
          ?.map((e) => CourseTypeModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class DepartmentModel extends Department {
  const DepartmentModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class CourseTypeModel extends CourseType {
  const CourseTypeModel({
    required super.id,
    required super.name,
    required super.department,
    required super.departmentName,
  });

  factory CourseTypeModel.fromJson(Map<String, dynamic> json) {
    return CourseTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      department: json['department'] as int,
      departmentName: json['department_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'department_name': departmentName,
    };
  }
}

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.duration,
    required super.maxStudents,
    required super.certificationEligible,
    required super.department,
    required super.departmentName,
    required super.courseType,
    required super.courseTypeName,
    required super.category,
    required super.isInWishlist,
    required super.wishlistCount,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      duration: json['duration'] as int,
      maxStudents: json['max_students'] as int,
      certificationEligible: json['certification_eligible'] as bool,
      department: json['department'] as int,
      departmentName: json['department_name'] as String,
      courseType: json['course_type'] as int,
      courseTypeName: json['course_type_name'] as String,
      category: json['category'] as String,
      isInWishlist: json['is_in_wishlist'] as bool,
      wishlistCount: json['wishlist_count'] as int,
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
      'category': category,
      'is_in_wishlist': isInWishlist,
      'wishlist_count': wishlistCount,
    };
  }
}