// features/notifications/domain/usecases/disconnect_from_notifications.dart
import 'package:dartz/dartz.dart';
import '../../../../errors/failures.dart';
import '../repositories/notification_repository.dart';

class DisconnectFromNotifications {
  final NotificationRepository repository;

  DisconnectFromNotifications(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.disconnect();
  }
}