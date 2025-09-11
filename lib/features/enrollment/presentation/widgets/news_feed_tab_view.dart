// lib/features/news_feed/presentation/widgets/news_feed_tab_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/constants/colors.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/news_feed_entity.dart';
import '../bloc/news_feed/news_feed_bloc.dart';
import '../bloc/news_feed/news_feed_event.dart';
import 'news_feed_item.dart';
import 'news_feed_empty_state.dart';

class NewsFeedTabView extends StatefulWidget {
  final List<NewsFeedEntity> newsFeed;
  final int scheduleSlotId;

  const NewsFeedTabView({
    Key? key,
    required this.newsFeed,
    required this.scheduleSlotId,
  }) : super(key: key);

  @override
  State<NewsFeedTabView> createState() => _NewsFeedTabViewState();
}

class _NewsFeedTabViewState extends State<NewsFeedTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Bulletin Board Header
        Container(
          margin: const EdgeInsets.all(16),
          // padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: AppColors.whiteColor,
            unselectedLabelColor: AppColors.mainColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.mainColor,
            ),
            tabs: const [
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Tab(text: 'All Posts'),
              ),
              Tab(text: 'Messages'),
              Tab(text: 'Homework'),
              Tab(text: 'Quizzes'),
              Tab(text: 'Files'),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<NewsFeedBloc>().add(RefreshNewsFeed(widget.scheduleSlotId));
            },
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(widget.newsFeed),
                _buildTabContent(widget.newsFeed
                    .where((item) => item.type == NewsFeedType.message)
                    .toList()),
                _buildTabContent(widget.newsFeed
                    .where((item) => item.type == NewsFeedType.homework)
                    .toList()),
                _buildTabContent(widget.newsFeed
                    .where((item) => item.type == NewsFeedType.quiz)
                    .toList()),
                _buildTabContent(widget.newsFeed
                    .where((item) =>
                item.type == NewsFeedType.file ||
                    item.type == NewsFeedType.image)
                    .toList()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(List<NewsFeedEntity> items) {
    final l10n = AppLocalizations.of(context);
    if (items.isEmpty) {
      return const Center(
        child: NewsFeedEmptyState(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return NewsFeedItem(
          item: item,
          onTap: () => _handleItemTap(context, item),
          onDownload: (url, fileName) {
            Future.delayed(const Duration(milliseconds: 100), () {
              context.read<NewsFeedBloc>().add(DownloadFile(url, fileName));
            });
          },
          onOpenTelegramLink: (url) async {
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.couldNotOpenTelegram)),
              );
            }
          },
        );
      },
    );
  }

  void _handleItemTap(BuildContext context, NewsFeedEntity item) {
    switch (item.type) {
      case NewsFeedType.homework:
      // TODO: Navigate to homework page
        break;
      case NewsFeedType.quiz:
      // TODO: Navigate to quiz page
        break;
      default:
        break;
    }
  }
}