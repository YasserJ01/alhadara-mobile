import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final int question;
  final int choiceIndex;

  const Answer({
    required this.question,
    required this.choiceIndex,
  });

  @override
  List<Object> get props => [question, choiceIndex];
}

class StartExamResponse extends Equatable {
  final int id;

  const StartExamResponse({required this.id});

  @override
  List<Object> get props => [id];
}

class SubmitAnswersRequest extends Equatable {
  final List<Answer> answers;

  const SubmitAnswersRequest({required this.answers});

  @override
  List<Object> get props => [answers];
}