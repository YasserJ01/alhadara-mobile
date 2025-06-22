import 'package:equatable/equatable.dart';

class WishlistCourseModel extends Equatable {
  final String title;
  final String courseTypeName;

  const WishlistCourseModel({
    required this.title,
    required this.courseTypeName,
  });

  factory WishlistCourseModel.fromJson(Map<String, dynamic> json) {
    return WishlistCourseModel(
      title: json['title'] ?? '',
      courseTypeName: json['course_type_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'course_type_name': courseTypeName,
    };
  }

  @override
  List<Object> get props => [title, courseTypeName];
}
