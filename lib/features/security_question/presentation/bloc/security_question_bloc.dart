// features/security_question/presentation/bloc/security_question_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/security_question_entity.dart';
import '../../domain/usecases/get_security_questions_usecase.dart';
import '../../domain/usecases/submit_security_answer_usecase.dart';

part 'security_question_state.dart';

part 'security_question_event.dart';

class SecurityQuestionBloc
    extends Bloc<SecurityQuestionEvent, SecurityQuestionState> {
  final GetSecurityQuestionsUseCase getSecurityQuestionsUseCase;
  final SubmitSecurityAnswerUseCase submitSecurityAnswerUseCase;

  SecurityQuestionBloc({
    required this.getSecurityQuestionsUseCase,
    required this.submitSecurityAnswerUseCase,
  }) : super(SecurityQuestionInitial()) {
    on<LoadSecurityQuestions>(_onLoadQuestions);
    on<SelectSecurityQuestion>(_onSelectQuestion);
    on<SubmitSecurityAnswer>(_onSubmitAnswer);
  }

  Future<void> _onLoadQuestions(
    LoadSecurityQuestions event,
    Emitter<SecurityQuestionState> emit,
  ) async {
    emit(SecurityQuestionsLoading());
    try {
      final questions = await getSecurityQuestionsUseCase(event.authToken);
      emit(SecurityQuestionsLoaded(questions));
    } catch (e) {
      emit(SecurityQuestionError(e.toString()));
    }
  }

  Future<void> _onSelectQuestion(
    SelectSecurityQuestion event,
    Emitter<SecurityQuestionState> emit,
  ) async {
    // Call your API to store the selected question/answer
    emit(SecurityQuestionSelected());
  }
  Future<void> _onSubmitAnswer(
      SubmitSecurityAnswer event,
      Emitter<SecurityQuestionState> emit,
      ) async {
    emit(SecurityAnswerSubmitting());
    try {
      await submitSecurityAnswerUseCase(
        token: event.token,
        questionId: event.questionId,
        answer: event.answer,
      );
      emit(SecurityAnswerSubmitted());
    } catch (e) {
      emit(SecurityAnswerError(e.toString()));
    }
  }
}
