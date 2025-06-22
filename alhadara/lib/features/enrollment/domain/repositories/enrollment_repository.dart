// features/courses/domain/repositories/enrollment_repository.dart
import '../entities/enrollment.dart';
import '../entities/enrollment_entity.dart';

abstract class EnrollmentRepository {
  Future<EnrollEntity> enrollInCourse({
    required int courseId,
    required int scheduleSlotId,
    required String notes,
  });
  Future<List<EnrollmentEntity>> getEnrollments();
  Future<void> processPayment(int enrollmentId, double amount);
}