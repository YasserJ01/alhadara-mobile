// auth/presentation/bloc/register_state.dart
part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  final UserRegisterEntity user;

  const RegisterSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure(this.error);
  @override
  List<Object> get props => [error];
}