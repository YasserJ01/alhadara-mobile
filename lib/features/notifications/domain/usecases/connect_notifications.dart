// features/notifications/domain/usecases/connect_to_notifications.dart
import 'package:dartz/dartz.dart';
import '../../../../errors/failures.dart';
import '../repositories/notification_repository.dart';

class ConnectToNotifications {
  final NotificationRepository repository;

  ConnectToNotifications(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.connect();
  }
}