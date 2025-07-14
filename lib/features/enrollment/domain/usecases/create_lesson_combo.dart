// domain/usecases/create_lesson_combo.dart
import 'dart:io';

import 'package:project2/features/enrollment/domain/repositories/enrollment_repository.dart';

class CreateLessonCombo {
  final EnrollmentRepository repository;

  CreateLessonCombo({required this.repository});

  Future<Map<String, dynamic>> call({
    required String title,
    String? notes,
    File? file,
    String? link,
    required int courseId,
    required int scheduleSlotId,
    required String lessonDate,
    required String status,
    String? homeworkTitle,
    String? homeworkDescription,
    String? homeworkFormLink,
    DateTime? homeworkDeadline,
    int? homeworkMaxScore,
    bool? homeworkIsMandatory,
    List<Map<String, dynamic>>? attendanceRecords,
  }) async {
    // Step 1: Create lesson
    final lessonResponse = await repository.createLesson(
      title: title,
      notes: notes,
      file: file,
      link: link,
      courseId: courseId,
      scheduleSlotId: scheduleSlotId,
      lessonDate: lessonDate,
      status: status,
    );

    final lessonId = lessonResponse['id'] as int;

    // Step 2: Create homework if provided
    if (homeworkTitle != null &&
        homeworkDescription != null &&
        homeworkFormLink != null &&
        homeworkDeadline != null &&
        homeworkMaxScore != null &&
        homeworkIsMandatory != null) {
      await repository.createHomework(
        title: homeworkTitle,
        description: homeworkDescription,
        formLink: homeworkFormLink,
        deadline: homeworkDeadline,
        lessonId: lessonId,
        maxScore: homeworkMaxScore,
        isMandatory: homeworkIsMandatory,
      );
    }

    // Step 3: Create attendance if provided and lesson is completed
    if (attendanceRecords != null && status == 'completed') {
      // Update all records with the lesson ID
      final updatedRecords = attendanceRecords.map((record) {
        return {...record, 'lesson': lessonId};
      }).toList();

      await repository.createBulkAttendance(records: updatedRecords);
    }

    return lessonResponse;
  }
}