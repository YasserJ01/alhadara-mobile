// features/courses/data/models/course_model.dart
import 'package:project2/features/courses/domain/entites/course.dart';
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
  final int? requiredLanguage;
  final String? requiredLanguageName;
  final int? requiredLanguageLevel;
  final String? requiredLanguageLevelDisplay;
  final bool canEnroll;
  final String languageMessage;
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
      wishlisted: json['is_in_wishlist'],
      requiredLanguage: json['required_language'],
      requiredLanguageName: json['required_language_name'],
      requiredLanguageLevel: json['required_language_level'],
      requiredLanguageLevelDisplay: json['required_language_level_display'],
      canEnroll: json['language_requirement_met']['can_enroll'],
      languageMessage: json['language_requirement_met']['message'],
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
      'required_language': requiredLanguage,
      'required_language_name': requiredLanguageName,
      'required_language_level': requiredLanguageLevel,
      'required_language_level_display': requiredLanguageLevelDisplay,
      'can_enroll': canEnroll,
      'message': languageMessage,
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
        requiredLanguage,
        requiredLanguageName,
        requiredLanguageLevel,
        requiredLanguageLevelDisplay,
        canEnroll,
        languageMessage,
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
      requiredLanguage: requiredLanguage,
      requiredLanguageName: requiredLanguageName,
      requiredLanguageLevel: requiredLanguageLevel,
      requiredLanguageLevelDisplay: requiredLanguageLevelDisplay,
      canEnroll: canEnroll,
      languageMessage: languageMessage,
      hasDiscount: hasDiscount,
      discountInfo: discountInfo,
      originalPrice: originalPrice,
    );
  }
}

