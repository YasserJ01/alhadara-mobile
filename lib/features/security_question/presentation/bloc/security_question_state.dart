// features/security_question/presentation/bloc/security_question_state.dart
part of 'security_question_bloc.dart';

abstract class SecurityQuestionState extends Equatable {
  const SecurityQuestionState();
}

class SecurityQuestionInitial extends SecurityQuestionState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SecurityQuestionsLoading extends SecurityQuestionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SecurityQuestionsLoaded extends SecurityQuestionState {
  final List<SecurityQuestionEntity> questions;

  const SecurityQuestionsLoaded(this.questions);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SecurityQuestionSelected extends SecurityQuestionState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SecurityQuestionError extends SecurityQuestionState {
  final String message;

  const SecurityQuestionError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SecurityAnswerSubmitting extends SecurityQuestionState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SecurityAnswerSubmitted extends SecurityQuestionState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SecurityAnswerError extends SecurityQuestionState {
  final String message;

  const SecurityAnswerError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}