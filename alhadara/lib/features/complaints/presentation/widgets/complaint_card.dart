import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/features/complaints/data/models/complaint_model.dart';
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
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd MMM yyyy - hh:mm a');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.responsiveSize(context,
            mobile: 15, tablet: 18, desktop: 20)),
        side: BorderSide(color: AppColors.mainColor.withOpacity(0.4)),
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
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainColor,
                ),
              ),
              const SizedBox(height: 8),

              // Description (collapsed)
              Text(
                complaint.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
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
                        color: AppColors.mainColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateFormat.format(complaint.createdAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
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
                          color: AppColors.mainColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          complaint.enrollmentDetails!['course_title'],
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
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
