// features/notifications/data/datasources/notification_local_data_source.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../errors/expections.dart';
import '../models/notification_model.dart';

abstract class NotificationLocalDataSource {
  Future<List<NotificationModel>> getCachedNotifications();
  Future<void> cacheNotifications(List<NotificationModel> notifications);
  Future<void> addNotification(NotificationModel notification);
  Future<void> markAsRead(int notificationId);
  Future<void> clearCache();
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  static const String _cacheKey = 'cached_notifications';
  final SharedPreferences sharedPreferences;

  NotificationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<NotificationModel>> getCachedNotifications() async {
    try {
      final jsonString = sharedPreferences.getString(_cacheKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException('Failed to get cached notifications: $e');
    }
  }

  @override
  Future<void> cacheNotifications(List<NotificationModel> notifications) async {
    try {
      final jsonString = jsonEncode(
        notifications.map((notification) => notification.toJson()).toList(),
      );
      await sharedPreferences.setString(_cacheKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache notifications: $e');
    }
  }

  @override
  Future<void> addNotification(NotificationModel notification) async {
    try {
      final notifications = await getCachedNotifications();
      notifications.insert(0, notification); // Add to beginning

      // Keep only last 100 notifications
      if (notifications.length > 100) {
        notifications.removeRange(100, notifications.length);
      }

      await cacheNotifications(notifications);
    } catch (e) {
      throw CacheException('Failed to add notification: $e');
    }
  }

  @override
  Future<void> markAsRead(int notificationId) async {
    try {
      final notifications = await getCachedNotifications();
      final updatedNotifications = notifications.map((notification) {
        if (notification.id == notificationId) {
          return notification.copyWith(isRead: true);
        }
        return notification;
      }).toList();

      await cacheNotifications(updatedNotifications);
    } catch (e) {
      throw CacheException('Failed to mark notification as read: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(_cacheKey);
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }
}