import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/private_lesson_request.dart';
import '../bloc/get_private_lesson/private_lesson_requests_list_bloc.dart';

class PrivateLessonRequestCard extends StatefulWidget {
  final PrivateLessonRequest request;

  const PrivateLessonRequestCard({required this.request});

  @override
  State<PrivateLessonRequestCard> createState() =>
      _PrivateLessonRequestCardState();
}

class _PrivateLessonRequestCardState extends State<PrivateLessonRequestCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final request = widget.request;
    final isProposed = request.status.toLowerCase() == 'proposed';
    final privateLessonRequest = context.read<PrivateLessonRequestsListBloc>();
    return Card(
      // elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
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
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Request #${request.id}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 145, 110, 110),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        color: Colors.red[400],
                        onPressed: () => _showDeleteDialog(
                            context, privateLessonRequest, request.id),
                      ),
                      if (isProposed && request.proposedOptions.isNotEmpty)
                        Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: AppColors.mainColor,
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(request.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _getStatusColor(request.status),
                    width: 1,
                  ),
                ),
                child: Text(
                  request.status.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(request.status),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildSection(
                  'Preferred Time',
                  Icons.calendar_today,
                  '${DateFormat('EEEE, MMM d').format(DateTime.parse(request.preferredDate))}\n'
                      '${_formatTime(request.preferredTimeFrom)} - ${_formatTime(request.preferredTimeTo)}'),
              if (request.confirmedDate != null) ...[
                const SizedBox(height: 12),
                _buildSection(
                    'Confirmed Time',
                    Icons.event_available,
                    '${DateFormat('EEEE, MMM d').format(DateTime.parse(request.confirmedDate!))}\n'
                        '${_formatTime(request.confirmedTimeFrom!)} - ${_formatTime(request.confirmedTimeTo!)}'),
              ],
              if (isProposed &&
                  request.proposedOptions.isNotEmpty &&
                  _isExpanded) ...[
                const SizedBox(height: 12),
                const Text(
                  'Available Options:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
                const SizedBox(height: 8),
                ...request.proposedOptions.map((option) => _buildOptionItem(
                      context,
                      option,
                      request.id,
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppColors.mainColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionItem(
      BuildContext context, ProposedOption option, int requestId) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          context.read<PrivateLessonRequestsListBloc>().add(
                PickProposedOptionEvent(
                  requestId: requestId,
                  optionId: option.id,
                ),
              );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[100]!),
          ),
          child: Row(
            children: [
              const Icon(Icons.event_available,
                  color: AppColors.mainColor, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, MMM d')
                          .format(DateTime.parse(option.date)),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatTime(option.timeFrom)} - ${_formatTime(option.timeTo)}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext parentContext,
    PrivateLessonRequestsListBloc privateLessonRequestsListBloc,
    int requestId,
  ) {
    showDialog(
      context: parentContext,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              privateLessonRequestsListBloc.add(
                DeletePrivateLessonRequestEvent(requestId),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'proposed':
        return Colors.blue;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  String _formatTime(String timeString) {
    try {
      final timeFormat = DateFormat('HH:mm:ss');
      final dateTime = timeFormat.parse(timeString);
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      return timeString;
    }
  }
}
