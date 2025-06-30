// features/courses/domain/repositories/enrollment_repository.dart
import 'package:alhadara/features/enrollment/data/models/lesson_summary_model.dart';
import 'package:alhadara/features/enrollment/domain/entities/lesson_summary.dart';

import '../entities/enroll.dart';
import '../entities/enrollment_entity.dart';

abstract class EnrollmentRepository {
  Future<EnrollEntity> enrollInCourse({
    required int courseId,
    required int scheduleSlotId,
    required String notes,
  });
  Future<List<EnrollmentEntity>> getEnrollments();
  Future<void> processPayment(int enrollmentId, double amount);
  Future<EnrollmentEntity> getEnrollmentDetails(int enrollmentId);
  Future<List<LessonSummary>> getLessonSummaries(int scheduleSlotId);

}