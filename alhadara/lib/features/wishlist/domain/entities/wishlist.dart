import 'package:equatable/equatable.dart';
import 'wishlist_course.dart';

class Wishlist extends Equatable {
  final int id;
  final int owner;
  final List<WishlistCourse> courses;
  final String createdAt;

  const Wishlist({
    required this.id,
    required this.owner,
    required this.courses,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, owner, courses, createdAt];
}