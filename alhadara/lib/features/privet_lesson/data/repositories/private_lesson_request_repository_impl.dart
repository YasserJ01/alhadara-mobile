import 'package:alhadara/features/privet_lesson/data/datasources/private_lesson_request_remote_data_source.dart';
import 'package:alhadara/features/privet_lesson/domain/entities/private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/domain/repositories/private_lesson_request_repository.dart';

class PrivateLessonRequestRepositoryImpl
    implements PrivateLessonRequestRepository {
  final PrivateLessonRequestRemoteDataSource remoteDataSource;

  PrivateLessonRequestRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<PrivateLessonRequest> createPrivateLessonRequest({
    required int scheduleSlot,
    required String preferredDate,
    required String preferredTimeFrom,
    required String preferredTimeTo,
  }) async {
    final model = await remoteDataSource.createPrivateLessonRequest(
      scheduleSlot: scheduleSlot,
      preferredDate: preferredDate,
      preferredTimeFrom: preferredTimeFrom,
      preferredTimeTo: preferredTimeTo,
    );
    return model.toEntity();
  }
   @override
  Future<List<PrivateLessonRequest>> getPrivateLessonRequests() async {
    final models = await remoteDataSource.getPrivateLessonRequests();
    return models.map((model) => model.toEntity()).toList();
  }
   @override
  Future<PrivateLessonRequest> pickProposedOption({
    required int requestId,
    required int optionId,
  }) async {
    final model = await remoteDataSource.pickProposedOption(
      requestId: requestId,
      optionId: optionId,
    );
    return model.toEntity();
  }
    @override
  Future<void> deletePrivateLessonRequest(int requestId) async {
    await remoteDataSource.deletePrivateLessonRequest(requestId);
  }
}