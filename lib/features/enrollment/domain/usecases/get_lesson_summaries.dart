// features/lessons/domain/usecases/get_lesson_summaries.dart

import '../entities/lesson_summary.dart';
import '../repositories/enrollment_repository.dart';

class GetLessonSummaries {
  final EnrollmentRepository repository;

  GetLessonSummaries(this.repository);

  Future<List<LessonSummary>> call(int scheduleSlotId) async {
    return await repository.getLessonSummaries(scheduleSlotId);
  }
}