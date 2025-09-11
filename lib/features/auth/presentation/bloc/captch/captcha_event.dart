// auth/presentation/bloc/captcha/captcha_event.dart
part of 'captcha_bloc.dart';

abstract class CaptchaEvent extends Equatable {
  const CaptchaEvent();
}

class LoadCaptcha extends CaptchaEvent {
  @override
  List<Object> get props => [];
}

class RefreshCaptcha extends CaptchaEvent {
  @override
  List<Object> get props => [];
}

class VerifyCaptcha extends CaptchaEvent {
  final String key;
  final String answer;

  const VerifyCaptcha({required this.key, required this.answer});

  @override
  List<Object> get props => [key, answer];
}