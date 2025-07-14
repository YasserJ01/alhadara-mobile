// bloc/lessons_state.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entities/lesson.dart';

abstract class LessonsState extends Equatable {
  const LessonsState();

  @override
  List<Object> get props => [];
}

class LessonsInitial extends LessonsState {}

class LessonsLoading extends LessonsState {}

class LessonsLoaded extends LessonsState {
  final List<Lesson> allLessons;
  final List<Lesson> filteredLessons;
  final DateTime? selectedDate;

  const LessonsLoaded({
    required this.allLessons,
    required this.filteredLessons,
    this.selectedDate,
  });

  @override
  List<Object> get props => [allLessons, filteredLessons, selectedDate ?? ''];

  LessonsLoaded copyWith({
    List<Lesson>? allLessons,
    List<Lesson>? filteredLessons,
    DateTime? selectedDate,
  }) {
    return LessonsLoaded(
      allLessons: allLessons ?? this.allLessons,
      filteredLessons: filteredLessons ?? this.filteredLessons,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class LessonsError extends LessonsState {
  final String message;

  const LessonsError(this.message);

  @override
  List<Object> get props => [message];
}

