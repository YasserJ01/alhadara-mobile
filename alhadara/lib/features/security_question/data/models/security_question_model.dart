// features/security_question/data/models/security_question_model.dart
class SecurityQuestionModel {
  final int id;
  final String questionText;
  final String language;

  SecurityQuestionModel({
    required this.id,
    required this.questionText,
    required this.language,
  });

  factory SecurityQuestionModel.fromJson(Map<String, dynamic> json) {
    return SecurityQuestionModel(
      id: json['id'],
      questionText: json['question_text'],
      language: json['language'],
    );
  }
}