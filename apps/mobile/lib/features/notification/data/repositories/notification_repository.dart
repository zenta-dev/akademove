import 'package:akademove/core/_export.dart';
import 'package:akademove/features/notification/data/models/notification_models.dart';
import 'package:api_client/api_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const tag = 'NotificationRepository';

class NotificationRepository extends BaseRepository {
  const NotificationRepository({
    required ApiClient apiClient,
    required FirebaseService firebaseService,
    required KeyValueService keyValueService,
  }) : _apiClient = apiClient,
       _firebaseService = firebaseService,
       _keyValueService = keyValueService;

  final ApiClient _apiClient;
  final FirebaseService _firebaseService;
  final KeyValueService _keyValueService;

  /// Sync FCM token with server
  Future<void> syncToken() {
    return guard(() async {
      final [fcmToken, storedFcmToken] = await Future.wait([
        _firebaseService.getToken(),
        _keyValueService.get<String>(KeyValueKeys.fcmToken),
      ]);
      logger
        ..i('[$tag] - FCM Token: $fcmToken')
        ..i('[$tag] - Stored FCM Token: $storedFcmToken');
      if (fcmToken == null) return;
      if (fcmToken == storedFcmToken) return;
      await Future.wait([
        _apiClient.getNotificationApi().notificationSaveToken(
          notificationSaveTokenRequest: NotificationSaveTokenRequest(
            token: fcmToken,
          ),
        ),
        _keyValueService.set<String>(KeyValueKeys.fcmToken, fcmToken),
      ]);

      _firebaseService.onTokenRefresh((token) async {
        if (token.isEmpty) return;
        await _apiClient.getNotificationApi().notificationSaveToken(
          notificationSaveTokenRequest: NotificationSaveTokenRequest(
            token: token,
          ),
        );
      });
    });
  }

  /// Set up message handler for incoming notifications
  void onMessage(void Function(RemoteMessage message) handler) {
    _firebaseService.onMessage(handler);
  }

  /// Get user notifications with pagination
  Future<BaseResponse<NotificationListResponse>> getNotifications({
    int page = 1,
    int limit = 20,
    bool? isRead,
  }) {
    return guard(() async {
      // For now, return mock data since API endpoints may not be implemented yet
      // TODO: Replace with actual API call when endpoints are available
      final mockNotifications = <NotificationModel>[];

      final notificationListResponse = NotificationListResponse(
        notifications: mockNotifications,
        total: 0,
        page: page,
        limit: limit,
      );

      return SuccessResponse(
        message: 'Notifications retrieved successfully',
        data: notificationListResponse,
      );
    });
  }

  /// Mark notification as read
  Future<BaseResponse<void>> markAsRead(String notificationId) {
    return guard(() async {
      // TODO: Replace with actual API call when endpoint is available
      logger.i('[$tag] Marking notification $notificationId as read');

      return const SuccessResponse(
        message: 'Notification marked as read',
        data: null,
      );
    });
  }

  /// Mark all notifications as read
  Future<BaseResponse<void>> markAllAsRead() {
    return guard(() async {
      // TODO: Replace with actual API call when endpoint is available
      logger.i('[$tag] Marking all notifications as read');

      return const SuccessResponse(
        message: 'All notifications marked as read',
        data: null,
      );
    });
  }

  /// Delete notification
  Future<BaseResponse<void>> deleteNotification(String notificationId) {
    return guard(() async {
      // TODO: Replace with actual API call when endpoint is available
      logger.i('[$tag] Deleting notification $notificationId');

      return const SuccessResponse(message: 'Notification deleted', data: null);
    });
  }

  /// Get unread notification count
  Future<BaseResponse<int>> getUnreadCount() {
    return guard(() async {
      // TODO: Replace with actual API call when endpoint is available
      logger.i('[$tag] Getting unread notification count');

      return const SuccessResponse(message: 'Unread count retrieved', data: 0);
    });
  }
}
