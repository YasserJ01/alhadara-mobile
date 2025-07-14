// // lib/core/services/background_notification_service.dart
// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'notification_service.dart';
// import '../../features/notifications/data/datasources/notification_remote_data_source.dart';
// import '../../features/notifications/data/datasources/notification_local_data_source.dart';
//
// class BackgroundNotificationService {
//   static Future<void> initialize() async {
//     final service = FlutterBackgroundService();
//
//     await service.configure(
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         autoStart: true,
//         isForegroundMode: false,
//         notificationChannelId: 'background_service',
//         initialNotificationTitle: 'App is running in background',
//         initialNotificationContent: 'Listening for notifications',
//         foregroundServiceNotificationId: 888,
//       ),
//       iosConfiguration: IosConfiguration(
//         autoStart: true,
//         onForeground: onStart,
//         onBackground: onIosBackground,
//       ),
//     );
//   }
//
//   static Future<bool> onIosBackground(ServiceInstance service) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     DartPluginRegistrant.ensureInitialized();
//     return true;
//   }
//
//   static void onStart(ServiceInstance service) async {
//     DartPluginRegistrant.ensureInitialized();
//
//     if (service is AndroidServiceInstance) {
//       service.on('setAsForeground').listen((event) {
//         service.setAsForegroundService();
//       });
//
//       service.on('setAsBackground').listen((event) {
//         service.setAsBackgroundService();
//       });
//     }
//
//     service.on('stopService').listen((event) {
//       service.stopSelf();
//     });
//
//     // Initialize notification service
//     await NotificationService.initialize();
//
//     // Initialize shared preferences
//     final sharedPreferences = await SharedPreferences.getInstance();
//
//     // Create data sources
//     final remoteDataSource = NotificationRemoteDataSourceImpl();
//     final localDataSource = NotificationLocalDataSourceImpl(
//       sharedPreferences: sharedPreferences,
//     );
//
//     // Connect to WebSocket and listen for notifications
//     try {
//       final stream = await remoteDataSource.connectToWebSocket();
//
//       stream.listen((notification) async {
//         // Save notification locally
//         await localDataSource.saveNotification(notification);
//
//         // Show local notification
//         await NotificationService.showNotification(notification);
//
//         // Send data to main app if it's running
//         service.invoke('notification_received', {
//           'id': notification.id,
//           'type': notification.type,
//           'title': notification.title,
//           'message': notification.message,
//           'data': notification.data,
//           'created_at': notification.createdAt.toIso8601String(),
//         });
//       });
//
//     } catch (e) {
//       print('Background service error: $e');
//     }
//
//     // Periodic task to maintain connection
//     Timer.periodic(const Duration(minutes: 5), (timer) async {
//       if (service is AndroidServiceInstance) {
//         if (await service.isForegroundService()) {
//           service.setForegroundNotificationInfo(
//             title: "App is running in background",
//             content: "Listening for notifications - ${DateTime.now()}",
//           );
//         }
//       }
//     });
//   }
//
//   static Future<void> startService() async {
//     final service = FlutterBackgroundService();
//     await service.startService();
//   }
//
//   static Future<void> stopService() async {
//     final service = FlutterBackgroundService();
//     service.invoke('stopService');
//   }
// }
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
//TODO : WORKING
// class BackgroundNotificationService {
//   static const _notificationChannelId = 'background_notification_service';
//   static const _notificationChannelName = 'Background Notification Service';
//   static const _notificationChannelDesc = 'Shows notifications when app is in background';
//   static const _notificationId = 888;
//
//   static Future<bool> initialize() async {
//     try {
//       final service = FlutterBackgroundService();
//
//       // Initialize notification channel (Android 8.0+ requirement)
//       if (Platform.isAndroid) {
//         await _createNotificationChannel();
//       }
//
//       await service.configure(
//         androidConfiguration: AndroidConfiguration(
//           onStart: onStart,
//           autoStart: false,
//           isForegroundMode: true,
//           notificationChannelId: _notificationChannelId,
//           initialNotificationTitle: 'Notification Service',
//           initialNotificationContent: 'Initializing...',
//           foregroundServiceNotificationId: _notificationId,
//         ),
//         iosConfiguration: IosConfiguration(
//           autoStart: false,
//           onForeground: onStart,
//           onBackground: onIosBackground,
//         ),
//       );
//
//       return true;
//     } catch (e) {
//       print('Background service initialization error: $e');
//       return false;
//     }
//   }
//
//   static Future<void> _createNotificationChannel() async {
//     if (Platform.isAndroid) {
//       final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//       const androidChannel = AndroidNotificationChannel(
//         _notificationChannelId,
//         _notificationChannelName,
//         description: _notificationChannelDesc,
//         importance: Importance.low,
//       );
//
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(androidChannel);
//     }
//   }
//
//   @pragma('vm:entry-point')
//   static Future<bool> onIosBackground(ServiceInstance service) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     DartPluginRegistrant.ensureInitialized();
//     return true;
//   }
//
//   @pragma('vm:entry-point')
//   static void onStart(ServiceInstance service) async {
//     DartPluginRegistrant.ensureInitialized();
//
//     // Set up foreground notification immediately for Android
//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//         title: "Notification Service",
//         content: "Running in background",
//       );
//     }
//
//     // Initialize minimal services
//     final sharedPreferences = await SharedPreferences.getInstance();
//
//     // Main background task loop
//     Timer.periodic(const Duration(seconds: 30), (timer) async {
//       if (service is AndroidServiceInstance) {
//         service.setForegroundNotificationInfo(
//           title: "Notification Service",
//           content: "Last update: ${DateTime.now().toLocal()}",
//         );
//       }
//
//       // Your notification checking logic here
//       await _checkForNotifications(service);
//     });
//
//     // Handle service control messages
//     service.on('stopService').listen((event) {
//       service.stopSelf();
//     });
//   }
//
//   static Future<void> _checkForNotifications(ServiceInstance service) async {
//     // Implement your notification checking logic here
//   }
//
//   static Future<bool> startService() async {
//     try {
//       final service = FlutterBackgroundService();
//       bool isRunning = await service.isRunning();
//
//       if (!isRunning) {
//         // Ensure notification channel is created before starting
//         if (Platform.isAndroid) {
//           await _createNotificationChannel();
//         }
//
//         return await service.startService();
//       }
//       return true;
//     } catch (e) {
//       print('Start service error: $e');
//       return false;
//     }
//   }
//
//   static Future<void> stopService() async {
//     try {
//       final service = FlutterBackgroundService();
//       if (await service.isRunning()) {
//         service.invoke('stopService');
//       }
//     } catch (e) {
//       print('Stop service error: $e');
//     }
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//TODO : WORKING
class BackgroundNotificationService {
  static const String _channelId = 'high_importance_channel';
  static const String _channelName = 'High Importance Notifications';
  static const String _channelDescription = 'Used for important app notifications';
  static const int _notificationId = 888;

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<bool> initialize() async {
    try {
      // Initialize notifications plugin
      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      await _notificationsPlugin.initialize(
        const InitializationSettings(
          android: initializationSettingsAndroid,
        ),
      );

      // Create notification channel (required for Android 8.0+)
      await _createNotificationChannel();

      final service = FlutterBackgroundService();

      await service.configure(
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: false,
          isForegroundMode: true,
          notificationChannelId: _channelId,
          initialNotificationTitle: 'Notification Service',
          initialNotificationContent: 'Initializing...',
          foregroundServiceNotificationId: _notificationId,
        ),
        iosConfiguration: IosConfiguration(
          autoStart: false,
          onForeground: onStart,
          onBackground: onIosBackground,
        ),
      );

      return true;
    } catch (e) {
      print('Background service initialization error: $e');
      return false;
    }
  }

  static Future<void> _createNotificationChannel() async {
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high, // Changed to high importance
        playSound: true,
        enableVibration: true,
      );

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
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
      service.setForegroundNotificationInfo(
        title: "Notification Service",
        content: "Running in background",
      );
    }

    // Main background task
    Timer.periodic(const Duration(minutes: 15), (timer) async {
      await _checkForNotifications(service);

      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "Notification Service",
          content: "Last check: ${DateTime.now().toLocal()}",
        );
      }
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  }
  static Future<void> stopService() async {
    try {
      final service = FlutterBackgroundService();
      service.invoke('stopService');
    } catch (e) {
      print('Stop service error: $e');
    }
  }

  static Future<void> _checkForNotifications(ServiceInstance service) async {
    try {
      // Implement your actual notification checking logic here
      // For testing, we'll show a sample notification
      await _showTestNotification();
    } catch (e) {
      print('Notification check error: $e');
    }
  }

  static Future<void> _showTestNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Used for important notifications',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification from background service',
      platformChannelSpecifics,
    );
  }

  static Future<bool> startService() async {
    try {
      final service = FlutterBackgroundService();
      bool isRunning = await service.isRunning();

      if (!isRunning) {
        // Request notification permission (Android 13+)
        if (Platform.isAndroid) {
          await _requestNotificationPermission();
        }

        return await service.startService();
      }
      return true;
    } catch (e) {
      print('Start service error: $e');
      return false;
    }
  }

  static Future<bool> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      final bool? result = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      return result ?? false;
    }
    return false;
  }
}

