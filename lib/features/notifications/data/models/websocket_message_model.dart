// features/notifications/data/models/websocket_message_model.dart
import 'package:equatable/equatable.dart';

import 'notification_model.dart';

class WebSocketMessageModel extends Equatable {
  final String type;
  final NotificationModel? notification;

  const WebSocketMessageModel({
    required this.type,
    this.notification,
  });

  factory WebSocketMessageModel.fromJson(Map<String, dynamic> json) {
    return WebSocketMessageModel(
      type: json['type'] as String,
      notification: json['notification'] != null
          ? NotificationModel.fromJson(json['notification'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [type, notification];
}