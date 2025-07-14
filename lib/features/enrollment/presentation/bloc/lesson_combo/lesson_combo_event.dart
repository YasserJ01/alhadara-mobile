// presentation/bloc/lesson_combo/lesson_combo_event.dart
part of 'lesson_combo_bloc.dart';

abstract class LessonComboEvent extends Equatable {
  const LessonComboEvent();

  @override
  List<Object> get props => [];
}

class CreateLessonComboEvent extends LessonComboEvent {
  final String title;
  final String? notes;
  final File? file;
  final String? link;
  final int courseId;
  final int scheduleSlotId;
  final String lessonDate;
  final String status;
  final String? homeworkTitle;
  final String? homeworkDescription;
  final String? homeworkFormLink;
  final DateTime? homeworkDeadline;
  final int? homeworkMaxScore;
  final bool? homeworkIsMandatory;
  final List<Map<String, dynamic>>? attendanceRecords;

  const CreateLessonComboEvent({
    required this.title,
    this.notes,
    this.file,
    this.link,
    required this.courseId,
    required this.scheduleSlotId,
    required this.lessonDate,
    required this.status,
    this.homeworkTitle,
    this.homeworkDescription,
    this.homeworkFormLink,
    this.homeworkDeadline,
    this.homeworkMaxScore,
    this.homeworkIsMandatory,
    this.attendanceRecords,
  });

  @override
  List<Object> get props => [
    title,
    courseId,
    scheduleSlotId,
    lessonDate,
    status,
  ];
}