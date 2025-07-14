// lib/features/notifications/presentation/widgets/notification_list_tile.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/notification.dart';

class NotificationListTile extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;
  final VoidCallback? onMarkAsRead;

  const NotificationListTile({
    Key? key,
    required this.notification,
    this.onTap,
    this.onMarkAsRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notification.isRead
              ? Colors.grey.shade300
              : Theme.of(context).primaryColor,
          child: Icon(
            _getIconForNotificationType(notification.type),
            color: notification.isRead ? Colors.grey : Colors.white,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM dd, yyyy - HH:mm').format(notification.createdAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: !notification.isRead
            ? PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'mark_read') {
              onMarkAsRead?.call();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'mark_read',
              child: Text('Mark as read'),
            ),
          ],
        )
            : null,
        onTap: () {
          if (!notification.isRead) {
            onMarkAsRead?.call();
          }
          onTap?.call();
        },
      ),
    );
  }

  IconData _getIconForNotificationType(String type) {
    switch (type) {
      case 'deposit_approved':
        return Icons.check_circle;
      case 'deposit_rejected':
        return Icons.cancel;
      case 'withdrawal_approved':
        return Icons.money_off;
      case 'withdrawal_rejected':
        return Icons.block;
      case 'payment_received':
        return Icons.payment;
      case 'course_enrolled':
        return Icons.school;
      case 'assignment_due':
        return Icons.assignment_late;
      default:
        return Icons.notifications;
    }
  }
}