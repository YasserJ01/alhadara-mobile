import 'package:project2/features/enrollment/domain/repositories/enrollment_repository.dart';

import '../entities/private_lesson_request.dart';

class PickProposedOption {
  final EnrollmentRepository repository;

  PickProposedOption(this.repository);

  Future<PrivateLessonRequest> call({
    required int requestId,
    required int optionId,
  }) async {
    return await repository.pickProposedOption(
      requestId: requestId,
      optionId: optionId,
    );
  }
}