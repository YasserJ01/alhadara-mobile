// domain/entities/lesson_entity.dart
class TeacherLessonEntity {
  final int id;
  final int lessonOrder;
  final String title;
  final String? notes;
  final String? file;
  final String? link;
  final int course;
  final int scheduleSlot;
  final String lessonDate;
  final String status;

  TeacherLessonEntity({
    required this.id,
    required this.lessonOrder,
    required this.title,
    this.notes,
    this.file,
    this.link,
    required this.course,
    required this.scheduleSlot,
    required this.lessonDate,
    required this.status,
  });
}