import 'package:equatable/equatable.dart';

abstract class EnrollEvent extends Equatable {
  const EnrollEvent();

  @override
  List<Object> get props => [];
}

class EnrollInCourseEvent extends EnrollEvent {
  final int courseId;
  final int scheduleSlotId;

  const EnrollInCourseEvent({
    required this.courseId,
    required this.scheduleSlotId,
  });

  @override
  List<Object> get props => [courseId, scheduleSlotId];
}
