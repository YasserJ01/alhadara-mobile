// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class LessonsPage extends StatelessWidget {
//   const LessonsPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return LessonsView();
//   }
// }
//
// class LessonsView extends StatelessWidget {
//   const LessonsView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Lessons',
//           style: TextStyle(
//             color: Colors.red,
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.notifications_outlined, color: Colors.black),
//                 onPressed: () {},
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: Container(
//                   width: 8,
//                   height: 8,
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Class Schedule',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 _buildDateSelector(context, state),
//                 const SizedBox(height: 30),
//                 Expanded(
//                   child: _buildSessionsList(state.sessions),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildDateSelector(BuildContext context, LessonsState state) {
//     final days = ['M', 'T', 'W', 'T', 'F', 'S', 'M'];
//     final dates = [24, 25, 26, 27, 28, 29, 30];
//
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(7, (index) {
//             return Text(
//               days[index],
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//               ),
//             );
//           }),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(7, (index) {
//             final date = dates[index];
//             final isSelected = date == state.selectedDay;
//
//             return GestureDetector(
//               onTap: () {
//                 context.read<LessonsBloc>().add(SelectDate(date));
//               },
//               child: Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.transparent,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: Text(
//                     '$date',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: isSelected ? Colors.white : Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 3,
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSessionsList(List<SessionModel> sessions) {
//     return ListView.builder(
//       itemCount: sessions.length,
//       itemBuilder: (context, index) {
//         final session = sessions[index];
//         final isLast = index == sessions.length - 1;
//
//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Timeline
//             Column(
//               children: [
//                 Container(
//                   width: 24,
//                   height: 24,
//                   decoration: BoxDecoration(
//                     color: session.isCompleted ? Colors.grey[400] : Colors.blue,
//                     shape: BoxShape.circle,
//                   ),
//                   child: session.isCompleted
//                       ? Icon(
//                     Icons.check,
//                     color: Colors.white,
//                     size: 16,
//                   )
//                       : Icon(
//                     Icons.play_arrow,
//                     color: Colors.white,
//                     size: 16,
//                   ),
//                 ),
//                 if (!isLast)
//                   Container(
//                     width: 2,
//                     height: 60,
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(1),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(width: 16),
//             // Content
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       session.title,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: session.isCompleted ? Colors.grey[600] : Colors.black,
//                       ),
//                     ),
//                     if (session.time.isNotEmpty) ...[
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.access_time,
//                             size: 16,
//                             color: Colors.grey[600],
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             session.time,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                     if (session.subject.isNotEmpty) ...[
//                       const SizedBox(height: 4),
//                       Text(
//                         session.subject,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
// pages/lessons_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../dependencies.dart';
import '../bloc/homeworks/homework_bloc.dart';
import '../bloc/lessons/lessons_bloc.dart';
import '../bloc/lessons/lessons_event.dart';
import '../bloc/lessons/lessons_state.dart';
import '../../domain/entities/lesson.dart';
import '../widgets/homework_dialog.dart';

class LessonsPage extends StatelessWidget {
  final int scheduleSlotId;

  const LessonsPage({
    Key? key,
    required this.scheduleSlotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LessonsBloc>(
          create: (context) =>
              context.read<LessonsBloc>()..add(LoadLessons(scheduleSlotId)),
        ),
        BlocProvider<HomeworkBloc>(
          create: (context) => getIt<HomeworkBloc>(), // or your DI method
        ),
      ],
      child: const LessonsView(),
    );
  }
}

class LessonsView extends StatelessWidget {
  const LessonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Lessons",
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     'Lessons',
      //     style: TextStyle(
      //       color: Color(0xFFE53E3E),
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     Stack(
      //       children: [
      //         IconButton(
      //           icon: const Icon(Icons.notifications_outlined,
      //               color: Colors.black, size: 24),
      //           onPressed: () {},
      //         ),
      //         Positioned(
      //           right: 8,
      //           top: 8,
      //           child: Container(
      //             width: 8,
      //             height: 8,
      //             decoration: const BoxDecoration(
      //               color: Color(0xFFE53E3E),
      //               shape: BoxShape.circle,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      body: BlocBuilder<LessonsBloc, LessonsState>(
        builder: (context, state) {
          if (state is LessonsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LessonsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Get scheduleSlotId from the widget
                      final scheduleSlotId =
                          (context.widget as LessonsPage).scheduleSlotId;
                      context
                          .read<LessonsBloc>()
                          .add(LoadLessons(scheduleSlotId));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is LessonsLoaded) {
            return _buildLessonsContent(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLessonsContent(BuildContext context, LessonsLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Class Schedule',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              if (state.selectedDate != null)
                TextButton(
                  onPressed: () {
                    context
                        .read<LessonsBloc>()
                        .add(const FilterLessonsByDate(null));
                  },
                  child: const Text(
                    'Show All',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Add the date selector here
          _buildDateSelector(context, state),

          const SizedBox(height: 16),

          // Lessons List
          Expanded(
            child: state.filteredLessons.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.selectedDate != null
                              ? 'No lessons scheduled for ${DateFormat('MMM dd').format(state.selectedDate!)}'
                              : 'No lessons found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildLessonsList(context, state.filteredLessons),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, LessonsLoaded state) {
    final startDate = DateTime(2025, 7, 5); // July 5, 2025
    final endDate = DateTime(2025, 8, 4); // August 4, 2025
    final today = DateTime.now();
    final initialDate = startDate;

    // Calculate number of days between start and end dates
    final daysCount = endDate.difference(startDate).inDays + 1;

    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysCount,
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));
          final isSelected = state.selectedDate != null &&
              _isSameDay(date, state.selectedDate!);
          final hasLessons = state.allLessons
              .any((lesson) => _isSameDay(lesson.lessonDate, date));

          return GestureDetector(
            onTap: () {
              context.read<LessonsBloc>().add(FilterLessonsByDate(date));
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date).substring(0, 3),
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.red : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE53E3E)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            hasLessons ? Colors.grey[400]! : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (hasLessons)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.white : const Color(0xFFE53E3E),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildLessonsList(BuildContext context, List<Lesson> lessons) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...lessons.asMap().entries.map((entry) {
            final index = entry.key;
            final lesson = entry.value;
            final isLast = index == lessons.length - 1;

            return _buildLessonItem(context, lesson, !isLast);
          }).toList(),

          // Add "Done" item at the end
          _buildDoneItem(),
        ],
      ),
    );
  }

  Widget _buildLessonItem(BuildContext context, Lesson lesson, bool showLine) {
    final statusColor = _getStatusColor(lesson.status);
    final formattedDate = DateFormat('MMM dd, yyyy').format(lesson.lessonDate);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline dot and line
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  lesson.status == "completed"
                      ? Icons.add_task_outlined
                      : Icons.schedule_outlined,
                  color: statusColor,
                ),
                Expanded(
                  child: Container(
                    width: 3,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            // Lesson content - Made tappable with GestureDetector
            Expanded(
              child: GestureDetector(
                onTap: lesson.hasHomework == true
                    ? () =>
                        _showHomeworkDialog(context, lesson.id, lesson.title)
                    : () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: lesson.status == "completed"
                              ? Colors.green
                              : Colors.blue,
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    // decoration: BoxDecoration(
                    //   color: Colors.transparent,
                    //   borderRadius: BorderRadius.circular(12),
                    //     border: lesson.status == "completed"
                    //         ? Border.all(color: Colors.green)
                    //         : Border.all(color: Colors.blue),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.6),
                    //       spreadRadius: 5,
                    //       offset: const Offset(0, 3),
                    //     ),
                    //   ],
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                lesson.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.assignment_outlined,
                              size: 20,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        if (lesson.notes.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            lesson.notes,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                lesson.status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            lesson.hasHomework == true
                                ? Text(
                                    'Tap to view homework',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                : Text(
                                    'No homework assigned',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoneItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'All lessons completed',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'scheduled':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // Method to show homework dialog
  void _showHomeworkDialog(
      BuildContext context, int lessonId, String lessonTitle) {
    print(lessonId);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<HomeworkBloc>(),
        child: HomeworkDialog(
          lessonId: lessonId,
          lessonTitle: lessonTitle,
        ),
      ),
    );
  }
}

// class LessonsPage extends StatelessWidget {
//   final int scheduleSlotId;
//
//   const LessonsPage({
//     Key? key,
//     required this.scheduleSlotId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<LessonsBloc>(
//       create: (context) =>
//           context.read<LessonsBloc>()..add(LoadLessons(scheduleSlotId)),
//       child: const LessonsView(),
//     );
//   }
// }
//
// class LessonsView extends StatelessWidget {
//   const LessonsView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Lessons',
//           style: TextStyle(
//             color: Color(0xFFE53E3E),
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           Stack(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.notifications_outlined,
//                     color: Colors.black, size: 24),
//                 onPressed: () {},
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: Container(
//                   width: 8,
//                   height: 8,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFE53E3E),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: BlocBuilder<LessonsBloc, LessonsState>(
//         builder: (context, state) {
//           if (state is LessonsLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is LessonsError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     state.message,
//                     style: const TextStyle(fontSize: 16, color: Colors.red),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Retry logic - you'll need to pass scheduleSlotId here
//                       // context.read<LessonsBloc>().add(LoadLessons(scheduleSlotId));
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is LessonsLoaded) {
//             return _buildLessonsContent(context, state);
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
//
//   Widget _buildLessonsContent(BuildContext context, LessonsLoaded state) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Class Schedule',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//               if (state.selectedDate != null)
//                 TextButton(
//                   onPressed: () {
//                     context
//                         .read<LessonsBloc>()
//                         .add(const FilterLessonsByDate(null));
//                   },
//                   child: const Text(
//                     'Show All',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 16),
//
//           // Add the date selector here
//           _buildDateSelector(context, state),
//
//           const SizedBox(height: 16),
//
//           // Lessons List
//           Expanded(
//             child: state.filteredLessons.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.calendar_today,
//                           size: 64,
//                           color: Colors.grey[400],
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           state.selectedDate != null
//                               ? 'No lessons scheduled for ${DateFormat('MMM dd').format(state.selectedDate!)}'
//                               : 'No lessons found',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : _buildLessonsList(state.filteredLessons),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget _buildLessonsContent(BuildContext context, LessonsLoaded state) {
//   //   return Padding(
//   //     padding: const EdgeInsets.all(16.0),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //           children: [
//   //             const Text(
//   //               'Class Schedule',
//   //               style: TextStyle(
//   //                 fontSize: 20,
//   //                 fontWeight: FontWeight.w600,
//   //                 color: Colors.black,
//   //               ),
//   //             ),
//   //             if (state.selectedDate != null)
//   //               TextButton(
//   //                 onPressed: () {
//   //                   context
//   //                       .read<LessonsBloc>()
//   //                       .add(const FilterLessonsByDate(null));
//   //                 },
//   //                 child: const Text(
//   //                   'Show All',
//   //                   style: TextStyle(color: Colors.blue),
//   //                 ),
//   //               ),
//   //           ],
//   //         ),
//   //         const SizedBox(height: 16),
//   //
//   //         // Add the date picker here
//   //         _buildDatePicker(context, state),
//   //
//   //         const SizedBox(height: 16),
//   //
//   //         // Rest of your content...
//   //         Expanded(
//   //           child: state.filteredLessons.isEmpty
//   //               ? Center(
//   //                   child: Column(
//   //                     mainAxisAlignment: MainAxisAlignment.center,
//   //                     children: [
//   //                       Icon(
//   //                         Icons.calendar_today,
//   //                         size: 64,
//   //                         color: Colors.grey[400],
//   //                       ),
//   //                       const SizedBox(height: 16),
//   //                       Text(
//   //                         state.selectedDate != null
//   //                             ? 'No lessons scheduled for ${DateFormat('MMM dd').format(state.selectedDate!)}'
//   //                             : 'No lessons found',
//   //                         style: TextStyle(
//   //                           fontSize: 16,
//   //                           color: Colors.grey[600],
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 )
//   //               : _buildLessonsList(state.filteredLessons),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildDateSelector(BuildContext context, LessonsLoaded state) {
//     final startDate = DateTime(2025, 7, 5); // July 5, 2025
//     final endDate = DateTime(2025, 8, 4); // August 4, 2025
//     final today = DateTime.now();
//     final initialDate = startDate;
//
//     // Calculate number of days between start and end dates
//     final daysCount = endDate.difference(startDate).inDays + 1;
//
//     return Container(
//       height: 120,
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: daysCount,
//         itemBuilder: (context, index) {
//           final date = startDate.add(Duration(days: index));
//           final isSelected = state.selectedDate != null &&
//               _isSameDay(date, state.selectedDate!);
//           final hasLessons = state.allLessons
//               .any((lesson) => _isSameDay(lesson.lessonDate, date));
//
//           return GestureDetector(
//             onTap: () {
//               context.read<LessonsBloc>().add(FilterLessonsByDate(date));
//             },
//             child: Container(
//               width: 60,
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     DateFormat('E').format(date).substring(0, 3),
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: isSelected ? Colors.red : Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: isSelected ? const Color(0xFFE53E3E) : Colors.transparent,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: hasLessons ? Colors.grey[400]! : Colors.transparent,
//                         width: 1,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         date.day.toString(),
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: isSelected ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   if (hasLessons)
//                     Container(
//                       width: 6,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.white : const Color(0xFFE53E3E),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // Widget _buildDatePicker(BuildContext context, LessonsLoaded state) {
//   //   final now = DateTime.now();
//   //   final initialDate = state.selectedDate ?? now;
//   //   final pageController = PageController(
//   //     initialPage: initialDate.difference(now).inDays,
//   //   );
//   //
//   //   return SizedBox(
//   //     height: 100, // Adjust height as needed
//   //     child: PageView.builder(
//   //       controller: pageController,
//   //       onPageChanged: (index) {
//   //         final selectedDate = now.add(Duration(days: index));
//   //         context.read<LessonsBloc>().add(FilterLessonsByDate(selectedDate));
//   //       },
//   //       itemBuilder: (context, index) {
//   //         final date = now.add(Duration(days: index));
//   //         final isSelected = state.selectedDate != null
//   //             ? _isSameDay(date, state.selectedDate!)
//   //             : _isSameDay(date, now);
//   //
//   //         return GestureDetector(
//   //           onTap: () {
//   //             context.read<LessonsBloc>().add(FilterLessonsByDate(date));
//   //             pageController.animateToPage(
//   //               index,
//   //               duration: const Duration(milliseconds: 300),
//   //               curve: Curves.easeInOut,
//   //             );
//   //           },
//   //           child: Container(
//   //             margin: const EdgeInsets.symmetric(horizontal: 8),
//   //             padding: const EdgeInsets.all(12),
//   //             decoration: BoxDecoration(
//   //               color: isSelected ? const Color(0xFFE53E3E) : Colors.grey[200],
//   //               borderRadius: BorderRadius.circular(12),
//   //             ),
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 Text(
//   //                   DateFormat('EEE').format(date), // Day name (Mon, Tue, etc.)
//   //                   style: TextStyle(
//   //                     fontSize: 14,
//   //                     fontWeight: FontWeight.w500,
//   //                     color: isSelected ? Colors.white : Colors.black,
//   //                   ),
//   //                 ),
//   //                 const SizedBox(height: 4),
//   //                 Text(
//   //                   date.day.toString(), // Day number
//   //                   style: TextStyle(
//   //                     fontSize: 20,
//   //                     fontWeight: FontWeight.bold,
//   //                     color: isSelected ? Colors.white : Colors.black,
//   //                   ),
//   //                 ),
//   //                 const SizedBox(height: 4),
//   //                 Text(
//   //                   DateFormat('MMM').format(date), // Month name
//   //                   style: TextStyle(
//   //                     fontSize: 12,
//   //                     color: isSelected ? Colors.white : Colors.black,
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         );
//   //       },
//   //     ),
//   //   );
//   // }
//
//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }
//
//   Widget _buildLessonsList(List<Lesson> lessons) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           ...lessons.asMap().entries.map((entry) {
//             final index = entry.key;
//             final lesson = entry.value;
//             final isLast = index == lessons.length - 1;
//
//             return _buildLessonItem(lesson, !isLast);
//           }).toList(),
//
//           // Add "Done" item at the end
//           _buildDoneItem(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLessonItem(Lesson lesson, bool showLine) {
//     final statusColor = _getStatusColor(lesson.status);
//     final formattedDate = DateFormat('MMM dd, yyyy').format(lesson.lessonDate);
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 24),
//       child: IntrinsicHeight(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Timeline dot and line
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(
//                   lesson.status == "completed"
//                       ? Icons.add_task_outlined
//                       : Icons.schedule_outlined,
//                   color: statusColor,
//                 ),
//                 // if (showLine)
//                 Expanded(
//                   child: Container(
//                     width: 3,
//                     // height: 90,
//                     color: Colors.grey[300],
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(width: 16),
//
//             // Lesson content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     lesson.title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.calendar_today,
//                         size: 16,
//                         color: Colors.grey[600],
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         formattedDate,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (lesson.notes.isNotEmpty) ...[
//                     const SizedBox(height: 4),
//                     Text(
//                       lesson.notes,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                   const SizedBox(height: 4),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: statusColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       lesson.status.toUpperCase(),
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: statusColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDoneItem() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 24),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 12,
//             height: 12,
//             decoration: BoxDecoration(
//               color: Colors.grey[400],
//               shape: BoxShape.circle,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Text(
//             'All lessons completed',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[500],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return Colors.green;
//       case 'scheduled':
//         return Colors.blue;
//       case 'cancelled':
//         return Colors.red;
//       case 'pending':
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }
// //
// // bool _isSameDay(DateTime date1, DateTime date2) {
// //   return date1.year == date2.year &&
// //       date1.month == date2.month &&
// //       date1.day == date2.day;
// // }
// }
