import 'package:alhadara/features/enrollment/domain/entities/lesson_summary.dart';
import 'package:alhadara/features/enrollment/presentation/bloc/lessons/lesson_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/core/constants/colors.dart';

class AssignmentTab extends StatelessWidget {
  const AssignmentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        if (state is LessonSummariesLoaded) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: state.lessons.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final lesson = state.lessons[index];
              return _buildLessonCard(context, lesson);
            },
          );
        } else if (state is LessonError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildLessonCard(BuildContext context, LessonSummary lesson) {
    return Card(
      elevation: 5,
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: AppColors.mainColor.withOpacity(0.4))),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          title: Text(
            lesson.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.mainColor),
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
                    color: AppColors.mainColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    lesson.lessonDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
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
              color: AppColors.mainColor
                  .withOpacity(0.1), // Circular icon background
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.mainColor,
            ),
          ),
          childrenPadding: const EdgeInsets.only(bottom: 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Homework Assignments',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (lesson.homework.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'No homework assigned for this lesson',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500,
                  ),
                ),
              )
            else
              ...lesson.homework.map((hw) => _buildHomeworkItem(hw)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeworkItem(Homework hw) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.mainColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.assignment,
              size: 20,
              color: AppColors.mainColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hw.title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 243, 62, 8)),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
            onPressed: () {
              // التنقل إلى تفاصيل الواجب
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
