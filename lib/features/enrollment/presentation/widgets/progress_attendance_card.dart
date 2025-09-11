import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';

class ProgressAttendanceCard extends StatelessWidget {
  final double progress;
  final double attendance;
  final int? lessons;
  final int? lessonsCount;
  final String courseTitle;

  const ProgressAttendanceCard({
    super.key,
    required this.progress,
    required this.attendance,
    required this.courseTitle,
    this.lessons,
    this.lessonsCount,
  });

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
          secondaryTextColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return Card(
          elevation: 5,
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: textColor.withOpacity(0.4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  courseTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircularProgress(
                      value: progress / 100,
                      title: l10n.progress,
                      percentage: progress,
                      color: _getProgressColor(progress),
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    ),
                    Container(
                      width: 1,
                      height: 100,
                      color: secondaryTextColor.withOpacity(0.3),
                    ),
                    _buildCircularProgress(
                      value: attendance / 100,
                      title: l10n.attendance,
                      percentage: attendance.toDouble(),
                      color: _getAttendanceColor(attendance),
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildStatsRow(context, textColor, secondaryTextColor),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCircularProgress({
    required double value,
    required String title,
    required double percentage,
    required Color color,
    required Color textColor,
    required Color secondaryTextColor,
  }) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 8,
                  backgroundColor: secondaryTextColor.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, Color textColor, Color secondaryTextColor) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color cardColor = Colors.white;
        if (themeState is ThemeLoaded) {
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
        }

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: textColor.withOpacity(0.1),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
            color: cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                  Icons.menu_book,
                  l10n.lessons,
                  lessonsCount?.toString() ?? '0',
                  textColor,
                  secondaryTextColor
              ),
              _buildStatItem(
                  Icons.room,
                  l10n.hall,
                  lessonsCount?.toString() ?? '0',
                  textColor,
                  secondaryTextColor
              ),
              _buildStatItem(
                  Icons.access_time_filled,
                  l10n.time,
                  lessonsCount?.toString() ?? '0',
                  textColor,
                  secondaryTextColor
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value, Color textColor, Color secondaryTextColor) {
    return Column(
      children: [
        Icon(icon, size: 20, color: textColor.withOpacity(0.8)),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: secondaryTextColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 80) return Colors.green;
    if (progress >= 50) return Colors.blueAccent;
    return Colors.red;
  }

  Color _getAttendanceColor(double attendance) {
    if (attendance >= 90) return Colors.green;
    if (attendance >= 70) return Colors.blueAccent;
    if (attendance >= 50) return Colors.orange;
    return Colors.red;
  }
}