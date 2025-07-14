// features/notifications/data/repositories/notification_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_data_source.dart';
import '../datasources/notification_local_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final NotificationLocalDataSource localDataSource;

  NotificationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<NotificationEntity> get notificationStream =>
      remoteDataSource.notificationStream.map((model) {
        // Cache new notifications locally
        localDataSource.addNotification(model).catchError((e) {
          print('Failed to cache notification: $e');
        });

        return model.toEntity();
      });

  @override
  bool get isConnected => remoteDataSource.isConnected;

  @override
  Future<Either<Failure, void>> connect() async {
    try {
      await remoteDataSource.connect();
      return const Right(null);
    } on UnauthorizedException catch (e) {
      return Left(ServerFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    try {
      await remoteDataSource.disconnect();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      // Try to get from remote first
      try {
        final notifications = await remoteDataSource.getNotifications();
        final entities = notifications.map((model) => model.toEntity()).toList();

        // Cache the results
        await localDataSource.cacheNotifications(notifications);

        return Right(entities);
      } catch (e) {
        // If remote fails, fallback to cached data
        print('Remote fetch failed, using cached data: $e');
        final cachedNotifications = await localDataSource.getCachedNotifications();
        final entities = cachedNotifications.map((model) => model.toEntity()).toList();
        return Right(entities);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(int notificationId) async {
    try {
      // Mark as read locally first for immediate UI update
      await localDataSource.markAsRead(notificationId);

      // Then sync with remote
      try {
        await remoteDataSource.markAsRead(notificationId);
      } catch (e) {
        print('Failed to sync read status with remote: $e');
        // We don't fail the entire operation if remote sync fails
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}