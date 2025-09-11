import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../data/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';

class ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;
  final VoidCallback? onTap;

  const ComplaintCard({
    required this.complaint,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy - hh:mm a');

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;
        Color borderColor = AppColors.mainColor.withOpacity(0.4);

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
          borderColor = textColor.withOpacity(0.4);
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          elevation: 5,
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.responsiveSize(context,
                mobile: 15, tablet: 18, desktop: 20)),
            side: BorderSide(color: borderColor),
          ),
          shadowColor: Colors.black.withOpacity(0.4),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Type and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTypeChip(context),
                      _buildStatusIndicator(),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    complaint.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description (collapsed)
                  Text(
                    complaint.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Date and Course
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: textColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            dateFormat.format(complaint.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),

                      // Course (if available) - Now below the date
                      if (complaint.enrollmentDetails != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.school_outlined,
                              size: 16,
                              color: textColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              complaint.enrollmentDetails!['course_title'],
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeChip(BuildContext context) {
    final typeColors = {
      'general': Colors.orange,
      'teacher': Colors.purple,
      'course': Colors.green,
      'technical': Colors.blueGrey,
      'facility': Colors.red,
    };

    return Chip(
      label: Text(
        complaint.type.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: typeColors[complaint.type] ?? Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildStatusIndicator() {
    final statusColors = {
      'submitted': Colors.green,
      'in_progress': Colors.orange,
      'resolved': Colors.blueGrey,
      'rejected': Colors.red,
    };

    final statusIcons = {
      'submitted': Icons.access_time,
      'in_progress': Icons.autorenew,
      'resolved': Icons.check_circle,
      'rejected': Icons.cancel,
    };

    return Row(
      children: [
        Icon(
          statusIcons[complaint.status] ?? Icons.help_outline,
          size: 16,
          color: statusColors[complaint.status] ?? Colors.grey,
        ),
        const SizedBox(width: 4),
        Text(
          complaint.status.replaceAll('_', ' ').toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: statusColors[complaint.status] ?? Colors.grey,
          ),
        ),
      ],
    );
  }
}
