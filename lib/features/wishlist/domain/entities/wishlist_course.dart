import 'package:equatable/equatable.dart';

class WishlistCourse extends Equatable {
  final String title;
  final String courseTypeName;

  const WishlistCourse({
    required this.title,
    required this.courseTypeName,
  });

  @override
  List<Object> get props => [title, courseTypeName];
}