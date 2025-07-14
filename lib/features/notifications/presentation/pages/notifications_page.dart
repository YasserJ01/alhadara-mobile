// features/notifications/presentation/pages/notifications_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../widgets/notification_list_item.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
        foregroundColor: Colors.white,
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationConnected ||
                  state is NotificationDisconnected) {
                return IconButton(
                  icon: Icon(
                    state is NotificationConnected
                        ? Icons.wifi
                        : Icons.wifi_off,
                    color: state is NotificationConnected
                        ? Colors.green
                        : Colors.grey,
                  ),
                  onPressed: () {
                    if (state is NotificationDisconnected) {
                      context.read<NotificationBloc>().add(NotificationConnect());
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading || state is NotificationConnecting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(162, 12, 13, 1.0),
              ),
            );
          }

          if (state is NotificationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NotificationBloc>().add(NotificationLoadRequested());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
                    ),
                    child: const Text('Retry', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          List<dynamic> notifications = [];
          if (state is NotificationLoaded) {
            notifications = state.notifications;
          } else if (state is NotificationConnected) {
            notifications = state.notifications;
          } else if (state is NotificationNewReceived) {
            notifications = state.allNotifications;
          } else if (state is NotificationDisconnected) {
            notifications = state.notifications;
          }

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<NotificationBloc>().add(NotificationLoadRequested());
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationListItem(
                  notification: notification,
                  onTap: () {
                    if (!notification.isRead) {
                      context.read<NotificationBloc>().add(
                        NotificationMarkAsRead(notification.id),
                      );
                    }
                    _handleNotificationTap(context, notification);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _handleNotificationTap(BuildContext context, notification) {
    // Handle different notification types
    switch (notification.type) {
      case 'deposit_approved':
      // Navigate to deposit screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => DepositPage()));
        break;
      case 'homework_assigned':
      // Navigate to homework screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeworkPage()));
        break;
    // Add more cases as needed
      default:
        break;
    }
  }
}