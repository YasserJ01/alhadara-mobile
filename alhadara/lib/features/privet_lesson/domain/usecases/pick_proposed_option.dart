import 'package:alhadara/features/privet_lesson/domain/entities/private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/domain/repositories/private_lesson_request_repository.dart';

class PickProposedOption {
  final PrivateLessonRequestRepository repository;

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