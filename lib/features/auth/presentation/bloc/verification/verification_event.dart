// presentation/bloc/verification_event.dart
import 'package:equatable/equatable.dart';

abstract class VerificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartVerificationRequested extends VerificationEvent {
  final String phone;

  StartVerificationRequested({required this.phone});

  @override
  List<Object> get props => [phone];
}

class SubmitVerificationRequested extends VerificationEvent {
  final String pin;

  SubmitVerificationRequested({required this.pin});

  @override
  List<Object> get props => [pin];
}

class VerificationReset extends VerificationEvent {}
