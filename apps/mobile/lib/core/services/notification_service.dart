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
  // Handle deep link from FCM message data
  // ──────────────────────────────────────────────────────────────
  /// Handle deep link navigation from FCM message data.
  /// Use this for onMessageOpenedApp and getInitialMessage handlers.
  void handleMessageData(Map<String, dynamic> data) {
    logger.i('[$tag] Handling FCM message data: $data');
    _handleDeepLink(data);
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
    final deeplink = data['deeplink'] as String?;
    final orderId = data['orderId'] as String?;
    final type = data['type'] as String?;
    final screen = data['screen'] as String?;
    final route = data['route'] as String?;
    final badgeId = data['badgeId'] as String?;

    logger.i(
      'Deep link data: deeplink=$deeplink, orderId=$orderId, type=$type, screen=$screen, route=$route',
    );

    // Priority 1: Parse akademove:// deep link if provided
    if (deeplink != null && deeplink.startsWith('akademove://')) {
      final handled = _handleAkadeMoveDeepLink(deeplink, data);
      if (handled) return;
    }

    // Priority 2: Use explicit route if provided
    if (route != null && route.isNotEmpty) {
      router.push(route);
      return;
    }

    // Priority 3: Navigate based on screen parameter
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

    // Priority 4: Navigate based on orderId
    if (orderId != null && orderId.isNotEmpty) {
      router.pushNamed(
        Routes.userHistoryDetail.name,
        pathParameters: {'orderId': orderId},
      );
      return;
    }

    // Priority 5: Navigate based on badgeId
    if (badgeId != null && badgeId.isNotEmpty) {
      // TODO: Add badge detail route when available
      router.pushNamed(Routes.driverLeaderboard.name);
      return;
    }

    // Priority 6: Navigate based on notification type
    if (type != null) {
      final handled = _handleNotificationType(type, data);
      if (handled) return;
    }

    // Fallback: Navigate to home
    logger.i('No specific navigation target, navigating to home');
    router.pushNamed(Routes.userHome.name);
  }

  /// Handle akademove:// deep link URLs
  /// Returns true if the deep link was handled
  bool _handleAkadeMoveDeepLink(String deeplink, Map<String, dynamic> data) {
    try {
      final uri = Uri.parse(deeplink);
      final host = uri.host;
      final pathSegments = uri.pathSegments;

      logger.i('Parsing deeplink: host=$host, path=$pathSegments');

      switch (host) {
        // User routes
        case 'order':
          final orderId = pathSegments.isNotEmpty
              ? pathSegments[0]
              : data['orderId'] as String?;
          // Check if this is a rating deep link: akademove://order/{orderId}/rate
          final isRating = pathSegments.length > 1 && pathSegments[1] == 'rate';
          if (orderId != null && orderId.isNotEmpty) {
            router.pushNamed(
              Routes.userHistoryDetail.name,
              pathParameters: {'orderId': orderId},
              extra: isRating ? {'action': 'rate'} : null,
            );
            return true;
          }
          router.pushNamed(Routes.userHistory.name);
          return true;

        case 'wallet':
          router.pushNamed(Routes.userWallet.name);
          return true;

        case 'home':
          router.pushNamed(Routes.userHome.name);
          return true;

        case 'history':
          router.pushNamed(Routes.userHistory.name);
          return true;

        case 'voucher':
          router.pushNamed(Routes.userVoucher.name);
          return true;

        case 'notifications':
          router.pushNamed(Routes.userNotifications.name);
          return true;

        // Driver routes
        case 'driver':
          return _handleDriverDeepLink(pathSegments, data);

        // Merchant routes
        case 'merchant':
          return _handleMerchantDeepLink(pathSegments, data);

        // Shared routes
        case 'contact-support':
        case 'support':
          router.pushNamed(Routes.faq.name);
          return true;

        default:
          logger.w('Unknown deeplink host: $host');
          return false;
      }
    } catch (e, st) {
      logger.e('Failed to parse deeplink: $deeplink', error: e, stackTrace: st);
      return false;
    }
  }

  /// Handle driver-specific deep links
  /// akademove://driver/order/{orderId}
  /// akademove://driver/home
  /// akademove://driver/earnings
  /// akademove://driver/badges/{badgeId}
  /// akademove://driver/leaderboard
  /// akademove://driver/notifications
  bool _handleDriverDeepLink(
    List<String> pathSegments,
    Map<String, dynamic> data,
  ) {
    if (pathSegments.isEmpty) {
      router.pushNamed(Routes.driverHome.name);
      return true;
    }

    final segment = pathSegments[0];
    switch (segment) {
      case 'home':
        router.pushNamed(Routes.driverHome.name);
        return true;

      case 'order':
        final orderId = pathSegments.length > 1
            ? pathSegments[1]
            : data['orderId'] as String?;
        if (orderId != null && orderId.isNotEmpty) {
          router.pushNamed(
            Routes.driverOrderDetail.name,
            pathParameters: {'orderId': orderId},
          );
          return true;
        }
        router.pushNamed(Routes.driverHistory.name);
        return true;

      case 'earnings':
        router.pushNamed(Routes.driverEarnings.name);
        return true;

      case 'badges':
      case 'leaderboard':
        // Badge detail could use badgeId from path or data
        // final badgeId = pathSegments.length > 1
        //     ? pathSegments[1]
        //     : data['badgeId'] as String?;
        router.pushNamed(Routes.driverLeaderboard.name);
        return true;

      case 'history':
        router.pushNamed(Routes.driverHistory.name);
        return true;

      case 'reviews':
        router.pushNamed(Routes.driverReviews.name);
        return true;

      case 'profile':
        router.pushNamed(Routes.driverProfile.name);
        return true;

      case 'notifications':
        router.pushNamed(Routes.driverNotifications.name);
        return true;

      default:
        logger.w('Unknown driver path segment: $segment');
        router.pushNamed(Routes.driverHome.name);
        return true;
    }
  }

  /// Handle merchant-specific deep links
  /// akademove://merchant/order
  /// akademove://merchant/home
  /// akademove://merchant/notifications
  bool _handleMerchantDeepLink(
    List<String> pathSegments,
    Map<String, dynamic> data,
  ) {
    if (pathSegments.isEmpty) {
      router.pushNamed(Routes.merchantHome.name);
      return true;
    }

    final segment = pathSegments[0];
    switch (segment) {
      case 'home':
        router.pushNamed(Routes.merchantHome.name);
        return true;

      case 'order':
      case 'orders':
        router.pushNamed(Routes.merchantOrder.name);
        return true;

      case 'menu':
        router.pushNamed(Routes.merchantMenu.name);
        return true;

      case 'profile':
        router.pushNamed(Routes.merchantProfile.name);
        return true;

      case 'notifications':
        router.pushNamed(Routes.merchantNotifications.name);
        return true;

      default:
        logger.w('Unknown merchant path segment: $segment');
        router.pushNamed(Routes.merchantHome.name);
        return true;
    }
  }

  /// Handle notification type-based navigation
  /// Returns true if the type was handled
  bool _handleNotificationType(String type, Map<String, dynamic> data) {
    switch (type.toLowerCase()) {
      // Order-related types
      case 'new_order':
        // For drivers/merchants, this should go to their order screens
        // The deeplink should handle this, but fallback to history
        router.pushNamed(Routes.userHistory.name);
        return true;

      case 'order':
      case 'order_update':
      case 'order_completed':
      case 'order_cancelled':
      case 'no_show':
      case 'scheduled_order_matching':
      case 'scheduled_order_reminder':
        final orderId = data['orderId'] as String?;
        if (orderId != null && orderId.isNotEmpty) {
          router.pushNamed(
            Routes.userHistoryDetail.name,
            pathParameters: {'orderId': orderId},
          );
        } else {
          router.pushNamed(Routes.userHistory.name);
        }
        return true;

      // Payment/Wallet-related types
      case 'payment':
      case 'payment_success':
      case 'payment_failed':
      case 'topup':
      case 'topup_success':
      case 'topup_failed':
      case 'wallet':
      case 'refund_processed':
      case 'withdrawal_success':
      case 'withdrawal_failed':
        router.pushNamed(Routes.userWallet.name);
        return true;

      // Driver-specific types
      case 'driver_approved':
        router.pushNamed(Routes.driverHome.name);
        return true;

      case 'driver_declined':
        router.pushNamed(Routes.faq.name);
        return true;

      case 'badge_earned':
        router.pushNamed(Routes.driverLeaderboard.name);
        return true;

      // Promo types
      case 'promo':
      case 'coupon':
      case 'broadcast':
        router.pushNamed(Routes.userVoucher.name);
        return true;

      default:
        logger.w('Unknown notification type: $type');
        return false;
    }
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
