// // lib/features/news_feed/presentation/pages/news_feed_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../domain/entities/news_feed_entity.dart';
// import '../bloc/news_feed/news_feed_bloc.dart';
// import '../bloc/news_feed/news_feed_event.dart';
// import '../bloc/news_feed/news_feed_state.dart';
// import '../widgets/news_feed_empty_state.dart';
// import '../widgets/news_feed_error_state.dart';
// import '../widgets/news_feed_item.dart';
//
// class NewsFeedPage extends StatelessWidget {
//   final int scheduleSlotId;
//
//   const NewsFeedPage({
//     Key? key,
//     required this.scheduleSlotId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Course News Feed'),
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               context.read<NewsFeedBloc>().add(RefreshNewsFeed(scheduleSlotId));
//             },
//           ),
//         ],
//       ),
//       body: BlocConsumer<NewsFeedBloc, NewsFeedState>(
//         listener: (context, state) {
//           if (state is NewsFeedDownloadSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.green,
//                 duration: const Duration(seconds: 3),
//               ),
//             );
//           } else if (state is NewsFeedDownloadError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//                 duration: const Duration(seconds: 3),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is NewsFeedInitial) {
//             context.read<NewsFeedBloc>().add(LoadNewsFeed(scheduleSlotId));
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is NewsFeedLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is NewsFeedLoaded) {
//             return _buildNewsFeedList(context, state.newsFeed);
//           } else if (state is NewsFeedDownloading) {
//             return _buildDownloadingState(context, state);
//           } else if (state is NewsFeedDownloadSuccess) {
//             return _buildNewsFeedList(context, state.newsFeed);
//           } else if (state is NewsFeedDownloadError) {
//             return _buildNewsFeedList(context, state.newsFeed);
//           } else if (state is NewsFeedError) {
//             return NewsFeedErrorState(
//               message: state.message,
//               onRetry: () {
//                 context.read<NewsFeedBloc>().add(LoadNewsFeed(scheduleSlotId));
//               },
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
//
//   Widget _buildNewsFeedList(BuildContext context, List<dynamic> newsFeed) {
//     if (newsFeed.isEmpty) {
//       return const NewsFeedEmptyState();
//     }
//
//     return RefreshIndicator(
//       onRefresh: () async {
//         context.read<NewsFeedBloc>().add(RefreshNewsFeed(scheduleSlotId));
//       },
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: newsFeed.length,
//         itemBuilder: (context, index) {
//           final item = newsFeed[index];
//           return NewsFeedItem(
//             item: item,
//             onTap: () => _handleItemTap(context, item),
//             onDownload: (url, fileName) {
//               // Add small delay to ensure UI updates properly
//               Future.delayed(const Duration(milliseconds: 100), () {
//                 context.read<NewsFeedBloc>().add(DownloadFile(url, fileName));
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildDownloadingState(BuildContext context, NewsFeedDownloading state) {
//     return Stack(
//       children: [
//         _buildNewsFeedList(context, state.newsFeed),
//         Container(
//           color: Colors.black.withOpacity(0.5),
//           child: Center(
//             child: Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const CircularProgressIndicator(),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Downloading ${state.fileName}...',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _handleItemTap(BuildContext context, item) {
//     switch (item.type) {
//       case NewsFeedType.homework:
//       // TODO: Navigate to homework page
//       // Navigator.push(context, MaterialPageRoute(builder: (_) => HomeworkPage(id: item.relatedHomework)));
//         break;
//       case NewsFeedType.quiz:
//       // TODO: Navigate to quiz page
//       // Navigator.push(context, MaterialPageRoute(builder: (_) => QuizPage(id: item.relatedQuiz)));
//         break;
//       default:
//         break;
//     }
//   }
// }
// lib/features/news_feed/presentation/pages/news_feed_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/news_feed_entity.dart';
import '../bloc/news_feed/news_feed_bloc.dart';
import '../bloc/news_feed/news_feed_event.dart';
import '../bloc/news_feed/news_feed_state.dart';
import '../widgets/news_feed_empty_state.dart';
import '../widgets/news_feed_error_state.dart';
import '../widgets/news_feed_tab_view.dart';

class NewsFeedPage extends StatelessWidget {
  final int scheduleSlotId;

  const NewsFeedPage({
    Key? key,
    required this.scheduleSlotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Bulletin Board'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.refresh),
          //     onPressed: () {
          //       context.read<NewsFeedBloc>().add(RefreshNewsFeed(scheduleSlotId));
          //     },
          //   ),
          // ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
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
              context.read<NewsFeedBloc>().add(LoadNewsFeed(scheduleSlotId));
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsFeedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsFeedLoaded) {
              return NewsFeedTabView(
                newsFeed: state.newsFeed,
                scheduleSlotId: scheduleSlotId,
              );
            } else if (state is NewsFeedDownloading) {
              return Stack(
                children: [
                  NewsFeedTabView(
                    newsFeed: state.newsFeed,
                    scheduleSlotId: scheduleSlotId,
                  ),
                  _buildDownloadingOverlay(context, state),
                ],
              );
            } else if (state is NewsFeedDownloadSuccess) {
              return NewsFeedTabView(
                newsFeed: state.newsFeed,
                scheduleSlotId: scheduleSlotId,
              );
            } else if (state is NewsFeedDownloadError) {
              return NewsFeedTabView(
                newsFeed: state.newsFeed,
                scheduleSlotId: scheduleSlotId,
              );
            } else if (state is NewsFeedError) {
              return NewsFeedErrorState(
                message: state.message,
                onRetry: () {
                  context
                      .read<NewsFeedBloc>()
                      .add(LoadNewsFeed(scheduleSlotId));
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildDownloadingOverlay(
      BuildContext context, NewsFeedDownloading state) {
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue.shade800),
                ),
                const SizedBox(height: 20),
                Text(
                  'Downloading ${state.fileName}...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please wait',
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
