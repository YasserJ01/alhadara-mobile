// features/notifications/presentation/widgets/notification_dialog.dart
import 'package:flutter/material.dart';

import '../../domain/entities/notification.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;

  const NotificationDialog({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: EdgeInsets.zero,
      content: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _getNotificationIcon(notification.type),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      notification.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                notification.message,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatTime(notification.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Dismiss'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getNotificationIcon(String type) {
    IconData iconData;
    Color color;

    switch (type) {
      case 'deposit_approved':
        iconData = Icons.check_circle;
        color = Colors.green;
        break;
      case 'homework_assigned':
        iconData = Icons.assignment;
        color = Colors.blue;
        break;
      case 'lesson_reminder':
        iconData = Icons.schedule;
        color = Colors.orange;
        break;
      default:
        iconData = Icons.notifications;
        color = Colors.grey;
    }

    return Icon(iconData, color: color, size: 24);
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}