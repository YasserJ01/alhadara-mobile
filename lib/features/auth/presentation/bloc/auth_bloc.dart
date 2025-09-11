// auth/presentation/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_with_phone_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/biometric_service.dart';
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
    on<LoginWithSavedCredentialsRequested>(_onLoginWithSavedCredentialsRequested);
    on<LoadSavedCredentialsRequested>(_onLoadSavedCredentialsRequested);
    on<ClearSavedCredentialsRequested>(_onClearSavedCredentialsRequested);
    on<RefreshTokenRequested>(_onRefreshTokenRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
    on<BiometricAuthenticationRequested>(_onBiometricAuthenticationRequested);
    on<UpdateBiometricPreferenceRequested>(_onUpdateBiometricPreferenceRequested);
  }

  Future<void> _onLoginWithPhoneRequested(
      LoginWithPhoneRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final user = await loginWithPhoneUseCase(event.phone, event.password);

      // Save credentials if requested
      if (event.saveCredentials) {
        await SecureStorageService.saveCredentials(
          phone: event.phone,
          password: event.password,
        );
      }

      // Save keep signed in preference
      await SecureStorageService.setKeepSignedIn(event.keepSignedIn);

      // Save last login phone for convenience
      await SecureStorageService.saveLastLoginPhone(event.phone);

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

  Future<void> _onLoginWithSavedCredentialsRequested(
      LoginWithSavedCredentialsRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {


      final credentials = await SecureStorageService.getSavedCredentials();
      if (credentials == null) {
        emit(const AuthFailure('No saved credentials found'));
        return;
      }

      final user = await loginWithPhoneUseCase(
        credentials['phone']!,
        credentials['password']!,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure('Failed to login with saved credentials: $e'));
    }
  }

  Future<void> _onLoadSavedCredentialsRequested(
      LoadSavedCredentialsRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      final hasCredentials = await SecureStorageService.hasCredentialsSaved();
      if (!hasCredentials) {
        final lastPhone = await SecureStorageService.getLastLoginPhone();
        if (lastPhone != null) {
          emit(SavedCredentialsLoaded(
            phone: lastPhone,
            hasPassword: false,
            // biometricEnabled: false,
            // biometricAvailable: await BiometricService.isBiometricAvailable(),
          ));
        }
        return;
      }

      final credentials = await SecureStorageService.getSavedCredentials();
      final biometricEnabled = await SecureStorageService.getBiometricEnabled();
      // final biometricAvailable = await BiometricService.isBiometricAvailable();

      if (credentials != null) {
        emit(SavedCredentialsLoaded(
          phone: credentials['phone']!,
          hasPassword: true,
          // biometricEnabled: biometricEnabled,
          // biometricAvailable: biometricAvailable,
        ));
      }
    } catch (e) {
      emit(AuthFailure('Failed to load saved credentials: $e'));
    }
  }

  Future<void> _onClearSavedCredentialsRequested(
      ClearSavedCredentialsRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await SecureStorageService.clearSavedCredentials();
      emit(CredentialsCleared());
    } catch (e) {
      emit(AuthFailure('Failed to clear saved credentials: $e'));
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

    if (event.clearSavedCredentials) {
      await SecureStorageService.clearAllUserData();
    }

    emit(AuthInitial());
  }

  Future<void> _onCheckAuthStatusRequested(
      CheckAuthStatusRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      // First check if user wants to stay signed in
      final keepSignedIn = await SecureStorageService.getKeepSignedIn();

      if (keepSignedIn) {
        // Check if we have valid tokens
        final isLoggedIn = await authRepository.isLoggedIn();
        if (isLoggedIn) {
          // Try to refresh token to ensure it's still valid
          try {
            await refreshTokenUseCase();
            emit(AuthAuthenticated());
            return;
          } catch (e) {
            // If token refresh fails, clear tokens and continue to login
            await authRepository.logout();
          }
        }
      }

      // If not keeping signed in or tokens are invalid, load saved credentials
      final hasCredentials = await SecureStorageService.hasCredentialsSaved();
      if (hasCredentials) {
        add(LoadSavedCredentialsRequested());
      } else {
        // No saved credentials, check for last login phone
        final lastPhone = await SecureStorageService.getLastLoginPhone();
        if (lastPhone != null) {
          emit(SavedCredentialsLoaded(
            phone: lastPhone,
            hasPassword: false,
            // biometricEnabled: false,
            // biometricAvailable: await BiometricService.isBiometricAvailable(),
          ));
        } else {
          // Fresh start - no previous login data
          emit(AuthInitial());
        }
      }
    } catch (e) {
      // If anything goes wrong, start fresh
      emit(AuthInitial());
    }
  }

  Future<void> _onBiometricAuthenticationRequested(
      BiometricAuthenticationRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      final credentials = await SecureStorageService.getSavedCredentials();
      if (credentials == null) {
        emit(const AuthFailure('No saved credentials for biometric login'));
        return;
      }

      emit(BiometricAuthenticationRequired(credentials['phone']!));
    } catch (e) {
      emit(AuthFailure('Failed to prepare biometric authentication: $e'));
    }
  }

  Future<void> _onUpdateBiometricPreferenceRequested(
      UpdateBiometricPreferenceRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await SecureStorageService.setBiometricEnabled(event.enabled);

      // Reload saved credentials to update the state
      add(LoadSavedCredentialsRequested());
    } catch (e) {
      emit(AuthFailure('Failed to update biometric preference: $e'));
    }
  }
}