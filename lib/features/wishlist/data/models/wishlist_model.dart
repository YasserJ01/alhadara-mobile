import 'package:equatable/equatable.dart';
import 'wishlist_course_model.dart';

class WishlistModel extends Equatable {
  final int id;
  final int owner;
  final List<WishlistCourseModel> courses;
  final String createdAt;

  const WishlistModel({
    required this.id,
    required this.owner,
    required this.courses,
    required this.createdAt,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'] ?? 0,
      owner: json['owner'] ?? 0,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((course) => WishlistCourseModel.fromJson(course))
          .toList() ??
          [],
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner,
      'courses': courses.map((course) => course.toJson()).toList(),
      'created_at': createdAt,
    };
  }

  @override
  List<Object> get props => [id, owner, courses, createdAt];
}