//TODO : WORKING
// class BackgroundNotificationService {
//   static Future<bool> initialize() async {
//     final service = FlutterBackgroundService();
//
//     // Request permissions first
//     bool permissionGranted = await _requestPermissions();
//     if (!permissionGranted) {
//       print('Background service permissions not granted');
//       return false;
//     }
//
//     await service.configure(
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         autoStart: false, // Changed to false to prevent auto-start issues
//         isForegroundMode: true, // Changed to true for better reliability
//         notificationChannelId: 'background_notification_service',
//         initialNotificationTitle: 'Notification Service',
//         initialNotificationContent: 'Monitoring for new notifications',
//         foregroundServiceNotificationId: 888,
//       ),
//       iosConfiguration: IosConfiguration(
//         autoStart: false,
//         onForeground: onStart,
//         onBackground: onIosBackground,
//       ),
//     );
//
//     return true;
//   }
//
//   static Future<bool> _requestPermissions() async {
//     try {
//       // For Android 13+ notification permissions
//       if (Platform.isAndroid) {
//         // You might need to add permission_handler package
//         // and request POST_NOTIFICATIONS permission here
//         return true; // Simplified for now
//       }
//       return true;
//     } catch (e) {
//       print('Permission request error: $e');
//       return false;
//     }
//   }
//
//   @pragma('vm:entry-point')
//   static Future<bool> onIosBackground(ServiceInstance service) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     DartPluginRegistrant.ensureInitialized();
//     return true;
//   }
//
//   @pragma('vm:entry-point')
//   static void onStart(ServiceInstance service) async {
//     // Only initialize what's needed in background
//     DartPluginRegistrant.ensureInitialized();
//
//     if (service is AndroidServiceInstance) {
//       service.on('setAsForeground').listen((event) {
//         service.setAsForegroundService();
//       });
//
//       service.on('setAsBackground').listen((event) {
//         service.setAsBackgroundService();
//       });
//     }
//
//     service.on('stopService').listen((event) {
//       service.stopSelf();
//     });
//
//     // Initialize only essential services in background
//     await _initializeBackgroundServices();
//
//     // Setup notification monitoring
//     await _setupNotificationMonitoring(service);
//
//     // Periodic health check
//     _setupPeriodicTasks(service);
//   }
//
//   static Future<void> _initializeBackgroundServices() async {
//     try {
//       // Initialize only what's needed for background operation
//       final sharedPreferences = await SharedPreferences.getInstance();
//
//       // Initialize lightweight notification service for background
//       // Don't initialize full notification service here to avoid conflicts
//
//     } catch (e) {
//       print('Background service initialization error: $e');
//     }
//   }
//
//   static Future<void> _setupNotificationMonitoring(ServiceInstance service) async {
//     try {
//       // Create minimal data sources for background operation
//       final sharedPreferences = await SharedPreferences.getInstance();
//
//       // Setup WebSocket connection with error handling
//       Timer.periodic(const Duration(seconds: 30), (timer) async {
//         try {
//           // Check for new notifications
//           // This is where you'd implement your notification checking logic
//           // without using the full UI-based services
//
//           // Example: Check API for new notifications
//           await _checkForNotifications(service);
//
//         } catch (e) {
//           print('Notification check error: $e');
//         }
//       });
//
//     } catch (e) {
//       print('Notification monitoring setup error: $e');
//     }
//   }
//
//   static Future<void> _checkForNotifications(ServiceInstance service) async {
//     // Implement lightweight notification checking
//     // This should be a simple HTTP request or minimal WebSocket check
//     // Don't use complex UI-based services here
//   }
//
//   static void _setupPeriodicTasks(ServiceInstance service) {
//     Timer.periodic(const Duration(minutes: 1), (timer) async {
//       if (service is AndroidServiceInstance) {
//         try {
//           if (await service.isForegroundService()) {
//             service.setForegroundNotificationInfo(
//               title: "Notification Service Active",
//               content: "Last check: ${DateTime.now().toString().substring(11, 19)}",
//             );
//           }
//         } catch (e) {
//           print('Periodic task error: $e');
//         }
//       }
//     });
//   }
//
//   static Future<bool> startService() async {
//     try {
//       final service = FlutterBackgroundService();
//       bool isRunning = await service.isRunning();
//
//       if (!isRunning) {
//         return await service.startService();
//       }
//       return true;
//     } catch (e) {
//       print('Start service error: $e');
//       return false;
//     }
//   }
//
//   static Future<void> stopService() async {
//     try {
//       final service = FlutterBackgroundService();
//       service.invoke('stopService');
//     } catch (e) {
//       print('Stop service error: $e');
//     }
//   }
//
//   static Future<bool> isServiceRunning() async {
//     try {
//       final service = FlutterBackgroundService();
//       return await service.isRunning();
//     } catch (e) {
//       print('Check service status error: $e');
//       return false;
//     }
//   }
// }

// Add this import at the top of your file
