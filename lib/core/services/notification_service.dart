// core/services/notification_service.dart
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/notifications/data/datasources/notification_remote_data_source.dart';
import '../../features/notifications/data/datasources/notification_local_data_source.dart';
import '../../features/notifications/data/repositories/notification_repository_impl.dart';
import '../../features/notifications/domain/usecases/connect_notifications.dart';
import '../../features/notifications/domain/usecases/listen_to_notifications.dart';

class NotificationService {
  static const String _channelId = 'app_notifications';
  static const String _channelName = 'App Notifications';
  static const String _channelDescription = 'Notifications from the app';

  static FlutterLocalNotificationsPlugin? _localNotifications;
  static StreamSubscription? _notificationSubscription;

  static Future<void> initialize() async {
    await _initializeLocalNotifications();
    await _initializeBackgroundService();
  }

  static Future<void> _initializeLocalNotifications() async {
    _localNotifications = FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications!.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channel for Android
    const androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      playSound: true,
    );

    await _localNotifications!
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  static Future<void> _initializeBackgroundService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: false,
        notificationChannelId: _channelId,
        initialNotificationTitle: 'App Running',
        initialNotificationContent: 'Listening for notifications',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // Initialize background notification listening
    await _startBackgroundNotificationListening(service);
  }

  static Future<void> _startBackgroundNotificationListening(ServiceInstance service) async {
    try {
      // Initialize SharedPreferences
      final sharedPreferences = await SharedPreferences.getInstance();

      // Create data sources
      final remoteDataSource = NotificationRemoteDataSourceImpl();
      final localDataSource = NotificationLocalDataSourceImpl(
        sharedPreferences: sharedPreferences,
      );

      // Create repository
      final repository = NotificationRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
      );

      // Create use cases
      final connectToNotifications = ConnectToNotifications(repository);
      final listenToNotifications = ListenToNotifications(repository);

      // Connect to WebSocket
      final connectResult = await connectToNotifications();

      connectResult.fold(
            (failure) {
          print('Background service: Failed to connect to notifications');
          return;
        },
            (_) {
          print('Background service: Connected to notifications');

          // Listen to notifications
          _notificationSubscription = listenToNotifications().listen(
                (notification) {
              _showLocalNotification(notification);

              // Send data to foreground if needed
              service.invoke('notification_received', {
                'id': notification.id,
                'type': notification.type,
                'title': notification.title,
                'message': notification.message,
                'data': notification.data,
                'created_at': notification.createdAt.toIso8601String(),
              });
            },
            onError: (error) {
              print('Background service: Notification stream error: $error');
            },
          );
        },
      );

      // Keep the service alive
      Timer.periodic(const Duration(seconds: 30), (timer) async {
        if (service is AndroidServiceInstance) {
          if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
        title: "App Running",
        content: "Listening for notifications - ${DateTime.now()}",
        );
        }
        }
        print('Background service heartbeat: ${DateTime.now()}');
      });

    } catch (e) {
      print('Background service error: $e');
    }
  }

  static Future<void> _showLocalNotification(dynamic notification) async {
    if (_localNotifications == null) {
      await _initializeLocalNotifications();
    }

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      autoCancel: true,
      fullScreenIntent: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications!.show(
      notification.id,
      notification.title,
      notification.message,
      notificationDetails,
      payload: notification.type,
    );
  }

  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');

    // You can use a global navigator key or event bus to navigate
    // when the app is opened from a notification
  }

  static Future<void> startService() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();

    if (!isRunning) {
      await service.startService();
    }
  }

  static Future<void> stopService() async {
    final service = FlutterBackgroundService();
    service.invoke('stopService');
  }

  static Future<void> requestPermissions() async {
    if (_localNotifications == null) {
      await _initializeLocalNotifications();
    }

    // Request notification permissions
    await _localNotifications!
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _localNotifications!
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}