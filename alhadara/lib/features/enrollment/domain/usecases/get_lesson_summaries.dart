// features/lessons/domain/usecases/get_lesson_summaries.dart
import 'package:alhadara/features/enrollment/data/models/lesson_summary_model.dart';
import 'package:alhadara/features/enrollment/domain/entities/lesson_summary.dart';
import 'package:alhadara/features/enrollment/domain/repositories/enrollment_repository.dart';

class GetLessonSummaries {
  final EnrollmentRepository repository;

  GetLessonSummaries(this.repository);

  Future<List<LessonSummary>> call(int scheduleSlotId) async {
    return await repository.getLessonSummaries(scheduleSlotId);
  }
}