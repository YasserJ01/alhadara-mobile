import 'package:alhadara/features/privet_lesson/domain/repositories/private_lesson_request_repository.dart';

class DeletePrivateLessonRequest {
  final PrivateLessonRequestRepository repository;

  DeletePrivateLessonRequest(this.repository);

  Future<void> call(int requestId) async {
    await repository.deletePrivateLessonRequest(requestId);
  }
}