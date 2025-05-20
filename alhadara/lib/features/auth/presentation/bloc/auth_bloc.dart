// auth/presentation/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
