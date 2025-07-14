// features/notifications/presentation/bloc/notification_event.dart
import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationStartListening extends NotificationEvent {}

class NotificationStopListening extends NotificationEvent {}

class NotificationReceived extends NotificationEvent {
  final int id;
  final String type;
  final String title;
  final String message;
  final Map<String, dynamic> data;
  final DateTime createdAt;

  const NotificationReceived({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.data,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, type, title, message, data, createdAt];
}

class NotificationLoadRequested extends NotificationEvent {}

class NotificationMarkAsRead extends NotificationEvent {
  final int notificationId;

  const NotificationMarkAsRead(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

class NotificationConnect extends NotificationEvent {}

class NotificationDisconnect extends NotificationEvent {}
