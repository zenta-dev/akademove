import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository extends BaseRepository {
  const NotificationRepository({
    required ApiClient apiClient,
    required FirebaseService firebaseService,
  }) : _apiClient = apiClient,
       _firebaseService = firebaseService;

  final ApiClient _apiClient;
  final FirebaseService _firebaseService;

  Future<NotificationSettings> requestPermission() =>
      guard(_firebaseService.requestPermission);

  Future<void> syncToken() {
    return guard(() async {
      await requestPermission();
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
    });
  }

  void onMessage(void Function(RemoteMessage message) handler) {
    _firebaseService.onMessage(handler);
  }
}
