import 'package:project2/features/reset_password/data/models/security_question_model.dart';

abstract class RequestSecurityQuestionState {
  const RequestSecurityQuestionState();

  @override
  List<Object> get props => [];
}

class RequestSecurityQuestionInitial extends RequestSecurityQuestionState {}

class RequestSecurityQuestionLoading extends RequestSecurityQuestionState {}

class RequestSecurityQuestionSuccess extends RequestSecurityQuestionState {
  final List<SecurityQuestion> questions;
  final String phoneNumber;
  
  RequestSecurityQuestionSuccess({
    required this.questions,
    required this.phoneNumber,
  });
}

class RequestSecurityQuestionError extends RequestSecurityQuestionState {
  final String message;
  RequestSecurityQuestionError({required this.message});
  @override
  List<Object> get props => [message];
}