part of 'lesson_summary_bloc.dart';

abstract class LessonSummaryEvent extends Equatable {
  const LessonSummaryEvent();

  @override
  List<Object> get props => [];
}

class FetchLessonSummaries extends LessonSummaryEvent {
  final int scheduleSlotId;

  const FetchLessonSummaries(this.scheduleSlotId);

  @override
  List<Object> get props => [scheduleSlotId];
}