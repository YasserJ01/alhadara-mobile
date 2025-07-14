// features/notifications/data/models/notification_model.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/notification.dart';

class NotificationModel extends Equatable {
  final int id;
  final String type;
  final String title;
  final String message;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.data,
    required this.createdAt,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      type: json['type'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>? ?? {},
      createdAt: DateTime.parse(json['created_at'] as String),
      isRead: json['is_read'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'message': message,
      'data': data,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
    };
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      type: type,
      title: title,
      message: message,
      data: data,
      createdAt: createdAt,
      isRead: isRead,
    );
  }

  NotificationModel copyWith({
    int? id,
    String? type,
    String? title,
    String? message,
    Map<String, dynamic>? data,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [id, type, title, message, data, createdAt, isRead];
}
