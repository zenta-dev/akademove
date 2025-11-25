import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository extends BaseRepository {
  const NotificationRepository({
    required ApiClient apiClient,
    required FirebaseService firebaseService,
    required NotificationService notifSvc,
  }) : _apiClient = apiClient,
       _firebaseService = firebaseService,
       _notifSvc = notifSvc;

  final ApiClient _apiClient;
  final FirebaseService _firebaseService;
  final NotificationService _notifSvc;

  Future<void> syncToken() {
    return guard(() async {
      final token = await _firebaseService.getToken();
      if (token == null) return;
      await _apiClient.getNotificationApi().notificationSaveToken(
        notificationSaveTokenRequest: NotificationSaveTokenRequest(
          token: token,
        ),
      );

      _firebaseService.onTokenRefresh((token) async {
        if (token.isEmpty) return;
        await _apiClient.getNotificationApi().notificationSaveToken(
          notificationSaveTokenRequest: NotificationSaveTokenRequest(
            token: token,
          ),
        );
      });

      onMessage((msg) async {
        logger.i('[NotificationRepository] - onMessage: ${msg.messageId}');
        final title = msg.notification?.title ?? 'Akademove';
        final body = msg.notification?.body ?? '';
        final data = msg.data;

        logger.f('📨 Foreground FCM: ${msg.toMap()}');
        await _notifSvc.show(title: title, body: body, data: data);
      });
    });
  }

  void onMessage(void Function(RemoteMessage message) handler) {
    _firebaseService.onMessage(handler);
  }
}
