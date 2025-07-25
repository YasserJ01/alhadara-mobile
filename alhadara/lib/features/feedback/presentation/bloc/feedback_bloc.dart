import 'package:alhadara/features/feedback/domain/usecases/submit_feedback_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:alhadara/features/feedback/domain/entities/feedback_entity.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final SubmitFeedbackUseCase submitFeedbackUseCase;

  FeedbackBloc({required this.submitFeedbackUseCase})
      : super(const FeedbackState()) {
    on<TeacherRatingChanged>(_onTeacherRatingChanged);
    on<MaterialRatingChanged>(_onMaterialRatingChanged);
    on<FacilitiesRatingChanged>(_onFacilitiesRatingChanged);
    on<AppRatingChanged>(_onAppRatingChanged);
    on<NotesChanged>(_onNotesChanged);
    on<SubmitFeedback>(_onSubmitFeedback);
  }

  void _onTeacherRatingChanged(
    TeacherRatingChanged event,
    Emitter<FeedbackState> emit,
  ) {
    emit(state.copyWith(teacherRating: event.rating));
  }

  void _onMaterialRatingChanged(
    MaterialRatingChanged event,
    Emitter<FeedbackState> emit,
  ) {
    emit(state.copyWith(materialRating: event.rating));
  }

  void _onFacilitiesRatingChanged(
    FacilitiesRatingChanged event,
    Emitter<FeedbackState> emit,
  ) {
    emit(state.copyWith(facilitiesRating: event.rating));
  }

  void _onAppRatingChanged(
    AppRatingChanged event,
    Emitter<FeedbackState> emit,
  ) {
    emit(state.copyWith(appRating: event.rating));
  }

  void _onNotesChanged(
    NotesChanged event,
    Emitter<FeedbackState> emit,
  ) {
    emit(state.copyWith(notes: event.notes));
  }

  Future<void> _onSubmitFeedback(
    SubmitFeedback event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      final feedbackEntity = FeedbackEntity(
        scheduleslot: event.scheduleSlotId,
        student: event.studentId,
        teacherRating: state.teacherRating * 20,
        materialRating: state.materialRating * 20,
        facilitiesRating: state.facilitiesRating * 20,
        appRating: state.appRating * 20,
        notes: state.notes,
      );

      await submitFeedbackUseCase(feedbackEntity);

      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
