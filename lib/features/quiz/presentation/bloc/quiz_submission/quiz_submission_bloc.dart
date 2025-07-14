import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../errors/failures.dart';
import '../../../domain/entities/quiz_answer_entity.dart';
import '../../../domain/usecases/submit_quiz_answers_usecase.dart';

part 'quiz_submission_event.dart';

part 'quiz_submission_state.dart';

class QuizSubmissionBloc
    extends Bloc<QuizSubmissionEvent, QuizSubmissionState> {
  final SubmitQuizAnswersUseCase submitQuizAnswersUseCase;

  QuizSubmissionBloc({required this.submitQuizAnswersUseCase})
      : super(QuizSubmissionInitial()) {
    on<SubmitQuizAnswersEvent>(_onSubmitQuizAnswers);
  }

  Future<void> _onSubmitQuizAnswers(
    SubmitQuizAnswersEvent event,
    Emitter<QuizSubmissionState> emit,
  ) async {
    emit(QuizSubmissionLoading());
    try {
      final answers = await submitQuizAnswersUseCase(
        attemptId: event.attemptId,
        answers: event.answers,
      );
      emit(QuizSubmissionSuccess(answers: answers));
    } on UnauthorizedFailure {
      emit(const QuizSubmissionError(
          message: 'Session expired. Please login again.'));
    } on NotFoundFailure catch (e) {
      emit(QuizSubmissionError(message: e.message));
    } on ValidationFailure catch (e) {
      emit(QuizSubmissionError(message: 'Validation error: ${e.toString()}'));
    } on ServerFailure {
      emit(const QuizSubmissionError(
          message: 'Server error. Please try again later.'));
    } on HttpFailure {
      emit(const QuizSubmissionError(
          message: 'Network error. Please check your connection.'));
    } catch (e) {
      emit(QuizSubmissionError(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
