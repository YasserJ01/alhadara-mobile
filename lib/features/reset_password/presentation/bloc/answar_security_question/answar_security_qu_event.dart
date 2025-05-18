abstract class AnswerSecurityQuestionEvent {}

class SecurityAnswerSubmitted extends AnswerSecurityQuestionEvent {
  final String phoneNumber;
  final int questionId;
  final String answer;

  SecurityAnswerSubmitted({
    required this.phoneNumber,
    required this.questionId,
    required this.answer,
  });
}