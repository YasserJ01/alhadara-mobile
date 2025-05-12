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

  const LoginWithPhoneRequested(this.phone, this.password);

  @override
  List<Object> get props => [phone, password];
}