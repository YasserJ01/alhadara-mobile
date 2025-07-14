// widgets/homework_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/homework.dart';
import '../bloc/homeworks/homework_bloc.dart';
import '../bloc/homeworks/homework_state.dart';
import '../bloc/homeworks/homework_event.dart';

class HomeworkDialog extends StatelessWidget {
  final int lessonId;
  final String lessonTitle;

  const HomeworkDialog({
    Key? key,
    required this.lessonId,
    required this.lessonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger homework loading when dialog opens
    context.read<HomeworkBloc>().add(GetHomeworkByLessonIdEvent(lessonId));
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 600,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Homework - $lessonTitle',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE53E3E),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: BlocBuilder<HomeworkBloc, HomeworkState>(
                builder: (context, state) {
                  if (state is HomeworkLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFE53E3E),
                      ),
                    );
                  } else if (state is HomeworkEmpty) {
                    print("Empty");
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No homework assigned',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is HomeworkLoaded) {
                    print("Loaded");
                    return _buildHomeworkList(context, state.homework);
                  } else if (state is HomeworkError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE53E3E),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              context.read<HomeworkBloc>().add(
                                GetHomeworkByLessonIdEvent(lessonId),
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeworkList(BuildContext context, List<Homework> homeworkList) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: homeworkList.length,
      separatorBuilder: (context, index) => const Divider(height: 24),
      itemBuilder: (context, index) {
        final homework = homeworkList[index];
        return _buildHomeworkCard(context, homework);
      },
    );
  }

  Widget _buildHomeworkCard(BuildContext context, Homework homework) {
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy - HH:mm');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    homework.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: homework.isMandatory
                        ? const Color(0xFFE53E3E).withOpacity(0.1)
                        : Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    homework.isMandatory ? 'Mandatory' : 'Optional',
                    style: TextStyle(
                      fontSize: 12,
                      color: homework.isMandatory
                          ? const Color(0xFFE53E3E)
                          : Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              homework.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  'Deadline: ${dateFormat.format(homework.deadline)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.grade,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  'Max Score: ${homework.maxScore}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(homework.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    homework.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusColor(homework.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'published':
        return Colors.green;
      case 'draft':
        return Colors.orange;
      case 'archived':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}

// class HomeworkDialog extends StatelessWidget {
//   final int lessonId;
//   final String lessonTitle;
//
//   const HomeworkDialog({
//     Key? key,
//     required this.lessonId,
//     required this.lessonTitle,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => context.read<HomeworkBloc>()
//         ..add(GetHomeworkByLessonIdEvent(lessonId)),
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Container(
//           constraints: const BoxConstraints(
//             maxWidth: 500,
//             maxHeight: 600,
//           ),
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Homework - $lessonTitle',
//                       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Flexible(
//                 child: BlocBuilder<HomeworkBloc, HomeworkState>(
//                   builder: (context, state) {
//                     if (state is HomeworkLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (state is HomeworkEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No homework assigned',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       );
//                     } else if (state is HomeworkLoaded) {
//                       return _buildHomeworkList(context, state.homework);
//                     } else if (state is HomeworkError) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.error_outline,
//                               size: 48,
//                               color: Colors.red,
//                             ),
//                             const SizedBox(height: 16),
//                             Text(
//                               state.message,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.red,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 16),
//                             ElevatedButton(
//                               onPressed: () {
//                                 context.read<HomeworkBloc>().add(
//                                   GetHomeworkByLessonIdEvent(lessonId),
//                                 );
//                               },
//                               child: const Text('Retry'),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHomeworkList(BuildContext context, List<Homework> homeworkList) {
//     return ListView.separated(
//       shrinkWrap: true,
//       itemCount: homeworkList.length,
//       separatorBuilder: (context, index) => const Divider(),
//       itemBuilder: (context, index) {
//         final homework = homeworkList[index];
//         return _buildHomeworkCard(context, homework);
//       },
//     );
//   }
//
//   Widget _buildHomeworkCard(BuildContext context, Homework homework) {
//     final DateFormat dateFormat = DateFormat('MMM dd, yyyy - HH:mm');
//
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     homework.title,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: homework.isMandatory ? Colors.red.shade100 : Colors.blue.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     homework.isMandatory ? 'Mandatory' : 'Optional',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: homework.isMandatory ? Colors.red.shade700 : Colors.blue.shade700,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               homework.description,
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Icon(
//                   Icons.schedule,
//                   size: 16,
//                   color: Colors.grey.shade600,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   'Deadline: ${dateFormat.format(homework.deadline)}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 Icon(
//                   Icons.grade,
//                   size: 16,
//                   color: Colors.grey.shade600,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   'Max Score: ${homework.maxScore}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 2,
//                   ),
//                   decoration: BoxDecoration(
//                     color: _getStatusColor(homework.status).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     homework.status.toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: _getStatusColor(homework.status),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'published':
//         return Colors.green;
//       case 'draft':
//         return Colors.orange;
//       case 'archived':
//         return Colors.grey;
//       default:
//         return Colors.blue;
//     }
//   }
// }
