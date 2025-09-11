import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/services/news_feed_socket_service.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../domain/entities/news_feed_entity.dart';
import '../bloc/news_feed/news_feed_bloc.dart';
import '../bloc/news_feed/news_feed_event.dart';
import '../bloc/news_feed/news_feed_state.dart';
import '../widgets/news_feed_empty_state.dart';
import '../widgets/news_feed_error_state.dart';
import '../widgets/news_feed_tab_view.dart';

class NewsFeedPage extends StatefulWidget {
  final int scheduleSlotId;

  const NewsFeedPage({
    Key? key,
    required this.scheduleSlotId,
  }) : super(key: key);

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  late NewsFeedSocketService _socketService;

  @override
  void initState() {
    super.initState();
    _socketService = NewsFeedSocketService(widget.scheduleSlotId);
    _setupWebSocket();
  }

  void _setupWebSocket() {
    _socketService.connect();
    _socketService.stream.listen((newItem) {
      if (mounted) {
        context.read<NewsFeedBloc>().add(NewsFeedItemAdded(newItem));
      }
    });
  }

  @override
  void dispose() {
    _socketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = const Color(0xffF4F8FB);
        Color textColor = AppColors.mainColor;

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
        }

        return Scaffold(
          backgroundColor: backgroundColor,
          body: Container(
            color: Colors.transparent,
            child: BlocConsumer<NewsFeedBloc, NewsFeedState>(
              listener: (context, state) {
                if (state is NewsFeedDownloadSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                } else if (state is NewsFeedDownloadError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is NewsFeedInitial) {
                  context.read<NewsFeedBloc>().add(LoadNewsFeed(widget.scheduleSlotId));
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsFeedLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsFeedLoaded) {
                  return NewsFeedTabView(
                    newsFeed: state.newsFeed,
                    scheduleSlotId: widget.scheduleSlotId,
                  );
                } else if (state is NewsFeedDownloading) {
                  return Stack(
                    children: [
                      NewsFeedTabView(
                        newsFeed: state.newsFeed,
                        scheduleSlotId: widget.scheduleSlotId,
                      ),
                      _buildDownloadingOverlay(context, state, textColor),
                    ],
                  );
                } else if (state is NewsFeedDownloadSuccess) {
                  return NewsFeedTabView(
                    newsFeed: state.newsFeed,
                    scheduleSlotId: widget.scheduleSlotId,
                  );
                } else if (state is NewsFeedDownloadError) {
                  return NewsFeedTabView(
                    newsFeed: state.newsFeed,
                    scheduleSlotId: widget.scheduleSlotId,
                  );
                } else if (state is NewsFeedError) {
                  return NewsFeedErrorState(
                    message: state.message,
                    onRetry: () {
                      context.read<NewsFeedBloc>().add(LoadNewsFeed(widget.scheduleSlotId));
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDownloadingOverlay(BuildContext context, NewsFeedDownloading state, Color textColor) {
    final l10n = AppLocalizations.of(context);
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
                const SizedBox(height: 20),
                Text(
                  '${l10n.downloading} ${state.fileName}...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.pleaseWait,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
