import 'package:project2/features/enrollment/domain/repositories/enrollment_repository.dart';

import '../entities/private_lesson_request.dart';

class GetPrivateLessonRequests {
  final EnrollmentRepository repository;

  GetPrivateLessonRequests(this.repository);

  Future<List<PrivateLessonRequest>> call() async {
    return await repository.getPrivateLessonRequests();
  }
}