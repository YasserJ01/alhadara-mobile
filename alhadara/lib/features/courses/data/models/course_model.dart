// // features/courses/data/models/course_model.dart
// import 'package:alhadara/features/courses/domain/entites/course.dart';
// import 'package:equatable/equatable.dart';

// class CourseModel extends Equatable {
//   final int id;
//   final String title;
//   final String description;
//   final String price;
//   final int duration;
//   final int maxStudents;
//   final bool certificationEligible;
//   final int department;
//   final String departmentName;
//   final int courseType;
//   final String courseTypeName;
//   final String? teacherName;
//   final String category;
//   final bool wishlisted;

//   const CourseModel(
//       {required this.id,
//       required this.title,
//       required this.description,
//       required this.price,
//       required this.duration,
//       required this.maxStudents,
//       required this.certificationEligible,
//       required this.department,
//       required this.departmentName,
//       required this.courseType,
//       required this.courseTypeName,
//       this.teacherName,
//       required this.category,
//       required this.wishlisted});

//   factory CourseModel.fromJson(Map<String, dynamic> json) {
//     return CourseModel(
//         id: json['id'],
//         title: json['title'],
//         description: json['description'],
//         price: json['price'],
//         duration: json['duration'],
//         maxStudents: json['max_students'],
//         certificationEligible: json['certification_eligible'],
//         department: json['department'],
//         departmentName: json['department_name'],
//         courseType: json['course_type'],
//         courseTypeName: json['course_type_name'],
//         teacherName: json['teacher_name'],
//         category: json['category'],
//         wishlisted: json['is_in_wishlist']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'price': price,
//       'duration': duration,
//       'max_students': maxStudents,
//       'certification_eligible': certificationEligible,
//       'department': department,
//       'department_name': departmentName,
//       'course_type': courseType,
//       'course_type_name': courseTypeName,
//       'teacher_name': teacherName,
//       'category': category,
//       'is_in_wishlist': wishlisted,
//     };
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         description,
//         price,
//         duration,
//         maxStudents,
//         certificationEligible,
//         department,
//         departmentName,
//         courseType,
//         courseTypeName,
//         teacherName,
//         category,
//         wishlisted,
//       ];

//   Course toEntity() {
//     return Course(
//       id: id,
//       title: title,
//       description: description,
//       price: price,
//       duration: duration,
//       maxStudents: maxStudents,
//       certificationEligible: certificationEligible,
//       department: department,
//       departmentName: departmentName,
//       courseType: courseType,
//       courseTypeName: courseTypeName,
//       teacherName: teacherName,
//       category: category,
//       wishlisted: wishlisted,
//     );
//   }
// }
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
  final bool wishlisted;
  final bool hasDiscount;
  final DiscountInfo? discountInfo;
  final String? originalPrice;

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
    required this.wishlisted,
    required this.hasDiscount,
    this.discountInfo,
    this.originalPrice,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    DiscountInfo? parsedDiscountInfo;
    if (json['discount_info'] != null && json['discount_info'] is Map) {
      final discountJson = json['discount_info'];
      try {
        parsedDiscountInfo = DiscountInfo(
          discountPercentage: discountJson['discount_percentage'] ?? 0,
          originalPrice: discountJson['original_price']?.toString() ?? '0.00',
          savings: discountJson['savings']?.toString() ?? '0.00',
          endDate: DateTime.parse(discountJson['end_date']?.toString() ??
              DateTime.now().add(Duration(days: 30)).toString()),
        );
      } catch (e) {
        print('Error parsing discount info: $e');
        parsedDiscountInfo = null;
      }
    }

    return CourseModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price']?.toString() ?? '0.00',
      duration: json['duration'] ?? 0,
      maxStudents: json['max_students'] ?? 0,
      certificationEligible: json['certification_eligible'] ?? false,
      department: json['department'] ?? 0,
      departmentName: json['department_name']?.toString() ?? '',
      courseType: json['course_type'] ?? 0,
      courseTypeName: json['course_type_name']?.toString() ?? '',
      teacherName: json['teacher_name']?.toString(),
      category: json['category']?.toString() ?? '',
      wishlisted: json['is_in_wishlist'] ?? false,
      hasDiscount: json['has_discount'] ?? false,
      discountInfo: parsedDiscountInfo,
      originalPrice: json['original_price']?.toString(),
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
      'is_in_wishlist': wishlisted,
      'has_discount': hasDiscount,
      'discount_info': discountInfo != null
          ? {
              'discount_percentage': discountInfo!.discountPercentage,
              'original_price': discountInfo!.originalPrice,
              'savings': discountInfo!.savings,
              'end_date': discountInfo!.endDate.toIso8601String(),
            }
          : null,
      'original_price': originalPrice,
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
        wishlisted,
        hasDiscount,
        discountInfo,
        originalPrice,
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
      wishlisted: wishlisted,
      hasDiscount: hasDiscount,
      discountInfo: discountInfo,
      originalPrice: originalPrice,
    );
  }
}
