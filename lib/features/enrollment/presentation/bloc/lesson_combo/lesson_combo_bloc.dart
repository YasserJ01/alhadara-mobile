// presentation/bloc/lesson_combo/lesson_combo_bloc.dart
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../errors/expections.dart';
import '../../../domain/usecases/create_lesson_combo.dart';
part  'lesson_combo_event.dart';
part  'lesson_combo_state.dart';

class LessonComboBloc extends Bloc<LessonComboEvent, LessonComboState> {
  final CreateLessonCombo createLessonCombo;

  LessonComboBloc({required this.createLessonCombo}) : super(LessonComboInitial()) {
    on<CreateLessonComboEvent>(_onCreateLessonCombo);
  }

  Future<void> _onCreateLessonCombo(
      CreateLessonComboEvent event,
      Emitter<LessonComboState> emit,
      ) async {
    emit(LessonComboLoading());
    try {
      final response = await createLessonCombo.call(
        title: event.title,
        notes: event.notes,
        file: event.file,
        link: event.link,
        courseId: event.courseId,
        scheduleSlotId: event.scheduleSlotId,
        lessonDate: event.lessonDate,
        status: event.status,
        homeworkTitle: event.homeworkTitle,
        homeworkDescription: event.homeworkDescription,
        homeworkFormLink: event.homeworkFormLink,
        homeworkDeadline: event.homeworkDeadline,
        homeworkMaxScore: event.homeworkMaxScore,
        homeworkIsMandatory: event.homeworkIsMandatory,
        attendanceRecords: event.attendanceRecords,
      );
      emit(LessonComboSuccess(response));
    } on ServerException catch (e) {
      emit(LessonComboFailure(e.message));
    } on ValidationException catch (e) {
      emit(LessonComboFailure(e.errors.toString()));
    } catch (e) {
      emit(LessonComboFailure('An unexpected error occurred'));
    }
  }
}