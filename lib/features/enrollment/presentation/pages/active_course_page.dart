import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/enrollment/presentation/pages/news_feed_wrapper.dart';
import 'package:project2/features/enrollment/presentation/pages/private_lesson_request_page.dart';
import 'package:project2/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../dependencies.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../../feedback/presentation/pages/feedback_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../quiz/presentation/bloc/quiz_attempt/quiz_attempt_bloc.dart';
import '../../../quiz/presentation/bloc/quiz_list/quiz_list_bloc.dart';
import '../../../quiz/presentation/bloc/quiz_questions/quiz_questions_bloc.dart';
import '../../../quiz/presentation/pages/quiz_list_page.dart';
import '../../domain/entities/enrollment_entity.dart';
import '../bloc/enrollments/enrollment_bloc.dart';
import '../bloc/lesson_summary/lesson_summary_bloc.dart';
import '../widgets/assignment_tab.dart';
import '../widgets/progress_attendance_card.dart';

class ActiveCoursePage extends StatelessWidget {
  final int courseId;
  final int scheduleSlotId;
  final DateTime startDate;
  final DateTime endDate;
  final int studentId;
  final String status;

  const ActiveCoursePage(
      {super.key,
      required this.courseId,
      required this.scheduleSlotId,
      required this.startDate,
      required this.endDate,
      required this.studentId,
      required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<EnrollmentBloc>()..add(FetchEnrollmentDetails(courseId)),
        ),
        BlocProvider(
          create: (context) => getIt<LessonSummaryBloc>()
            ..add(FetchLessonSummaries(scheduleSlotId)),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: AppScaffold(
          edgeInsets: const EdgeInsets.all(0),
          title: l10n.courseDetails,
          icon: Icons.person,
          onPressedEndIcon: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PrivateLessonRequestPage(
                    scheduleSlotId: scheduleSlotId,
                  );
                },
              ),
            );
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => const HomePage(),
            //   ),
            // );
          },
          bottomNavigationBar: _buildBottomAppBar(context),
          body: TabBarView(
            children: [
              _buildInfoTabContent(context),
              NewsFeedWrapper(scheduleSlotId: scheduleSlotId),
              AssignmentTab(
                scheduleSlotId: scheduleSlotId,
                startDate: startDate,
                endDate: endDate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;

        if (themeState is ThemeLoaded) {
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: textColor.withOpacity(0.1),
            ),
            labelColor: textColor,
            unselectedLabelColor: secondaryTextColor,
            tabs: const [
              Tab(
                icon: Icon(Icons.info_outline),
                text: 'Info',
              ),
              Tab(
                icon: Icon(Icons.dashboard_outlined),
                text: 'News',
              ),
              Tab(
                icon: Icon(Icons.assignment_outlined),
                text: 'Assignments',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoTabContent(BuildContext context) {
    return BlocBuilder<EnrollmentBloc, EnrollmentState>(
      builder: (context, state) {
        if (state is EnrollmentDetailsLoaded) {
          return _buildInfoTab(context, state.enrollment);
        } else if (state is EnrollmentError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildInfoTab(BuildContext context, EnrollmentEntity enrollment) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;

        if (themeState is ThemeLoaded) {
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ProgressAttendanceCard(
                courseTitle: enrollment.courseTitle,
                lessonsCount: enrollment.lessonsCount,
                progress:
                    double.tryParse(enrollment.courseProgress.toString()) ?? 0,
                attendance: enrollment.attendance,
              ),
              const SizedBox(height: 20),
              AppElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                              create: (context) => getIt<QuizListBloc>()),
                          BlocProvider(
                              create: (context) => getIt<QuizAttemptBloc>()),
                          BlocProvider(
                              create: (context) => getIt<QuizQuestionsBloc>()),
                        ],
                        child: QuizListPage(scheduleSlotId: scheduleSlotId),
                      ),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context).startQuiz,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              if (status == "completed") ...[
                AppElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => getIt<FeedbackBloc>(),
                        child: FeedbackPage(
                          scheduleSlotId: scheduleSlotId,
                          studentId: studentId,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    "Feedback",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              _buildInfoCard(
                  enrollment, context, textColor, secondaryTextColor),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(EnrollmentEntity enrollment, BuildContext context,
      Color textColor, Color secondaryTextColor) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color cardColor = Colors.white;
        if (themeState is ThemeLoaded) {
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
        }

        return Card(
          elevation: 2,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailItem(
                    l10n.enrollmentDate,
                    _formatDate(enrollment.enrollmentDate),
                    textColor,
                    secondaryTextColor),
                _buildDetailItem(
                    l10n.courseProgress,
                    '${enrollment.courseProgress}%',
                    textColor,
                    secondaryTextColor),
                _buildDetailItem(
                    l10n.lessonsCount,
                    enrollment.lessonsCount.toString(),
                    textColor,
                    secondaryTextColor),
                _buildDetailItem(l10n.amountPaid, '\$${enrollment.amountPaid}',
                    textColor, secondaryTextColor),
                _buildDetailItem(
                    l10n.remainingBalance,
                    '\$${enrollment.remainingBalance}',
                    textColor,
                    secondaryTextColor),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(
      String label, String value, Color textColor, Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: secondaryTextColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
