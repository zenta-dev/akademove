import 'dart:convert';

import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

enum _OperationType { check, request }

enum _OperationStatus { active }

class NotificationService {
  NotificationService();
  static const tag = 'NotificationService';
  final ops = <_OperationType, _OperationStatus>{};

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
        payload: data != null ? jsonEncode(data) : null,
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

    final payload = response.payload;
    if (payload == null || payload.isEmpty) {
      logger.w('Empty notification payload, no navigation');
      return;
    }

    try {
      // Parse payload as JSON (sent from backend as data field)
      final data = jsonDecode(payload) as Map<String, dynamic>;
      _handleDeepLink(data);
    } catch (e, st) {
      logger.e(
        'Failed to parse notification payload',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _handleDeepLink(Map<String, dynamic> data) {
    // Extract common navigation parameters from notification data
    final orderId = data['orderId'] as String?;
    final type = data['type'] as String?;
    final screen = data['screen'] as String?;
    final route = data['route'] as String?;

    logger.i(
      'Deep link data: orderId=$orderId, type=$type, screen=$screen, route=$route',
    );

    // Priority 1: Use explicit route if provided
    if (route != null && route.isNotEmpty) {
      router.push(route);
      return;
    }

    // Priority 2: Navigate based on screen parameter
    if (screen != null) {
      switch (screen.toLowerCase()) {
        case 'wallet':
          router.pushNamed(Routes.userWallet.name);
        case 'orders':
        case 'history':
          router.pushNamed(Routes.userHistory.name);
        case 'profile':
          router.pushNamed(Routes.userProfile.name);
        case 'home':
          router.pushNamed(Routes.userHome.name);
        default:
          logger.w('Unknown screen: $screen');
      }
      return;
    }

    // Priority 3: Navigate based on orderId
    if (orderId != null && orderId.isNotEmpty) {
      // Navigate to order detail screen
      // Use history detail route which works for all user types
      router.pushNamed(
        Routes.userHistoryDetail.name,
        pathParameters: {'orderId': orderId},
      );
      return;
    }

    // Priority 4: Navigate based on notification type
    if (type != null) {
      switch (type.toLowerCase()) {
        case 'order':
        case 'order_update':
        case 'order_completed':
        case 'order_cancelled':
          router.pushNamed(Routes.userHistory.name);
        case 'payment':
        case 'topup':
        case 'wallet':
          router.pushNamed(Routes.userWallet.name);
        case 'promo':
        case 'coupon':
          router.pushNamed(Routes.userVoucher.name);
        default:
          // Default to home if type is unknown
          logger.w('Unknown notification type: $type, navigating to home');
          router.pushNamed(Routes.userHome.name);
      }
      return;
    }

    // Fallback: Navigate to home
    logger.i('No specific navigation target, navigating to home');
    router.pushNamed(Routes.userHome.name);
  }

  Future<bool> checkPermission() async {
    logger.i('[$tag] | checkPermission called');
    try {
      if (ops[_OperationType.check] == _OperationStatus.active) {
        logger.i(
          '[$tag] | checkPermission → operation already active, returning false',
        );
        return false;
      }
      ops[_OperationType.check] = _OperationStatus.active;
      if (await _isAndroid13OrHigher()) {
        final status = await Permission.notification.status;
        logger.i('[$tag] | checkPermission → Android 13+, status: $status');
        ops.remove(_OperationType.check);
        return status.isGranted;
      } else {
        logger.i('[$tag] | checkPermission → Below Android 13, returning true');
        ops.remove(_OperationType.check);
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
      if (ops[_OperationType.request] == _OperationStatus.active) {
        logger.i(
          '[$tag] | requestPermission → operation already active, returning false',
        );
        return false;
      }
      ops[_OperationType.request] = _OperationStatus.active;

      await safeAsync(firebaseService.requestPermission);
      logger.i('[$tag] | Firebase permission requested');

      if (await _isAndroid13OrHigher()) {
        logger.i('[$tag] | Android 13+, requesting notification permission');
        final status = await Permission.notification.request();
        logger.i('[$tag] | Permission status: $status');
        ops.remove(_OperationType.request);

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
