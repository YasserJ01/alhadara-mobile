// features/notifications/presentation/widgets/notification_badge.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_state.dart';

class NotificationBadge extends StatelessWidget {
  final Widget child;
  final double? badgeSize;
  final Color? badgeColor;

  const NotificationBadge({
    super.key,
    required this.child,
    this.badgeSize = 18,
    this.badgeColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        int unreadCount = 0;

        if (state is NotificationConnected) {
          unreadCount = state.unreadCount;
        } else if (state is NotificationLoaded) {
          unreadCount = state.unreadCount;
        } else if (state is NotificationNewReceived) {
          unreadCount = state.unreadCount;
        } else if (state is NotificationDisconnected) {
          unreadCount = state.unreadCount;
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            if (unreadCount > 0)
              Positioned(
                right: -8,
                top: -8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: badgeSize!,
                    minHeight: badgeSize!,
                  ),
                  child: Text(
                    unreadCount > 99 ? '99+' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
