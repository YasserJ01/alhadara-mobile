// features/notifications/domain/usecases/mark_notification_as_read.dart
import 'package:dartz/dartz.dart';
import '../../../../errors/failures.dart';
import '../repositories/notification_repository.dart';

class MarkNotificationAsRead {
  final NotificationRepository repository;

  MarkNotificationAsRead(this.repository);

  Future<Either<Failure, void>> call(int notificationId) async {
    return await repository.markAsRead(notificationId);
  }
}