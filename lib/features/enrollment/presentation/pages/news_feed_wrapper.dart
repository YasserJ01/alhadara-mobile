// lib/features/news_feed/presentation/pages/news_feed_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/news_feed/news_feed_bloc.dart';
import 'news_feed_page.dart';

class NewsFeedWrapper extends StatelessWidget {
  final int scheduleSlotId;

  const NewsFeedWrapper({
    Key? key,
    required this.scheduleSlotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<NewsFeedBloc>(),
      child: NewsFeedPage(scheduleSlotId: scheduleSlotId),
    );
  }
}