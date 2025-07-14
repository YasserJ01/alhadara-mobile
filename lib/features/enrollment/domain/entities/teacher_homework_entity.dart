// domain/entities/homework_entity.dart
class TeacherHomeworkEntity {
  final String title;
  final String description;
  final String formLink;
  final DateTime deadline;
  final int lesson;
  final int maxScore;
  final bool isMandatory;

  TeacherHomeworkEntity({
    required this.title,
    required this.description,
    required this.formLink,
    required this.deadline,
    required this.lesson,
    required this.maxScore,
    required this.isMandatory,
  });
}
