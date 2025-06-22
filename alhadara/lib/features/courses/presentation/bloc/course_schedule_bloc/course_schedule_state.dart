import 'package:equatable/equatable.dart';

import '../../../domain/entites/course_schedule.dart';

abstract class CourseScheduleState extends Equatable {
  const CourseScheduleState();

  @override
  List<Object?> get props => [];
}

class CourseScheduleInitial extends CourseScheduleState {}

class CourseScheduleLoading extends CourseScheduleState {}

class CourseScheduleLoaded extends CourseScheduleState {
  final List<CourseSchedule> schedules;

  const CourseScheduleLoaded(this.schedules);

  @override
  List<Object?> get props => [schedules];
}

class CourseScheduleError extends CourseScheduleState {
  final String message;

  const CourseScheduleError(this.message);

  @override
  List<Object?> get props => [message];
}
class CourseScheduleEmpty extends CourseScheduleState {
  final String message;

  const CourseScheduleEmpty({required this.message});

  @override
  List<Object> get props => [message];
}