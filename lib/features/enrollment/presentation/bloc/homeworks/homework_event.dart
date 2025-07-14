// bloc/homework_event.dart
import 'package:equatable/equatable.dart';

abstract class HomeworkEvent extends Equatable {
  const HomeworkEvent();

  @override
  List<Object> get props => [];
}

class GetHomeworkByLessonIdEvent extends HomeworkEvent {
  final int lessonId;

  const GetHomeworkByLessonIdEvent(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}