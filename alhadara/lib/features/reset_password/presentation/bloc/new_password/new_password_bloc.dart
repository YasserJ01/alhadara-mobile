import 'package:alhadara/features/reset_password/domain/usecases/request_question.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/new_password/new_password_event.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/new_password/new_password_state.dart';
import 'package:bloc/bloc.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ConfirmPasswordResetUseCase confirmPasswordResetUseCase;

  ResetPasswordBloc({required this.confirmPasswordResetUseCase})
      : super(ResetPasswordInitial()) {
    on<PasswordsSubmitted>(_onPasswordsSubmitted);
  }

  Future<void> _onPasswordsSubmitted(
    PasswordsSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoading());

    try {
      await confirmPasswordResetUseCase(
        resetToken: event.resetToken,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordError(message: e.toString()));
    }
  }
}