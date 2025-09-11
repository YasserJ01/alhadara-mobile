// auth/presentation/bloc/captcha/captcha_state.dart
part of 'captcha_bloc.dart';

abstract class CaptchaState extends Equatable {
  const CaptchaState();
}

class CaptchaInitial extends CaptchaState {
  @override
  List<Object> get props => [];
}

class CaptchaLoading extends CaptchaState {
  @override
  List<Object> get props => [];
}

class CaptchaLoaded extends CaptchaState {
  final CaptchaResponseModel captcha;

  const CaptchaLoaded({required this.captcha});

  @override
  List<Object> get props => [captcha];
}

class CaptchaError extends CaptchaState {
  final String error;

  const CaptchaError({required this.error});

  @override
  List<Object> get props => [error];
}
class CaptchaVerified extends CaptchaState {
  final bool isValid;

  const CaptchaVerified({required this.isValid});

  @override
  List<Object> get props => [isValid];
}