// presentation/bloc/lesson_combo/lesson_combo_state.dart
part of 'lesson_combo_bloc.dart';

abstract class LessonComboState extends Equatable {
  const LessonComboState();

  @override
  List<Object> get props => [];
}

class LessonComboInitial extends LessonComboState {}

class LessonComboLoading extends LessonComboState {}

class LessonComboSuccess extends LessonComboState {
  final Map<String, dynamic> lessonResponse;

  const LessonComboSuccess(this.lessonResponse);

  @override
  List<Object> get props => [lessonResponse];
}

class LessonComboFailure extends LessonComboState {
  final String message;

  const LessonComboFailure(this.message);

  @override
  List<Object> get props => [message];
}