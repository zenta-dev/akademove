import 'package:akademove/core/_export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  NotificationService();
  static const tag = 'NotificationService';

  final _plugin = FlutterLocalNotificationsPlugin();

  static const _mainChannel = AndroidNotificationChannel(
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

  Future<bool> checkPermission() async {
    logger.i('[$tag] | checkPermission called');
    try {
      if (await _isAndroid13OrHigher()) {
        final status = await Permission.notification.status;
        logger.i('[$tag] | checkPermission → Android 13+, status: $status');
        return status.isGranted;
      } else {
        logger.i('[$tag] | checkPermission → Below Android 13, returning true');
        return true;
      }
    } catch (e, st) {
      logger.e('[$tag] | checkPermission failed', error: e, stackTrace: st);
      return false;
    }
  }

  Future<bool> requestPermission(FirebaseService firebaseService) async {
    logger.i('[$tag] | requestPermission called');
    try {
      await firebaseService.requestPermission();
      logger.i('[$tag] | Firebase permission requested');

      if (await _isAndroid13OrHigher()) {
        logger.i('[$tag] | Android 13+, requesting notification permission');
        final status = await Permission.notification.request();
        logger.i('[$tag] | Permission status: $status');

        if (status.isGranted) {
          logger.i('[$tag] | Permission granted');
          return true;
        } else if (status.isDenied) {
          logger.w('[$tag] | Permission denied');
          return false;
        } else if (status.isPermanentlyDenied) {
          logger.w('[$tag] | Permission permanently denied, opening settings');
          await openAppSettings();
          return false;
        }
        return false;
      } else {
        logger.i('[$tag] | Below Android 13, permission not required');
        return true;
      }
    } catch (e, st) {
      logger.e('[$tag] | requestPermission failed', error: e, stackTrace: st);
      return false;
    }
  }

  Future<bool> _isAndroid13OrHigher() async {
    try {
      final result =
          await Permission.notification.shouldShowRequestRationale == false &&
          await Permission.notification.status == PermissionStatus.denied;
      logger.i('[$tag] | _isAndroid13OrHigher → $result');
      return result;
    } catch (e, st) {
      logger.e(
        '[$tag] | _isAndroid13OrHigher failed',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }
}
