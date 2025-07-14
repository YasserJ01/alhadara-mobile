// lib/features/news_feed/presentation/bloc/news_feed_state.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entities/news_feed_entity.dart';

abstract class NewsFeedState extends Equatable {
  const NewsFeedState();

  @override
  List<Object> get props => [];
}

class NewsFeedInitial extends NewsFeedState {}

class NewsFeedLoading extends NewsFeedState {}

class NewsFeedLoaded extends NewsFeedState {
  final List<NewsFeedEntity> newsFeed;

  const NewsFeedLoaded(this.newsFeed);

  @override
  List<Object> get props => [newsFeed];
}

class NewsFeedError extends NewsFeedState {
  final String message;

  const NewsFeedError(this.message);

  @override
  List<Object> get props => [message];
}

class NewsFeedDownloading extends NewsFeedState {
  final List<NewsFeedEntity> newsFeed;
  final String fileName;

  const NewsFeedDownloading(this.newsFeed, this.fileName);

  @override
  List<Object> get props => [newsFeed, fileName];
}

class NewsFeedDownloadSuccess extends NewsFeedState {
  final List<NewsFeedEntity> newsFeed;
  final String message;

  const NewsFeedDownloadSuccess(this.newsFeed, this.message);

  @override
  List<Object> get props => [newsFeed, message];
}

class NewsFeedDownloadError extends NewsFeedState {
  final List<NewsFeedEntity> newsFeed;
  final String message;

  const NewsFeedDownloadError(this.newsFeed, this.message);

  @override
  List<Object> get props => [newsFeed, message];
}