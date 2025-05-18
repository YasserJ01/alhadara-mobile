import 'package:project2/features/reset_password/domain/usecases/request_question.dart';
import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:bloc/bloc.dart';

class RequestSecurityQuestionBloc extends Bloc<RequestSecurityQuestionEvent, RequestSecurityQuestionState> {
  final RequestSecurityQuestionUseCase requestSecurityQuestionUseCase;

  RequestSecurityQuestionBloc({required this.requestSecurityQuestionUseCase})
      : super(RequestSecurityQuestionInitial()) {
    on<PhoneNumberSubmitted>(_onPhoneNumberSubmitted);
  }

  Future<void> _onPhoneNumberSubmitted(
    PhoneNumberSubmitted event,
    Emitter<RequestSecurityQuestionState> emit,
  ) async {
    emit(RequestSecurityQuestionLoading());

    try {
      final questions = await requestSecurityQuestionUseCase(event.phoneNumber);
      emit(RequestSecurityQuestionSuccess(
        questions: questions!,
        phoneNumber: event.phoneNumber,
      ));
    } catch (e) {
      emit(RequestSecurityQuestionError(message: e.toString()));
    }
  }
}