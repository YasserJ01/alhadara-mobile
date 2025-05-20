// class SecurityQuestion {
//   final int id;
//   final String questionText;
//   final String language;

//   SecurityQuestion({
//     required this.id,
//     required this.questionText,
//     required this.language,
//   });

//   factory SecurityQuestion.fromJson(Map<String, dynamic> json) {
//     return SecurityQuestion(
//       id: json['id'],
//       questionText: json['question_text'],
//       language: json['language'],
//     );
//   }
// }

class SecurityQuestion {
  final int id;
  final String questionText;
  final String language;

  SecurityQuestion({
    required this.id,
    required this.questionText,
    required this.language,
  });

  factory SecurityQuestion.fromJson(Map<String, dynamic> json) {
    return SecurityQuestion(
      id: json['id'] as int? ?? 0, // Provide default if null
      questionText: json['question_text'] as String? ?? '',
      language: json['language'] as String? ?? 'en',
    );
  }
}

class ResetToken {
  final String resetToken;

  ResetToken({required this.resetToken});

  factory ResetToken.fromJson(Map<String, dynamic> json) {
    return ResetToken(resetToken: json['reset_token']);
  }
}


