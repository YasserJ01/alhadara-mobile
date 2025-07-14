// features/notifications/domain/usecases/listen_to_notifications.dart
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class ListenToNotifications {
  final NotificationRepository repository;

  ListenToNotifications(this.repository);

  Stream<NotificationEntity> call() {
    return repository.notificationStream;
  }
}