// features/courses/presentation/bloc/courses_bloc/courses_event.dart
part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

class LoadCourses extends CoursesEvent {
  final int department;
  final int courseType;
  final String category;

  const LoadCourses({
    required this.department,
    required this.courseType,
    required this.category,
  });

  @override
  List<Object> get props => [department, courseType, category];
}
