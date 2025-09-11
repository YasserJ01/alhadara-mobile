import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../dependencies.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../domain/entities/lesson_summary.dart';
import '../bloc/lesson_summary/lesson_summary_bloc.dart';
import '../bloc/lessons/lessons_bloc.dart';
import '../pages/lessons_page.dart';

class AssignmentTab extends StatelessWidget {
  final int scheduleSlotId;
  final DateTime startDate;
  final DateTime endDate;

  const AssignmentTab(
      {super.key,
      required this.scheduleSlotId,
      required this.startDate,
      required this.endDate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = const Color(0xffF4F8FB);
        Color cardColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return Column(
          children: [
            // View All button at the top right
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => getIt<LessonsBloc>(),
                        child: LessonsPage(
                          scheduleSlotId: scheduleSlotId,
                          startDate: startDate,
                          endDate: endDate,
                        ),
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: textColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.viewAll),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 16, color: textColor),
                  ],
                ),
              ),
            ),

            // Assignments list below the button
            Expanded(
              child: BlocBuilder<LessonSummaryBloc, LessonSummaryState>(
                builder: (context, state) {
                  if (state is LessonSummariesLoaded) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      itemCount: state.lessons.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final lesson = state.lessons[index];
                        return _buildLessonCard(context, lesson, cardColor,
                            textColor, secondaryTextColor);
                      },
                    );
                  } else if (state is LessonSummaryError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLessonCard(BuildContext context, LessonSummary lesson,
      Color cardColor, Color textColor, Color secondaryTextColor) {
    final l10n = AppLocalizations.of(context);
    return Card(
      elevation: 5,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: textColor.withOpacity(0.4)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          title: Text(
            lesson.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: textColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    lesson.lessonDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildStatusChip(lesson.status),
            ],
          ),
          trailing: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: textColor.withOpacity(0.1),
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: textColor,
            ),
          ),
          childrenPadding: const EdgeInsets.only(bottom: 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                l10n.homeworkAssignments,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: secondaryTextColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (lesson.homework.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  l10n.noHomeworkAssigned,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: secondaryTextColor,
                  ),
                ),
              )
            else
              ...lesson.homework
                  .map((hw) => _buildHomeworkItem(hw, textColor))
                  .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeworkItem(LessonSummaryHomework hw, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: textColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.assignment,
              size: 20,
              color: textColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hw.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: textColor.withOpacity(0.6),
            ),
            onPressed: () {
              // Navigate to homework details
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'completed':
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade800;
        icon = Icons.check_circle;
        break;
      case 'in progress':
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade800;
        icon = Icons.access_time;
        break;
      case 'pending':
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade800;
        icon = Icons.pending;
        break;
      default:
        bgColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
