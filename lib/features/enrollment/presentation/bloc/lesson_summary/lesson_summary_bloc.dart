import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/lesson_summary.dart';
import '../../../domain/usecases/get_lesson_summaries.dart';
part 'lesson_summary_event.dart';
part 'lesson_summary_state.dart';

class LessonSummaryBloc extends Bloc<LessonSummaryEvent, LessonSummaryState> {
  final GetLessonSummaries getLessonSummaries;

  LessonSummaryBloc({required this.getLessonSummaries}) : super(LessonSummaryInitial()) {
    on<FetchLessonSummaries>(_onFetchLessonSummaries);
  }

  Future<void> _onFetchLessonSummaries(
      FetchLessonSummaries event,
      Emitter<LessonSummaryState> emit,
      ) async {
    emit(LessonSummaryLoading());
    try {
      final lessons = await getLessonSummaries(event.scheduleSlotId);
      emit(LessonSummariesLoaded(lessons));
    } catch (e) {
      emit(LessonSummaryError(e.toString()));
    }
  }
}