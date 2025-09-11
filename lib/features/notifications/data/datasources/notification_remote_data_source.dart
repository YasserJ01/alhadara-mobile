// features/notifications/data/datasources/notification_remote_data_source.dart
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import '../../../../core/services/token_service.dart';
import '../../../../errors/expections.dart';
import '../models/notification_model.dart';
import '../models/websocket_message_model.dart';

abstract class NotificationRemoteDataSource {
  Stream<NotificationModel> get notificationStream;

  Future<void> connect();

  Future<void> disconnect();

  Future<List<NotificationModel>> getNotifications();

  Future<void> markAsRead(int notificationId);

  bool get isConnected;
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  // static const String _baseWsUrl = 'ws://10.0.2.2:8000/ws/notifications/';
  // static const String _baseWsUrl = 'ws://192.168.1.3:8000/ws/notifications/';
  static const String _baseWsUrl = 'wss://optimum-kodiak-hardy.ngrok-free.app/ws/notifications/';

  WebSocketChannel? _channel;
  final StreamController<NotificationModel> _notificationController =
      StreamController<NotificationModel>.broadcast();

  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  bool _isConnected = false;
  bool _shouldReconnect = true;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  static const Duration _reconnectDelay = Duration(seconds: 5);
  static const Duration _heartbeatInterval = Duration(seconds: 30);

  @override
  Stream<NotificationModel> get notificationStream =>
      _notificationController.stream;

  @override
  bool get isConnected => _isConnected;

  @override
  Future<void> connect() async {
    if (_isConnected) return;

    try {
      final token = await TokenService.getAccessToken();
      if (token == null) {
        throw UnauthorizedException('No access token available');
      }

      final uri = Uri.parse('$_baseWsUrl?token=$token');

      _channel = IOWebSocketChannel.connect(
        uri,
        pingInterval: const Duration(seconds: 30),
      );

      _isConnected = true;
      _reconnectAttempts = 0;

      // Start heartbeat
      _startHeartbeat();

      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnect,
        cancelOnError: false,
      );

      print('WebSocket connected successfully');
    } catch (e) {
      print('WebSocket connection failed: $e');
      _isConnected = false;
      _scheduleReconnect();
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();

    if (_channel != null) {
      await _channel!.sink.close();
      _channel = null;
    }

    _isConnected = false;
    print('WebSocket disconnected');
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final wsMessage = WebSocketMessageModel.fromJson(data);

      if (wsMessage.type == 'notification' && wsMessage.notification != null) {
        _notificationController.add(wsMessage.notification!);
      }
    } catch (e) {
      print('Error parsing WebSocket message: $e');
    }
  }

  void _handleError(error) {
    print('WebSocket error: $error');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _handleDisconnect() {
    print('WebSocket disconnected');
    _isConnected = false;
    _heartbeatTimer?.cancel();

    if (_shouldReconnect) {
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (!_shouldReconnect || _reconnectAttempts >= _maxReconnectAttempts) {
      return;
    }

    _reconnectAttempts++;
    print(
        'Scheduling reconnect attempt $_reconnectAttempts in ${_reconnectDelay.inSeconds} seconds');

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(_reconnectDelay, () {
      if (_shouldReconnect) {
        connect().catchError((e) {
          print('Reconnect attempt $_reconnectAttempts failed: $e');
        });
      }
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (timer) {
      if (_isConnected && _channel != null) {
        try {
          _channel!.sink.add(jsonEncode({'type': 'ping'}));
        } catch (e) {
          print('Heartbeat failed: $e');
          _handleError(e);
        }
      }
    });
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    // Implementation for fetching historical notifications via HTTP
    // This would use your existing ApiClient
    throw UnimplementedError(
        'Implement HTTP endpoint for getting notifications');
  }

  @override
  Future<void> markAsRead(int notificationId) async {
    // Implementation for marking notification as read via HTTP
    // This would use your existing ApiClient
    throw UnimplementedError('Implement HTTP endpoint for marking as read');
  }

  void dispose() {
    _notificationController.close();
    disconnect();
  }
}
