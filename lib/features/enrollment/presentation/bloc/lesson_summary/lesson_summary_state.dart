part of 'lesson_summary_bloc.dart';

abstract class LessonSummaryState extends Equatable {
  const LessonSummaryState();

  @override
  List<Object> get props => [];
}

class LessonSummaryInitial extends LessonSummaryState {}

class LessonSummaryLoading extends LessonSummaryState {}

class LessonSummariesLoaded extends LessonSummaryState {
  final List<LessonSummary> lessons;

  const LessonSummariesLoaded(this.lessons);

  @override
  List<Object> get props => [lessons];
}

class LessonSummaryError extends LessonSummaryState {
  final String message;

  const LessonSummaryError(this.message);

  @override
  List<Object> get props => [message];
}