import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/enrollment/presentation/widgets/payment_dialog.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/enrollment_entity.dart';
import '../bloc/enrollments/enrollment_bloc.dart';

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
          remainingBalance: widget.enrollment.remainingBalance,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
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
                _buildHeader(),
                const SizedBox(height: 8),
                _buildPaymentSummary(),
                if (_isExpanded) _buildExpandedContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.enrollment.courseTitle.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
          ),
        ),
        Row(
          children: [
            _buildStatusChip(widget.enrollment.status),
            const SizedBox(width: 8),
            AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: _isExpanded ? 0.5 : 0,
              child: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.mainColor,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPaymentItem('Paid', widget.enrollment.amountPaid, Colors.green),
        _buildPaymentItem(
            'Remaining', widget.enrollment.remainingBalance, Colors.orange),
        _buildPaymentStatus(widget.enrollment.paymentStatus),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        _buildInfoRow(Icons.person, 'Student', widget.enrollment.studentName),
        const SizedBox(height: 8),
        _buildInfoRow(
            Icons.schedule, 'Schedule', widget.enrollment.scheduleSlotDisplay),
        const SizedBox(height: 8),
        _buildInfoRow(Icons.calendar_today, 'Enrollment Date',
            _formatDate(widget.enrollment.enrollmentDate)),
        const SizedBox(height: 16),
        //  if (widget.enrollment.notes.isNotEmpty) _buildNotesSection(),
        const SizedBox(height: 16),
        _buildPaymentButton(),
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

  Widget _buildPaymentItem(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStatus(String status) {
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
          'Payment',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.mainColor),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildNotesSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'NOTES',
  //         style: TextStyle(
  //           fontSize: 12,
  //           color: Colors.grey.shade600,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(height: 4),
  //       Text(
  //         widget.enrollment.notes,
  //         style: const TextStyle(fontSize: 14),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.payment, size: 20),
        label: const Text('ADD PAYMENT'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: _showPaymentDialog,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
