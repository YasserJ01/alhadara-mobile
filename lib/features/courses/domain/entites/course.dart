// features/courses/domain/entities/course.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DiscountInfo extends Equatable {
  final double discountPercentage;
  final String originalPrice;
  final String savings;
  final DateTime endDate;

  const DiscountInfo({
    required this.discountPercentage,
    required this.originalPrice,
    required this.savings,
    required this.endDate,
  });

  @override
  List<Object> get props => [
    discountPercentage,
    originalPrice,
    savings,
    endDate,
  ];
}
class Course extends Equatable{
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
  final int? requiredLanguage;
  final String? requiredLanguageName;
  final int? requiredLanguageLevel;
  final String? requiredLanguageLevelDisplay;
  final bool canEnroll;
  final String languageMessage;
  final bool hasDiscount;
  final DiscountInfo? discountInfo;
  final String? originalPrice;

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
    this.teacherName,
    required this.category,
    required this.wishlisted,
    this.requiredLanguage,
    required this.canEnroll,
    required this.languageMessage,
    this.requiredLanguageLevel,
    this.requiredLanguageLevelDisplay,
    this.requiredLanguageName,
    required this.hasDiscount,
    this.discountInfo,
    this.originalPrice,
  });
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
}