import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/enrollment/presentation/widgets/payment_dialog.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../dependencies.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../domain/entities/enrollment_entity.dart';
import '../bloc/enrollments/enrollment_bloc.dart';
import '../pages/active_course_page.dart';

class ExpandableEnrollmentCard extends StatefulWidget {
  final EnrollmentEntity enrollment;

  const ExpandableEnrollmentCard({super.key, required this.enrollment});

  @override
  State<ExpandableEnrollmentCard> createState() =>
      _ExpandableEnrollmentCardState();
}

class _ExpandableEnrollmentCardState extends State<ExpandableEnrollmentCard> {
  bool _isExpanded = false;

  void _showPaymentDialog() {
    final bloc = context.read<EnrollmentBloc>();

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: PaymentDialog(
          enrollmentId: widget.enrollment.id,
          remainingBalance: widget.enrollment.remainingBalance.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(textColor, secondaryTextColor),
                    const SizedBox(height: 8),
                    _buildPaymentSummary(secondaryTextColor),
                    if (_isExpanded) _buildExpandedContent(textColor, secondaryTextColor),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Color textColor, Color secondaryTextColor) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.enrollment.courseTitle.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => getIt<EnrollmentBloc>(),
                      child: ActiveCoursePage(
                        courseId: widget.enrollment.id,
                        scheduleSlotId: widget.enrollment.scheduleSlot,
                        startDate: widget.enrollment.startDate,
                          endDate: widget.enrollment.endDate,
                        studentId: widget.enrollment.student,
                        status: widget.enrollment.status,
                      ),
                    ),
                  ),
                );
              },
              child: Chip(
                label: Text(
                  l10n.viewCourse,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: textColor.withOpacity(0.2),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildStatusChip(widget.enrollment.status),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textColor.withOpacity(0.1),
                  ),
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: _isExpanded ? 0.5 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: textColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSummary(Color secondaryTextColor) {
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPaymentItem(
            l10n.paid,
            widget.enrollment.amountPaid.toString(),
            Colors.green,
            secondaryTextColor
        ),
        _buildPaymentItem(
            l10n.remaining,
            widget.enrollment.remainingBalance.toString(),
            Colors.orange,
            secondaryTextColor
        ),
        _buildPaymentStatus(widget.enrollment.paymentStatus, secondaryTextColor),
      ],
    );
  }

  Widget _buildExpandedContent(Color textColor, Color secondaryTextColor) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        const SizedBox(height: 16),
        Divider(color: secondaryTextColor.withOpacity(0.3)),
        const SizedBox(height: 8),
        _buildInfoRow(Icons.person, l10n.student, widget.enrollment.studentName, textColor, secondaryTextColor),
        const SizedBox(height: 8),
        _buildInfoRow(Icons.calendar_today, l10n.enrollmentDate,
            _formatDate(widget.enrollment.enrollmentDate), textColor, secondaryTextColor),
        const SizedBox(height: 16),
        _buildPaymentButton(textColor),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'active':
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'pending':
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'completed':
        bgColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      default:
        bgColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Chip(
      label: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: bgColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildPaymentItem(String label, String value, Color color, Color secondaryTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: secondaryTextColor,
          ),
        ),
        Text(
          '\$$value',
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStatus(String status, Color secondaryTextColor) {
    IconData icon;
    Color color;
    String label;

    switch (status.toLowerCase()) {
      case 'paid':
        icon = Icons.check_circle;
        color = Colors.green;
        label = 'Paid';
        break;
      case 'partial':
        icon = Icons.pending;
        color = Colors.orange;
        label = 'Partial';
        break;
      case 'unpaid':
        icon = Icons.cancel;
        color = Colors.red;
        label = 'Unpaid';
        break;
      default:
        icon = Icons.help;
        color = Colors.grey;
        label = 'Unknown';
    }

    return Column(
      children: [
        Text(
          AppLocalizations.of(context).payment,
          style: TextStyle(
            fontSize: 12,
            color: secondaryTextColor,
          ),
        ),
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color textColor, Color secondaryTextColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: textColor),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentButton(Color textColor) {
    return SizedBox(
      width: double.infinity,
      child: AppElevatedButton(
        onPressed: _showPaymentDialog,
        child: Text(
          AppLocalizations.of(context).addPayment,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}