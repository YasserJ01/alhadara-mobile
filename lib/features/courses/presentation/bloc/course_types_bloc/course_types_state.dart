part of 'course_types_bloc.dart';

abstract class CourseTypesState extends Equatable {
  const CourseTypesState();

  @override
  List<Object> get props => [];
}

class CourseTypesInitial extends CourseTypesState {}

class CourseTypesLoading extends CourseTypesState {}

class CourseTypesLoaded extends CourseTypesState {
  final List<CourseTypes> courseTypes;

  const CourseTypesLoaded({required this.courseTypes});

  @override
  List<Object> get props => [courseTypes];
}

class CourseTypesError extends CourseTypesState {
  final String message;

  const CourseTypesError({required this.message});

  @override
  List<Object> get props => [message];
}
class CourseTypesEmpty extends CourseTypesState {
  final String message;

  const CourseTypesEmpty({required this.message});

  @override
  List<Object> get props => [message];
}