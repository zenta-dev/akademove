import 'package:akademove/core/_export.dart';
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

  void onMessage(void Function(RemoteMessage message) handler) {
    _firebaseService.onMessage(handler);
  }
}
