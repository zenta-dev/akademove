import 'package:akademove/core/_export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel
  _mainChannel = AndroidNotificationChannel(
    'main_channel',
    'General Notifications',
    description:
        'General app notifications including payments, promotions, and alerts',
    importance: Importance.high,
    enableLights: true,
  );

  bool _initialized = false;
  int _initAttempt = 0;

  Future<NotificationService> init() async {
    if (_initialized) return this;

    try {
      if (_initAttempt > 3) return this;
      _initAttempt++;

      const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings();
      const initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await _plugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTap,
      );

      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_mainChannel);

      _initialized = true;
      return this;
    } catch (e, st) {
      logger.e('❌ NotificationService init failed', error: e, stackTrace: st);
      await init();
      return this;
    }
  }

  // ──────────────────────────────────────────────────────────────
  // Show notifications
  // ──────────────────────────────────────────────────────────────
  Future<void> show({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      await init();
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      await _plugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _mainChannel.id,
            _mainChannel.name,
            channelDescription: _mainChannel.description,
            importance: Importance.high,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(body),
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: data?.toString(),
      );
    } catch (e, st) {
      logger.e('Failed to show notification', error: e, stackTrace: st);
    }
  }

  // Specialized example
  Future<void> showPaymentSuccess({required num amount}) async {
    final formatted = amount.toStringAsFixed(0);
    await show(
      title: 'Top Up Successful',
      body: 'Your top-up of Rp $formatted was successful!',
    );
  }

  // ──────────────────────────────────────────────────────────────
  // Dispose / Cleanup
  // ──────────────────────────────────────────────────────────────
  Future<void> dispose() async {
    try {
      logger.i('🧹 Disposing NotificationService...');
      await _plugin.cancelAll();

      // Android-specific cleanup
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidPlugin != null) {
        await androidPlugin.deleteNotificationChannelGroup('main_channel');
      }

      _initialized = false;
      logger.i('✅ NotificationService disposed cleanly');
    } catch (e, st) {
      logger.e(
        '❌ NotificationService dispose failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  // ──────────────────────────────────────────────────────────────
  // Internal: Handle notification tap
  // ──────────────────────────────────────────────────────────────
  void _onNotificationTap(NotificationResponse response) {
    logger.i('Notification tapped → ${response.payload}');
    // TODO: Add deep-link or navigation handling here
  }
}
