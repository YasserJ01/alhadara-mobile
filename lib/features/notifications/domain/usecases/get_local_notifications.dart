// features/notifications/domain/usecases/get_notifications.dart
import 'package:dartz/dartz.dart';

import '../../../../errors/failures.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class GetNotifications {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  Future<Either<Failure, List<NotificationEntity>>> call() async {
    return await repository.getNotifications();
  }
}