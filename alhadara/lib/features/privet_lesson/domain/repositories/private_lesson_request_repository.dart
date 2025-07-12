import 'package:alhadara/features/privet_lesson/domain/entities/private_lesson_request.dart';

abstract class PrivateLessonRequestRepository {
  Future<PrivateLessonRequest> createPrivateLessonRequest({
    required int scheduleSlot,
    required String preferredDate,
    required String preferredTimeFrom,
    required String preferredTimeTo,
  });
    Future<List<PrivateLessonRequest>> getPrivateLessonRequests();

     Future<PrivateLessonRequest> pickProposedOption({
    required int requestId,
    required int optionId,
  });
  Future<void> deletePrivateLessonRequest(int requestId);

}