class QuizAnswer {
  final int id;
  final int attemptId;
  final int questionId;
  final String questionText;
  final String questionType;
  final List<SelectedChoice> selectedChoices;
  final int pointsEarned;
  final bool isCorrect;
  final RevisionNote? revisionNote;

  QuizAnswer({
    required this.id,
    required this.attemptId,
    required this.questionId,
    required this.questionText,
    required this.questionType,
    required this.selectedChoices,
    required this.pointsEarned,
    required this.isCorrect,
    this.revisionNote,
  });
}

class SelectedChoice {
  final int id;
  final String text;
  final int order;

  SelectedChoice({
    required this.id,
    required this.text,
    required this.order,
  });
}

class RevisionNote {
  final String message;
  final List<Lesson> lessons;

  RevisionNote({
    required this.message,
    required this.lessons,
  });
}

class Lesson {
  final int id;
  final String title;

  Lesson({
    required this.id,
    required this.title,
  });
}