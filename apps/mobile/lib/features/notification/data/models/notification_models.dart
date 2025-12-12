import 'package:api_client/api_client.dart';

/// Type alias for notification data
typedef NotificationData = NotificationList200ResponseDataInner;

/// Extension to add helper methods to notification data
extension NotificationDataExtension on NotificationList200ResponseDataInner {
  /// Get notification type from data field
  String get type {
    if (data == null) return 'general';
    if (data is Map<String, dynamic>) {
      final dataMap = data as Map<String, dynamic>;
      return (dataMap['type'] as String?) ?? 'general';
    }
    return 'general';
  }

  /// Get navigation route from data field
  String? get route {
    if (data == null) return null;
    if (data is Map<String, dynamic>) {
      final dataMap = data as Map<String, dynamic>;
      return dataMap['route'] as String?;
    }
    return null;
  }

  /// Create a copy with updated read status
  NotificationList200ResponseDataInner copyWithUpdated({
    bool? isRead,
    DateTime? readAt,
  }) {
    return copyWith(
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
    );
  }
}

/// Extension to add helper methods to mark as read response
extension NotificationMarkAsReadDataExtension
    on NotificationMarkAsRead200ResponseData {
  /// Convert response data to NotificationData
  NotificationData toNotificationData() {
    return NotificationList200ResponseDataInner(
      id: id,
      userId: userId,
      title: title,
      body: body,
      data: data,
      messageId: messageId,
      isRead: isRead,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}
