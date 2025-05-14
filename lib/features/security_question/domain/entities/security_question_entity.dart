// features/security_question/domain/entities/security_question_entity.dart
class SecurityQuestionEntity {
  final int id;
  final String questionText;
  final String language;

  SecurityQuestionEntity({
    required this.id,
    required this.questionText,
    required this.language,
  });
}