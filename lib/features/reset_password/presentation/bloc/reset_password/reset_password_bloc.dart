import 'package:project2/errors/expections.dart';
import 'package:project2/features/reset_password/domain/usecases/request_question.dart';
import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:bloc/bloc.dart';

class RequestSecurityQuestionBloc
    extends Bloc<RequestSecurityQuestionEvent, RequestSecurityQuestionState> {
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
    } on ValidationnException catch (e) {
      emit(RequestSecurityQuestionError(message: e.errors));
    } on CacheException catch (e) {
      emit(RequestSecurityQuestionError(message: e.message));
    } on ServerException catch (e) {
      emit(RequestSecurityQuestionError(message: e.message));
    } catch (e) {
      // Handle any other errors
      emit(RequestSecurityQuestionError(
          message: 'An unexpected error occurred'));
    }
    // catch (e) {
    //   emit(RequestSecurityQuestionError(message: e.toString()));
    // }
  }
}
