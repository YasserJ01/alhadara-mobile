// features/courses/domain/usecases/enroll_in_course.dart
import '../entities/enrollment.dart';
import '../repositories/enrollment_repository.dart';

class EnrollInCourse {
  final EnrollmentRepository repository;

  EnrollInCourse(this.repository);

  Future<EnrollEntity> call({
    required int courseId,
    required int scheduleSlotId,
    String notes = "None",
  }) async {
    return await repository.enrollInCourse(
      courseId: courseId,
      scheduleSlotId: scheduleSlotId,
      notes: notes,
    );
  }
}