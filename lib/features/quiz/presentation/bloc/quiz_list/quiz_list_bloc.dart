// Bloc
import 'package:bloc/bloc.dart';

import '../../../domain/usecases/get_quizzes_usecase.dart';
import 'quiz_list_event.dart';
import 'quiz_list_state.dart';

class QuizListBloc extends Bloc<QuizListEvent, QuizListState> {
  final GetQuizzesUseCase getQuizzesUseCase;

  QuizListBloc({required this.getQuizzesUseCase}) : super(QuizListInitial()) {
    on<LoadQuizzesEvent>(_onLoadQuizzes);
  }

  void _onLoadQuizzes(LoadQuizzesEvent event, Emitter<QuizListState> emit) async {
    emit(QuizListLoading());
    try {
      final quizzes = await getQuizzesUseCase(event.scheduleSlotId);
      emit(QuizListLoaded(quizzes: quizzes));
    } catch (e) {
      emit(QuizListError(message: e.toString()));
    }
  }
}