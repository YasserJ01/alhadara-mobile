import '../../domain/entities/quiz_answer_entity.dart';

class QuizAnswerModel {
  final int id;
  final int attempt;
  final int question;
  final String questionText;
  final String questionType;
  final List<SelectedChoiceModel> selectedChoices;
  final int pointsEarned;
  final bool isCorrect;
  final RevisionNoteModel? revisionNote;

  QuizAnswerModel({
    required this.id,
    required this.attempt,
    required this.question,
    required this.questionText,
    required this.questionType,
    required this.selectedChoices,
    required this.pointsEarned,
    required this.isCorrect,
    this.revisionNote,
  });

  factory QuizAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuizAnswerModel(
      id: json['id'],
      attempt: json['attempt'],
      question: json['question'],
      questionText: json['question_text'],
      questionType: json['question_type'],
      selectedChoices: List<SelectedChoiceModel>.from(
        json['selected_choices'].map((x) => SelectedChoiceModel.fromJson(x)),
      ),
      pointsEarned: json['points_earned'],
      isCorrect: json['is_correct'],
      revisionNote: json['revision_note'] != null
          ? RevisionNoteModel.fromJson(json['revision_note'])
          : null,
    );
  }

  QuizAnswer toEntity() {
    return QuizAnswer(
      id: id,
      attemptId: attempt,
      questionId: question,
      questionText: questionText,
      questionType: questionType,
      selectedChoices: selectedChoices.map((choice) => SelectedChoice(
        id: choice.id,
        text: choice.text,
        order: choice.order,
      )).toList(),
      pointsEarned: pointsEarned,
      isCorrect: isCorrect,
      revisionNote: revisionNote?.toEntity(),
    );
  }

}

class SelectedChoiceModel {
  final int id;
  final String text;
  final int order;

  SelectedChoiceModel({
    required this.id,
    required this.text,
    required this.order,
  });

  factory SelectedChoiceModel.fromJson(Map<String, dynamic> json) {
    return SelectedChoiceModel(
      id: json['id'],
      text: json['text'],
      order: json['order'],
    );
  }
  SelectedChoice toEntity() {
    return SelectedChoice(
      id: id,
      text: text,
      order: order,
    );
  }
}

class RevisionNoteModel {
  final String message;
  final List<LessonModel> lessons;

  RevisionNoteModel({
    required this.message,
    required this.lessons,
  });

  factory RevisionNoteModel.fromJson(Map<String, dynamic> json) {
    return RevisionNoteModel(
      message: json['message'],
      lessons: List<LessonModel>.from(
        json['lessons'].map((x) => LessonModel.fromJson(x)),
      ),
    );
  }
  RevisionNote toEntity() {
    return RevisionNote(
      message: message,
      lessons: lessons.map((lesson) => Lesson(
        id: lesson.id,
        title: lesson.title,
      )).toList(),
    );
  }
}

class LessonModel {
  final int id;
  final String title;

  LessonModel({
    required this.id,
    required this.title,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
    );
  }
  Lesson toEntity() {
    return Lesson(
      id: id,
      title: title,
    );
  }
}