import 'package:alhadara/features/reset_password/domain/usecases/request_question.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/answar_security_question/answar_security_qu_event.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/answar_security_question/answar_security_qu_state.dart';
import 'package:bloc/bloc.dart';

class AnswerSecurityQuestionBloc extends Bloc<AnswerSecurityQuestionEvent, AnswerSecurityQuestionState> {
  final ValidateSecurityAnswerUseCase validateSecurityAnswerUseCase;

  AnswerSecurityQuestionBloc({required this.validateSecurityAnswerUseCase})
      : super(AnswerSecurityQuestionInitial()) {
    on<SecurityAnswerSubmitted>(_onSecurityAnswerSubmitted);
  }

  Future<void> _onSecurityAnswerSubmitted(
    SecurityAnswerSubmitted event,
    Emitter<AnswerSecurityQuestionState> emit,
  ) async {
    emit(AnswerSecurityQuestionLoading());

    try {
      final resetToken = await validateSecurityAnswerUseCase(
        phoneNumber: event.phoneNumber,
        questionId: event.questionId,
        answer: event.answer,
      );
      emit(AnswerSecurityQuestionSuccess(resetToken: resetToken));
    } catch (e) {
      emit(AnswerSecurityQuestionError(message: e.toString()));
    }
  }
}