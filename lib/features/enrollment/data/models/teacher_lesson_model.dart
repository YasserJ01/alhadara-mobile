// data/models/lesson_model.dart
class TeacherLessonModel {
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

  TeacherLessonModel({
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

  factory TeacherLessonModel.fromJson(Map<String, dynamic> json) {
    return TeacherLessonModel(
      id: json['id'],
      lessonOrder: json['lesson_order'],
      title: json['title'],
      notes: json['notes'],
      file: json['file'],
      link: json['link'],
      course: json['course'],
      scheduleSlot: json['schedule_slot'],
      lessonDate: json['lesson_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'notes': notes,
      'file': file,
      'link': link,
      'course': course,
      'schedule_slot': scheduleSlot,
      'lesson_date': lessonDate,
      'status': status,
    };
  }
}
