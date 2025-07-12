import 'package:alhadara/features/privet_lesson/domain/entities/private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/domain/repositories/private_lesson_request_repository.dart';

class GetPrivateLessonRequests {
  final PrivateLessonRequestRepository repository;

  GetPrivateLessonRequests(this.repository);

  Future<List<PrivateLessonRequest>> call() async {
    return await repository.getPrivateLessonRequests();
  }
}