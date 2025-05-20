import 'package:alhadara/features/reset_password/data/models/security_question_model.dart';

abstract class AnswerSecurityQuestionState {}

class AnswerSecurityQuestionInitial extends AnswerSecurityQuestionState {}

class AnswerSecurityQuestionLoading extends AnswerSecurityQuestionState {}

class AnswerSecurityQuestionSuccess extends AnswerSecurityQuestionState {
  final ResetToken resetToken;
  AnswerSecurityQuestionSuccess({required this.resetToken});
}

class AnswerSecurityQuestionError extends AnswerSecurityQuestionState {
  final String message;
  AnswerSecurityQuestionError({required this.message});
}