import 'package:project2/features/enrollment/domain/repositories/enrollment_repository.dart';

import '../entities/private_lesson_request.dart';

class CreatePrivateLessonRequest {
  final EnrollmentRepository repository;

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