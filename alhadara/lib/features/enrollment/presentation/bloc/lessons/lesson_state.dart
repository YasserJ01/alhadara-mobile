part of 'lesson_bloc.dart';

abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object> get props => [];
}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonSummariesLoaded extends LessonState {
  final List<LessonSummary> lessons;

  const LessonSummariesLoaded(this.lessons);

  @override
  List<Object> get props => [lessons];
}

class LessonError extends LessonState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object> get props => [message];
}