// auth/presentation/bloc/auth_state.dart
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthAuthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class SavedCredentialsLoaded extends AuthState {
  final String phone;
  final bool hasPassword;
  // final bool biometricEnabled;
  // final bool biometricAvailable;

  const SavedCredentialsLoaded({
    required this.phone,
    required this.hasPassword,
    // required this.biometricEnabled,
    // required this.biometricAvailable,
  });

  @override
  List<Object> get props => [phone, hasPassword, /*biometricEnabled, biometricAvailable*/];
}

class BiometricAuthenticationRequired extends AuthState {
  final String phone;

  const BiometricAuthenticationRequired(this.phone);

  @override
  List<Object> get props => [phone];
}

class CredentialsCleared extends AuthState {}