// features/security_question/presentation/bloc/security_question_event.dart
part of 'security_question_bloc.dart';

abstract class SecurityQuestionEvent extends Equatable {
  const SecurityQuestionEvent();
}

class LoadSecurityQuestions extends SecurityQuestionEvent {

  const LoadSecurityQuestions();

  @override List<Object?> get props => [];
}

class SelectSecurityQuestion extends SecurityQuestionEvent {
  final SecurityQuestionEntity question;
  final String answer;

  const SelectSecurityQuestion(this.question, this.answer);

  @override List<Object?> get props => [question, answer];
}

class SubmitSecurityAnswer extends SecurityQuestionEvent {
  final int questionId;
  final String answer;

  const SubmitSecurityAnswer({
    required this.questionId,
    required this.answer,
  });

  @override
  List<Object> get props => [questionId, answer];
}