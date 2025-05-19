// auth/presentation/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../errors/expections.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_with_phone_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithPhoneUseCase loginWithPhoneUseCase;

  AuthBloc({required this.loginWithPhoneUseCase}) : super(AuthInitial()) {
    on<LoginWithPhoneRequested>(_onLoginWithPhoneRequested);
  }

  Future<void> _onLoginWithPhoneRequested(
    LoginWithPhoneRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await loginWithPhoneUseCase(event.phone, event.password);
      emit(AuthSuccess(user));
    } on ValidationException catch (e) {
      // Handle validation errors (blank fields)
      final errorMessages = <String>[];

      if (e.errors.containsKey('phone')) {
        errorMessages
            .addAll((e.errors['phone'] as List).map((e) => 'Phone: $e'));
      }

      if (e.errors.containsKey('password')) {
        errorMessages
            .addAll((e.errors['password'] as List).map((e) => 'Password: $e'));
      }

      emit(AuthFailure(errorMessages.join('\n')));
    } on UnauthorizedException catch (e) {
      // Handle wrong credentials
      emit(AuthFailure(e.message));
    } on ServerException catch (e) {
      // Handle other server errors
      emit(AuthFailure(e.message));
    } catch (e) {
      // Handle any other errors
      emit(AuthFailure('An unexpected error occurred'));
    }
  }
}
