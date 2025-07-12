import 'package:alhadara/features/privet_lesson/domain/entities/private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/domain/repositories/private_lesson_request_repository.dart';

class CreatePrivateLessonRequest {
  final PrivateLessonRequestRepository repository;

  CreatePrivateLessonRequest(this.repository);

  Future<PrivateLessonRequest> call({
    required int scheduleSlot,
    required String preferredDate,
    required String preferredTimeFrom,
    required String preferredTimeTo,
  }) async {
    return await repository.createPrivateLessonRequest(
      scheduleSlot: scheduleSlot,
      preferredDate: preferredDate,
      preferredTimeFrom: preferredTimeFrom,
      preferredTimeTo: preferredTimeTo,
    );
  }
}