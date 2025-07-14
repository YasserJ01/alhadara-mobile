// Bloc
import 'package:bloc/bloc.dart';

import '../../../domain/usecases/start_quiz_attempt_usecase.dart';
import 'quiz_attempt_event.dart';
import 'quiz_attempt_state.dart';

class QuizAttemptBloc extends Bloc<QuizAttemptEvent, QuizAttemptState> {
  final StartQuizAttemptUseCase startQuizAttemptUseCase;

  QuizAttemptBloc({required this.startQuizAttemptUseCase}) : super(QuizAttemptInitial()) {
    on<StartQuizAttemptEvent>(_onStartQuizAttempt);
  }

  void _onStartQuizAttempt(StartQuizAttemptEvent event, Emitter<QuizAttemptState> emit) async {
    emit(QuizAttemptLoading());
    try {
      final attempt = await startQuizAttemptUseCase(event.quizId);
      emit(QuizAttemptStarted(attempt: attempt));
    } catch (e) {
      emit(QuizAttemptError(message: e.toString()));
    }
  }
}