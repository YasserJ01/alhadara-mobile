import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/enrollment/domain/entities/enrollment_entity.dart';
import 'package:alhadara/features/enrollment/presentation/bloc/enrollments/enrollment_bloc.dart';
import 'package:alhadara/features/enrollment/presentation/bloc/lessons/lesson_bloc.dart';
import 'package:alhadara/features/enrollment/presentation/widgets/active_course/progress_attendance_card.dart';
import 'package:alhadara/features/enrollment/presentation/widgets/lessons/assignment_tab.dart';
import 'package:alhadara/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveCoursePage extends StatelessWidget {
  final int courseId;
  final int scheduleSlotId;

  const ActiveCoursePage(
      {super.key, required this.courseId, required this.scheduleSlotId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<EnrollmentBloc>()..add(FetchEnrollmentDetails(courseId)),
        ),
        BlocProvider(
          create: (context) =>
              getIt<LessonBloc>()..add(FetchLessonSummaries(scheduleSlotId)),
        ),
      ],
      child: AppScaffold(
        edgeInsets: EdgeInsets.all(0),
        title: 'Course Details',
        icon: Icons.home_outlined,
        onPressedEndIcon: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ),
          );
        },
        body: BlocBuilder<EnrollmentBloc, EnrollmentState>(
          builder: (context, state) {
            if (state is EnrollmentDetailsLoaded) {
              return _buildCourseDetails(state.enrollment);
            } else if (state is EnrollmentError) {
              return Center(child: Text(state.message));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildCourseDetails(EnrollmentEntity enrollment) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          // _buildCourseHeader(enrollment),
          const SizedBox(height: 20),
          ProgressAttendanceCard(
              courseTitle: enrollment.courseTitle,
              lessonsCount: enrollment.lessonsCount,
              progress:
                  double.tryParse(enrollment.courseProgress.toString()) ?? 0,
              attendance: enrollment.attendance),
          const SizedBox(height: 20),
          _buildCourseTabs(enrollment),
        ],
      ),
    );
  }

  // في ملف active_course_page.dart
  Widget _buildCourseTabs(EnrollmentEntity enrollment) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 242, 207, 207),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainColor.withOpacity(0.8),
                    AppColors.mainColor,
                  ],
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              tabs: const [
                Tab(
                  icon: Icon(Icons.info_outline),
                  text: 'Course Info',
                ),
                Tab(
                  icon: Icon(Icons.assignment_outlined),
                  text: 'Assignments',
                ),
              ],
            ),
          ),
          const SizedBox(height: 1),
          Container(
            height: 300,
            child: TabBarView(
              children: [
                _buildInfoTab(enrollment),
                const AssignmentTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCourseTabs(EnrollmentEntity enrollment) {
  //   return DefaultTabController(
  //     length: 2,
  //     child: Column(
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.grey.shade100,
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: TabBar(
  //             indicator: BoxDecoration(
  //               borderRadius: BorderRadius.circular(12),
  //               color: AppColors.mainColor,
  //             ),
  //             labelColor: Colors.white,
  //             unselectedLabelColor: Colors.grey.shade700,
  //             tabs: const [
  //               Tab(
  //                 icon: Icon(Icons.info),
  //               ),
  //               Tab(icon: Icon(Icons.assignment)),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         SizedBox(
  //           height: 300,
  //           child: TabBarView(
  //             children: [
  //               _buildInfoTab(enrollment),
  //               _buildAssignmentsTab(),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildInfoTab(EnrollmentEntity enrollment) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // _buildDetailItem(
            //     'Enrollment Date', _formatDate(enrollment.enrollmentDate)),
            // _buildDetailItem(
            //     'Course Progress', '${enrollment.courseProgress}%'),
            // _buildDetailItem(
            //     'Lessons Count', enrollment.lessonsCount.toString()),
            // _buildDetailItem('Amount Paid', '\$${enrollment.amountPaid}'),
            // _buildDetailItem(
            //     'Remaining Balance', '\$${enrollment.remainingBalance}'),
          ],
        ),
      ),
    );
  }

  // Widget _buildAssignmentsTab() {
  //   return Card(
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: const Padding(
  //       padding: EdgeInsets.all(16),
  //       child: Center(
  //         child: Text(
  //           'Assignments will appear here',
  //           style: TextStyle(color: Colors.grey),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildAssignmentsTab() {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        if (state is LessonSummariesLoaded) {
          return ListView.builder(
            itemCount: state.lessons.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(state.lessons[index].title),
                subtitle: Text(
                    'Date: ${state.lessons[index].lessonDate} - Status: ${state.lessons[index].status}'),
                children: [
                  if (state.lessons[index].homework.isNotEmpty)
                    ...state.lessons[index].homework
                        .map((hw) => ListTile(
                              title: Text(hw.title),
                              leading: Icon(Icons.assignment),
                            ))
                        .toList()
                  else
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No homework for this lesson'),
                    )
                ],
              );
            },
          );
        } else if (state is LessonError) {
          return Center(child: Text(state.message));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
// Widget _buildInfoRow(IconData icon, String label, String value) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 6),
//     child: Row(
//       children: [
//         Icon(icon, size: 20, color: AppColors.mainColor),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(width: 4),
//         Text(value),
//       ],
//     ),
//   );
// }

Widget _buildDetailItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    ),
  );
}

String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
