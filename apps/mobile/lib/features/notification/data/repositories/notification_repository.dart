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

  /// Set up handler for notification taps when app was in background
  void onMessageOpenedApp(void Function(RemoteMessage message) handler) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  /// Get initial message if app was opened from a notification tap (terminated state)
  Future<RemoteMessage?> getInitialMessage() {
    return FirebaseMessaging.instance.getInitialMessage();
  }

  /// Remove FCM token from server (call on logout)
  Future<void> removeToken() {
    return guard(() async {
      final fcmToken = await _keyValueService.get<String>(
        KeyValueKeys.fcmToken,
      );
      if (fcmToken == null || fcmToken.isEmpty) return;

      await _apiClient.getNotificationApi().notificationRemoveToken(
        token: fcmToken,
      );
      await _keyValueService.remove(KeyValueKeys.fcmToken);
      logger.i('[$tag] FCM token removed');
    });
  }

  /// Set up message handler for incoming notifications
  void onMessage(void Function(RemoteMessage message) handler) {
    _firebaseService.onMessage(handler);
  }

  /// Get user notifications with pagination
  /// Returns a tuple of (notifications, totalPages)
  Future<BaseResponse<(List<NotificationData>, int)>> getNotifications({
    int page = 1,
    int limit = 20,
    String readFilter = 'all',
  }) {
    return guard(() async {
      logger.i(
        '[$tag] Getting notifications - page: $page, limit: $limit, read: $readFilter',
      );

      final response = await _apiClient.getNotificationApi().notificationList(
        read: readFilter,
        page: page,
        limit: limit,
        mode: PaginationMode.offset,
        order: PaginationOrder.desc,
      );

      final data = response.data;
      if (data == null) {
        throw RepositoryError(
          'Failed to get notifications',
          code: ErrorCode.unknown,
        );
      }

      final totalPages = data.totalPages ?? data.pagination?.totalPages ?? 1;

      return SuccessResponse(
        message: data.message,
        data: (data.data, totalPages),
      );
    });
  }

  /// Mark notification as read
  Future<BaseResponse<NotificationData>> markAsRead(String notificationId) {
    return guard(() async {
      logger.i('[$tag] Marking notification $notificationId as read');

      final response = await _apiClient
          .getNotificationApi()
          .notificationMarkAsRead(id: notificationId);

      final data = response.data;
      if (data == null) {
        throw RepositoryError(
          'Failed to mark notification as read',
          code: ErrorCode.unknown,
        );
      }

      // Convert to NotificationData using extension method
      final notification = data.data.toNotificationData();

      return SuccessResponse(message: data.message, data: notification);
    });
  }

  /// Mark all notifications as read
  Future<BaseResponse<int>> markAllAsRead() {
    return guard(() async {
      logger.i('[$tag] Marking all notifications as read');

      final response = await _apiClient
          .getNotificationApi()
          .notificationMarkAllAsRead();

      final data = response.data;
      if (data == null) {
        throw RepositoryError(
          'Failed to mark all notifications as read',
          code: ErrorCode.unknown,
        );
      }

      final count = data.data.count.toInt();

      return SuccessResponse(message: data.message, data: count);
    });
  }

  /// Delete notification
  Future<BaseResponse<bool>> deleteNotification(String notificationId) {
    return guard(() async {
      logger.i('[$tag] Deleting notification $notificationId');

      final response = await _apiClient.getNotificationApi().notificationDelete(
        id: notificationId,
      );

      final data = response.data;
      if (data == null) {
        throw RepositoryError(
          'Failed to delete notification',
          code: ErrorCode.unknown,
        );
      }

      return SuccessResponse(message: data.message, data: data.data.ok);
    });
  }

  /// Get unread notification count
  Future<BaseResponse<int>> getUnreadCount() {
    return guard(() async {
      logger.i('[$tag] Getting unread notification count');

      final response = await _apiClient
          .getNotificationApi()
          .notificationGetUnreadCount();

      final data = response.data;
      if (data == null) {
        throw RepositoryError(
          'Failed to get unread count',
          code: ErrorCode.unknown,
        );
      }

      return SuccessResponse(
        message: data.message,
        data: data.data.count.toInt(),
      );
    });
  }

  /// Subscribe to a topic for push notifications
  Future<void> subscribeToTopic(String topic) {
    return guard(() async {
      final fcmToken = await _firebaseService.getToken();
      if (fcmToken == null || fcmToken.isEmpty) {
        logger.w('[$tag] Cannot subscribe to topic: FCM token is null');
        return;
      }

      await _apiClient.getNotificationApi().notificationSubscribeToTopic(
        notificationSubscribeToTopicRequest:
            NotificationSubscribeToTopicRequest(topic: topic, token: fcmToken),
      );
      logger.i('[$tag] Subscribed to topic: $topic');
    });
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) {
    return guard(() async {
      final fcmToken = await _firebaseService.getToken();
      if (fcmToken == null || fcmToken.isEmpty) {
        logger.w('[$tag] Cannot unsubscribe from topic: FCM token is null');
        return;
      }

      await _apiClient.getNotificationApi().notificationUnsubscribeToTopic(
        notificationSubscribeToTopicRequest:
            NotificationSubscribeToTopicRequest(topic: topic, token: fcmToken),
      );
      logger.i('[$tag] Unsubscribed from topic: $topic');
    });
  }
}
