
import 'package:project2/features/enrollment/domain/repositories/enrollment_repository.dart';

class DeletePrivateLessonRequest {
  final EnrollmentRepository repository;

  DeletePrivateLessonRequest(this.repository);

  Future<void> call(int requestId) async {
    await repository.deletePrivateLessonRequest(requestId);
  }
}