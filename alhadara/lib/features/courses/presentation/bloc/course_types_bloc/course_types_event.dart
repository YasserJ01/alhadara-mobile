part of 'course_types_bloc.dart';


abstract class CourseTypesEvent extends Equatable {
  const CourseTypesEvent();

  @override
  List<Object> get props => [];
}

class LoadCourseTypes extends CourseTypesEvent {
  final int department;
  const LoadCourseTypes(this.department);

  @override
  List<Object> get props => [department];

}