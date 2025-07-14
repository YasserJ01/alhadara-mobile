// features/notifications/domain/repositories/notification_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../errors/failures.dart';
import '../entities/notification.dart';


abstract class NotificationRepository {
  Stream<NotificationEntity> get notificationStream;
  Future<Either<Failure, void>> connect();
  Future<Either<Failure, void>> disconnect();
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
  Future<Either<Failure, void>> markAsRead(int notificationId);
  bool get isConnected;
}