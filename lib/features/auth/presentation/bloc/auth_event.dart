// auth/presentation/bloc/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithPhoneRequested extends AuthEvent {
  final String phone;
  final String password;
  final bool saveCredentials;
  final bool keepSignedIn;

  const LoginWithPhoneRequested(
      this.phone,
      this.password, {
        this.saveCredentials = false,
        this.keepSignedIn = false,
      });

  @override
  List<Object> get props => [phone, password, saveCredentials, keepSignedIn];
}

class LoginWithSavedCredentialsRequested extends AuthEvent {
  final bool useBiometric;

  const LoginWithSavedCredentialsRequested({this.useBiometric = false});

  @override
  List<Object> get props => [useBiometric];
}

class LoadSavedCredentialsRequested extends AuthEvent {}

class ClearSavedCredentialsRequested extends AuthEvent {}

class RefreshTokenRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {
  final bool clearSavedCredentials;

  const LogoutRequested({this.clearSavedCredentials = false});

  @override
  List<Object> get props => [clearSavedCredentials];
}

class CheckAuthStatusRequested extends AuthEvent {}

class BiometricAuthenticationRequested extends AuthEvent {}

class UpdateBiometricPreferenceRequested extends AuthEvent {
  final bool enabled;

  const UpdateBiometricPreferenceRequested(this.enabled);

  @override
  List<Object> get props => [enabled];
}