/// Notification data models for the app
library;

import 'package:api_client/api_client.dart';

/// Notification model representing a user notification
class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.data,
    this.messageId,
    required this.isRead,
    required this.createdAt,
    this.readAt,
  });

  factory NotificationModel.fromDto(UserNotification dto) {
    return NotificationModel(
      id: dto.id,
      userId: dto.userId,
      title: dto.title,
      body: dto.body,
      data: dto.data is Map<String, dynamic>
          ? dto.data as Map<String, dynamic>
          : null,
      messageId: dto.messageId,
      isRead: dto.isRead,
      createdAt: dto.createdAt,
      readAt: dto.readAt,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      data: json['data'] as Map<String, dynamic>?,
      messageId: json['messageId'] as String?,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] != null
          ? DateTime.parse(json['readAt'] as String)
          : null,
    );
  }

  final String id;
  final String userId;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final String? messageId;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'data': data,
      'messageId': messageId,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
    };
  }

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    String? messageId,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      messageId: messageId ?? this.messageId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
    );
  }

  /// Get the notification type from data
  String get type {
    if (data != null) {
      return data!['type'] as String? ?? 'general';
    }
    return 'general';
  }

  /// Get the order ID from data if available
  String? get orderId {
    if (data != null) {
      return data!['orderId'] as String?;
    }
    return null;
  }

  /// Get the target screen from data if available
  String? get screen {
    if (data != null) {
      return data!['screen'] as String?;
    }
    return null;
  }

  /// Get the target route from data if available
  String? get route {
    if (data != null) {
      return data!['route'] as String?;
    }
    return null;
  }
}

/// Response model for notification list API
class NotificationListResponse {
  const NotificationListResponse({
    required this.notifications,
    required this.total,
    required this.page,
    required this.limit,
    this.totalPages = 1,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListResponse(
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int? ?? 1,
    );
  }

  final List<NotificationModel> notifications;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  Map<String, dynamic> toJson() {
    return {
      'notifications': notifications.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }
}
