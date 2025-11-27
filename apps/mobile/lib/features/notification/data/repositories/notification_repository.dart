import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository extends BaseRepository {
  const NotificationRepository({
    required ApiClient apiClient,
    required FirebaseService firebaseService,
    required NotificationService notifSvc,
    required KeyValueService keyValueService,
  }) : _apiClient = apiClient,
       _firebaseService = firebaseService,
       _notifSvc = notifSvc,
       _keyValueService = keyValueService;

  final ApiClient _apiClient;
  final FirebaseService _firebaseService;
  final NotificationService _notifSvc;
  final KeyValueService _keyValueService;

  Future<void> syncToken() {
    return guard(() async {
      final [fcmToken, storedFcmToken] = await Future.wait([
        _firebaseService.getToken(),
        _keyValueService.get<String>(KeyValueKeys.fcmToken),
      ]);
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
