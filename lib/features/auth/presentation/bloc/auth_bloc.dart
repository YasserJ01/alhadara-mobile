// // auth/presentation/bloc/auth_bloc.dart
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//
// import '../../../../errors/expections.dart';
// import '../../domain/entities/user_entity.dart';
// import '../../domain/usecases/login_with_phone_usecase.dart';
//
// part 'auth_event.dart';
//
// part 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginWithPhoneUseCase loginWithPhoneUseCase;
//
//   AuthBloc({required this.loginWithPhoneUseCase}) : super(AuthInitial()) {
//     on<LoginWithPhoneRequested>(_onLoginWithPhoneRequested);
//   }
//
//   Future<void> _onLoginWithPhoneRequested(
//     LoginWithPhoneRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(AuthLoading());
//     try {
//       final user = await loginWithPhoneUseCase(event.phone, event.password);
//       emit(AuthSuccess(user));
//     } on ValidationException catch (e) {
//       // Handle validation errors (blank fields)
//       final errorMessages = <String>[];
//
//       if (e.errors.containsKey('phone')) {
//         errorMessages
//             .addAll((e.errors['phone'] as List).map((e) => 'Phone: $e'));
//       }
//
//       if (e.errors.containsKey('password')) {
//         errorMessages
//             .addAll((e.errors['password'] as List).map((e) => 'Password: $e'));
//       }
//
//       emit(AuthFailure(errorMessages.join('\n')));
//     } on UnauthorizedException catch (e) {
//       // Handle wrong credentials
//       emit(AuthFailure(e.message));
//     } on ServerException catch (e) {
//       // Handle other server errors
//       emit(AuthFailure(e.message));
//     } catch (e) {
//       // Handle any other errors
//       emit(AuthFailure('An unexpected error occurred'));
//     }
//   }
// }

// Updated AuthBloc with token refresh capability
// auth/presentation/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_with_phone_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../errors/expections.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithPhoneUseCase loginWithPhoneUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.loginWithPhoneUseCase,
    required this.refreshTokenUseCase,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<LoginWithPhoneRequested>(_onLoginWithPhoneRequested);
    on<RefreshTokenRequested>(_onRefreshTokenRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
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
      final errorMessages = <String>[];
      if (e.errors.containsKey('phone')) {
        errorMessages.addAll((e.errors['phone'] as List).map((e) => 'Phone: $e'));
      }
      if (e.errors.containsKey('password')) {
        errorMessages.addAll((e.errors['password'] as List).map((e) => 'Password: $e'));
      }
      emit(AuthFailure(errorMessages.join('\n')));
    } on UnauthorizedException catch (e) {
      emit(AuthFailure(e.message));
    } on ServerException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred'));
    }
  }

  Future<void> _onRefreshTokenRequested(
      RefreshTokenRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await refreshTokenUseCase();
      // Optionally emit a success state or keep current state
    } on UnauthorizedException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Failed to refresh token'));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    await authRepository.logout();
    emit(AuthInitial());
  }

  Future<void> _onCheckAuthStatusRequested(
      CheckAuthStatusRequested event,
      Emitter<AuthState> emit,
      ) async {
    final isLoggedIn = await authRepository.isLoggedIn();
    if (isLoggedIn) {
      // You might want to get user info here
      // For now, we'll emit a basic authenticated state
      emit(AuthAuthenticated());
    } else {
      emit(AuthInitial());
    }
  }
}
