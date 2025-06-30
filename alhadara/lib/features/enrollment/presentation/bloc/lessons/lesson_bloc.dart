import 'package:alhadara/features/enrollment/data/models/lesson_summary_model.dart';
import 'package:alhadara/features/enrollment/domain/entities/lesson_summary.dart';
import 'package:alhadara/features/enrollment/domain/usecases/get_lesson_summaries.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetLessonSummaries getLessonSummaries;

  LessonBloc({required this.getLessonSummaries}) : super(LessonInitial()) {
    on<FetchLessonSummaries>(_onFetchLessonSummaries);
  }

  Future<void> _onFetchLessonSummaries(
    FetchLessonSummaries event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoading());
    try {
      final lessons = await getLessonSummaries(event.scheduleSlotId);
      emit(LessonSummariesLoaded(lessons));
    } catch (e) {
      emit(LessonError(e.toString()));
    }
  }
}