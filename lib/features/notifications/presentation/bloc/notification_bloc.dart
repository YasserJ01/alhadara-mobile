// features/notifications/presentation/bloc/notification_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/notification.dart';
import '../../domain/usecases/connect_notifications.dart';
import '../../domain/usecases/disconnect_notifications.dart';
import '../../domain/usecases/get_local_notifications.dart';
import '../../domain/usecases/listen_to_notifications.dart';
import '../../domain/usecases/mark_notification_read.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ConnectToNotifications connectToNotifications;
  final DisconnectFromNotifications disconnectFromNotifications;
  final GetNotifications getNotifications;
  final ListenToNotifications listenToNotifications;
  final MarkNotificationAsRead markNotificationAsRead;

  StreamSubscription<NotificationEntity>? _notificationSubscription;
  List<NotificationEntity> _notifications = [];

  NotificationBloc({
    required this.connectToNotifications,
    required this.disconnectFromNotifications,
    required this.getNotifications,
    required this.listenToNotifications,
    required this.markNotificationAsRead,
  }) : super(NotificationInitial()) {
    on<NotificationConnect>(_onConnect);
    on<NotificationDisconnect>(_onDisconnect);
    on<NotificationStartListening>(_onStartListening);
    on<NotificationStopListening>(_onStopListening);
    on<NotificationReceived>(_onNotificationReceived);
    on<NotificationLoadRequested>(_onLoadRequested);
    on<NotificationMarkAsRead>(_onMarkAsRead);
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> _onConnect(NotificationConnect event, Emitter<NotificationState> emit) async {
    emit(NotificationConnecting());

    final result = await connectToNotifications();

    result.fold(
          (failure) => emit(NotificationError('Failed to connect to notifications')),
          (_) {
        emit(NotificationConnected(notifications: _notifications, unreadCount: _unreadCount));
        add(NotificationStartListening());
      },
    );
  }

  Future<void> _onDisconnect(NotificationDisconnect event, Emitter<NotificationState> emit) async {
    _notificationSubscription?.cancel();
    _notificationSubscription = null;

    await disconnectFromNotifications();

    emit(NotificationDisconnected(notifications: _notifications, unreadCount: _unreadCount));
  }

  Future<void> _onStartListening(NotificationStartListening event, Emitter<NotificationState> emit) async {
    _notificationSubscription?.cancel();

    _notificationSubscription = listenToNotifications().listen(
          (notification) {
        add(NotificationReceived(
          id: notification.id,
          type: notification.type,
          title: notification.title,
          message: notification.message,
          data: notification.data,
          createdAt: notification.createdAt,
        ));
      },
      onError: (error) {
        emit(NotificationError('Connection lost: $error'));
      },
    );
  }

  Future<void> _onStopListening(NotificationStopListening event, Emitter<NotificationState> emit) async {
    _notificationSubscription?.cancel();
    _notificationSubscription = null;
  }

  Future<void> _onNotificationReceived(NotificationReceived event, Emitter<NotificationState> emit) async {
    final newNotification = NotificationEntity(
      id: event.id,
      type: event.type,
      title: event.title,
      message: event.message,
      data: event.data,
      createdAt: event.createdAt,
    );

    // Add to the beginning of the list
    _notifications = [newNotification, ..._notifications];

    // Keep only last 100 notifications
    if (_notifications.length > 100) {
      _notifications = _notifications.take(100).toList();
    }

    emit(NotificationNewReceived(
      notification: newNotification,
      allNotifications: _notifications,
      unreadCount: _unreadCount,
    ));
  }

  Future<void> _onLoadRequested(NotificationLoadRequested event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());

    final result = await getNotifications();

    result.fold(
          (failure) => emit(NotificationError('Failed to load notifications')),
          (notifications) {
        _notifications = notifications;
        emit(NotificationLoaded(notifications: notifications, unreadCount: _unreadCount));
      },
    );
  }

  Future<void> _onMarkAsRead(NotificationMarkAsRead event, Emitter<NotificationState> emit) async {
    final result = await markNotificationAsRead(event.notificationId);

    result.fold(
          (failure) => emit(NotificationError('Failed to mark notification as read')),
          (_) {
        // Update local state
        _notifications = _notifications.map((notification) {
          if (notification.id == event.notificationId) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList();

        emit(NotificationLoaded(notifications: _notifications, unreadCount: _unreadCount));
      },
    );
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }
}