import '../entities/lesson.dart';
import '../repositories/enrollment_repository.dart';

class GetLessons {
  final EnrollmentRepository repository;

  GetLessons(this.repository);

  Future<List<Lesson>> call(int scheduleSlotId) async {
    return await repository.getLessons(scheduleSlotId);
  }
}