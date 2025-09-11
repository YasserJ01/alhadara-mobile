
// lib/features/news_feed/presentation/bloc/news_feed_event.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entities/news_feed_entity.dart';

abstract class NewsFeedEvent extends Equatable {
  const NewsFeedEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsFeed extends NewsFeedEvent {
  final int scheduleSlotId;

  const LoadNewsFeed(this.scheduleSlotId);

  @override
  List<Object> get props => [scheduleSlotId];
}

class RefreshNewsFeed extends NewsFeedEvent {
  final int scheduleSlotId;

  const RefreshNewsFeed(this.scheduleSlotId);

  @override
  List<Object> get props => [scheduleSlotId];
}

class DownloadFile extends NewsFeedEvent {
  final String url;
  final String fileName;

  const DownloadFile(this.url, this.fileName);

  @override
  List<Object> get props => [url, fileName];
}

class NewsFeedItemAdded extends NewsFeedEvent {
  final NewsFeedEntity item;
  const NewsFeedItemAdded(this.item);

  @override
  List<Object> get props => [item];
}