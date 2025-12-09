import 'dart:async';

import 'package:akademove/core/utils/_export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  factory FirebaseService() {
    return FirebaseService._(FirebaseMessaging.instance);
  }

  const FirebaseService._(this._fcm);
  final FirebaseMessaging _fcm;

  Future<NotificationSettings> requestPermission() async {
    final settings = await _fcm.requestPermission();

    return settings;
  }

  Future<String?> getToken() async {
    try {
      final token = await _fcm.getToken();
      return token;
    } on Exception catch (e, st) {
      logger.e('Failed to get token', error: e, stackTrace: st);
      return null;
    }
  }

  /// Returns the stream subscription so caller can cancel it when needed
  StreamSubscription<String> onTokenRefresh(void Function(String) handler) {
    return _fcm.onTokenRefresh.listen(handler);
  }

  /// Returns the stream subscription so caller can cancel it when needed
  StreamSubscription<RemoteMessage> onMessage(
    void Function(RemoteMessage message) handler,
  ) {
    return FirebaseMessaging.onMessage.listen(handler);
  }
}
