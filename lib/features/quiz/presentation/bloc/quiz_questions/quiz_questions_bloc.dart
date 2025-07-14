import 'package:bloc/bloc.dart';
import '../../../domain/usecases/get_quiz_questions_usecase.dart';
import 'quiz_questions_event.dart';
import 'quiz_questions_state.dart';


class QuizQuestionsBloc extends Bloc<QuizQuestionsEvent, QuizQuestionsState> {
  final GetQuizQuestionsUseCase getQuizQuestionsUseCase;

  QuizQuestionsBloc({required this.getQuizQuestionsUseCase}) : super(QuizQuestionsInitial()) {
    on<LoadQuizQuestionsEvent>(_onLoadQuizQuestions);
  }

  void _onLoadQuizQuestions(LoadQuizQuestionsEvent event, Emitter<QuizQuestionsState> emit) async {
    emit(QuizQuestionsLoading());
    try {
      final questions = await getQuizQuestionsUseCase(event.quizId);
      emit(QuizQuestionsLoaded(questions: questions));
    } catch (e) {
      emit(QuizQuestionsError(message: e.toString()));
    }
  }
}