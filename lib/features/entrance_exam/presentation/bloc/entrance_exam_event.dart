//TODO
import 'package:equatable/equatable.dart';

abstract class EntranceExamEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartExamByQrEvent extends EntranceExamEvent {
  final String qrCode;

  StartExamByQrEvent(this.qrCode);

  @override
  List<Object> get props => [qrCode];
}

class LoadExamAttemptEvent extends EntranceExamEvent {
  final int attemptId;

  LoadExamAttemptEvent(this.attemptId);

  @override
  List<Object> get props => [attemptId];
}

class AnswerQuestionEvent extends EntranceExamEvent {
  final int questionId;
  final int choiceOrder;

  AnswerQuestionEvent(this.questionId, this.choiceOrder);

  @override
  List<Object> get props => [questionId, choiceOrder];
}

class SubmitAnswersEvent extends EntranceExamEvent {
  final int attemptId;

  SubmitAnswersEvent(this.attemptId);

  @override
  List<Object> get props => [attemptId];
}

class ResetExamEvent extends EntranceExamEvent {}
