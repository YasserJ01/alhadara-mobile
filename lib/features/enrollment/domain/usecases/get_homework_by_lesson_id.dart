// usecases/get_homework_by_lesson_id.dart
import '../entities/homework.dart';
import '../repositories/enrollment_repository.dart';

class GetHomeworkByLessonId {
  final EnrollmentRepository repository;

  GetHomeworkByLessonId(this.repository);

  Future<List<Homework>> call(int lessonId) async {
    return await repository.getHomeworkByLessonId(lessonId);
  }
}