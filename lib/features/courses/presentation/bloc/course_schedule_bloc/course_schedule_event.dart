import 'package:equatable/equatable.dart';

abstract class CourseScheduleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCourseSchedule extends CourseScheduleEvent {
  final int courseId;

  LoadCourseSchedule(this.courseId);

  @override
  List<Object> get props => [courseId];
}