import 'package:equatable/equatable.dart';


//lessons_event.date
abstract class LessonsEvent extends Equatable {
  const LessonsEvent();

  @override
  List<Object> get props => [];
}

class LoadLessons extends LessonsEvent {
  final int scheduleSlotId;

  const LoadLessons(this.scheduleSlotId);

  @override
  List<Object> get props => [scheduleSlotId];
}

class FilterLessonsByDate extends LessonsEvent {
  final DateTime? selectedDate;

  const FilterLessonsByDate(this.selectedDate);

  @override
  List<Object> get props => [selectedDate ?? ''];
}