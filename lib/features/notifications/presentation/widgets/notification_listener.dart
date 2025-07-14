// features/notifications/presentation/widgets/notification_listener.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_state.dart';
import 'notification_dialog.dart';

class NotificationListener extends StatelessWidget {
  final Widget child;
  final bool showDialogOnReceive;

  const NotificationListener({
    super.key,
    required this.child,
    this.showDialogOnReceive = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationNewReceived && showDialogOnReceive) {
          _showNotificationDialog(context, state.notification);
        }
      },
      child: child,
    );
  }

  void _showNotificationDialog(BuildContext context, notification) {
    showDialog(
      context: context,
      builder: (context) => NotificationDialog(
        notification: notification,
        onTap: () {
          Navigator.of(context).pop();
          // Handle notification tap - navigate to relevant screen
          _handleNotificationTap(context, notification);
        },
      ),
    );
  }

  void _handleNotificationTap(BuildContext context, notification) {
    // Handle different notification types
    switch (notification.type) {
      case 'deposit_approved':
      // Navigate to deposit screen
        break;
      case 'homework_assigned':
      // Navigate to homework screen
        break;
    // Add more cases as needed
      default:
        break;
    }
  }
}