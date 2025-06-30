part of 'lesson_bloc.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

class FetchLessonSummaries extends LessonEvent {
  final int scheduleSlotId;

  const FetchLessonSummaries(this.scheduleSlotId);

  @override
  List<Object> get props => [scheduleSlotId];
}