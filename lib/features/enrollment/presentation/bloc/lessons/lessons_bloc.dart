// bloc/lessons_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../errors/failures.dart';
import '../../../domain/usecases/get_lessons.dart';
import 'lessons_event.dart';
import 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  final GetLessons getLessons;

  LessonsBloc({required this.getLessons}) : super(LessonsInitial()) {
    on<LoadLessons>(_onLoadLessons);
    on<FilterLessonsByDate>(_onFilterLessonsByDate);
  }

  Future<void> _onLoadLessons(
    LoadLessons event,
    Emitter<LessonsState> emit,
  ) async {
    emit(LessonsLoading());

    try {
      final lessons = await getLessons(event.scheduleSlotId);
      emit(LessonsLoaded(
        allLessons: lessons,
        filteredLessons: lessons,
        selectedDate: null,
      ));
    } on ServerFailure {
      emit(const LessonsError('Server error occurred'));
    } on NotFoundFailure catch (e) {
      emit(LessonsError(e.message));
    } on HttpFailure {
      emit(const LessonsError('Network error occurred'));
    } on DataFormatFailure {
      emit(const LessonsError('Invalid data format'));
    } catch (e) {
      emit(const LessonsError('An unexpected error occurred'));
    }
  }

  void _onFilterLessonsByDate(
    FilterLessonsByDate event,
    Emitter<LessonsState> emit,
  ) {
    if (state is LessonsLoaded) {
      final currentState = state as LessonsLoaded;

      // If date is null or outside our range, show all lessons
      if (event.selectedDate == null || !_isDateInRange(event.selectedDate!)) {
        emit(currentState.copyWith(
          filteredLessons: currentState.allLessons,
          selectedDate: null,
        ));
        return;
      }

      // Filter lessons by selected date
      final filteredLessons = currentState.allLessons
          .where((lesson) => _isSameDay(lesson.lessonDate, event.selectedDate!))
          .toList();

      emit(currentState.copyWith(
        filteredLessons: filteredLessons,
        selectedDate: event.selectedDate,
      ));
    }
  }

  // void _onFilterLessonsByDate(
  //     FilterLessonsByDate event,
  //     Emitter<LessonsState> emit,
  //     ) {
  //   if (state is LessonsLoaded) {
  //     final currentState = state as LessonsLoaded;
  //
  //     if (event.selectedDate == null) {
  //       // Show all lessons
  //       emit(currentState.copyWith(
  //         filteredLessons: currentState.allLessons,
  //         selectedDate: null,
  //       ));
  //     } else {
  //       // Filter lessons by selected date
  //       final filteredLessons = currentState.allLessons
  //           .where((lesson) => _isSameDay(lesson.lessonDate, event.selectedDate!))
  //           .toList();
  //
  //       emit(currentState.copyWith(
  //         filteredLessons: filteredLessons,
  //         selectedDate: event.selectedDate,
  //       ));
  //     }
  //   }
  // }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

bool _isDateInRange(DateTime date) {
  final startDate = DateTime(2025, 7, 5);
  final endDate = DateTime(2025, 8, 4);
  return (date.isAfter(startDate.subtract(const Duration(days: 1))) &&
      date.isBefore(endDate.add(const Duration(days: 1))));
}
