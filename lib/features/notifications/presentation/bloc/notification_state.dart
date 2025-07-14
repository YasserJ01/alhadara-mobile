// features/notifications/presentation/bloc/notification_state.dart
import 'package:equatable/equatable.dart';

import '../../domain/entities/notification.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationConnecting extends NotificationState {}

class NotificationConnected extends NotificationState {
  final List<NotificationEntity> notifications;
  final int unreadCount;

  const NotificationConnected({
    required this.notifications,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [notifications, unreadCount];
}

class NotificationDisconnected extends NotificationState {
  final List<NotificationEntity> notifications;
  final int unreadCount;

  const NotificationDisconnected({
    required this.notifications,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [notifications, unreadCount];
}

class NotificationNewReceived extends NotificationState {
  final NotificationEntity notification;
  final List<NotificationEntity> allNotifications;
  final int unreadCount;

  const NotificationNewReceived({
    required this.notification,
    required this.allNotifications,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [notification, allNotifications, unreadCount];
}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  final int unreadCount;

  const NotificationLoaded({
    required this.notifications,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [notifications, unreadCount];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}