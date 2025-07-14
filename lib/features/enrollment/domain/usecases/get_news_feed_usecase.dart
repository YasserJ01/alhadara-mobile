// lib/features/news_feed/domain/usecases/get_news_feed_usecase.dart
import '../entities/news_feed_entity.dart';
import '../repositories/enrollment_repository.dart';

class GetNewsFeedUseCase {
  final EnrollmentRepository repository;

  GetNewsFeedUseCase({required this.repository});

  Future<List<NewsFeedEntity>> call(int scheduleSlotId) async {
    final newsFeed = await repository.getNewsFeed(scheduleSlotId);
    // Sort by created date (newest first)
    newsFeed.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return newsFeed;
  }
}