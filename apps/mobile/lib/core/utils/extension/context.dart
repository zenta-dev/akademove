import 'dart:math';

import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Typography get typography => theme.typography;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get mediaQuerySize => mediaQuery.size;

  Widget buildToast({required String title, required String message}) {
    return SurfaceCard(
      child: Basic(
        title: Text(title),
        subtitle: Text(message),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  String formatCurrency(num amount, {Locale? locale, String? symbol}) {
    final locale =
        read<AppCubit>().state.locale.data?.value ?? const Locale('id');
    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: symbol ?? 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  Color get randomColor {
    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      Colors.red,
      Colors.blue,
      Colors.green,
    ];

    return colors[Random().nextInt(colors.length)];
  }

  Future<void> ensureLocation() async {
    final svc = sl<LocationService>();

    Future<void> showPermissionDialog() async {
      var isLoading = false;

      await showDialog<bool>(
        context: this,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Location Permission'),
                content: const Text(
                  'This app requires location access to function properly. Please grant location permission.',
                ),
                actions: [
                  OutlineButton(
                    enabled: !isLoading,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  PrimaryButton(
                    enabled: !isLoading,
                    onPressed: () async {
                      setState(() => isLoading = true);
                      final granted = await svc.requestPermission();
                      setState(() => isLoading = false);

                      if (!granted) {
                        showMyToast(
                          'Location permission is required for this feature.',
                          type: ToastType.failed,
                        );
                      } else {
                        showMyToast(
                          'Location permission granted.',
                          type: ToastType.success,
                        );
                      }

                      if (context.mounted) Navigator.of(context).pop(granted);
                    },
                    child: isLoading
                        ? const Submiting(simpleText: true)
                        : const Text('Grant Permission'),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    Future<void> showEnableDialog() async {
      var isLoading = false;

      await showDialog<bool>(
        context: this,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Enable Location Services'),
                content: const Text(
                  'Location services are disabled. Please enable them to continue.',
                ),
                actions: [
                  OutlineButton(
                    enabled: !isLoading,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  PrimaryButton(
                    enabled: !isLoading,
                    onPressed: () async {
                      setState(() => isLoading = true);
                      final enabled = await svc.enable();
                      setState(() => isLoading = false);

                      if (!enabled) {
                        showMyToast(
                          'Location services need to be enabled for this feature.',
                          type: ToastType.failed,
                        );
                      } else {
                        showMyToast(
                          'Location services enabled.',
                          type: ToastType.success,
                        );
                      }

                      if (context.mounted) Navigator.of(context).pop(enabled);
                    },
                    child: isLoading
                        ? const Submiting(simpleText: true)
                        : const Text('Enable'),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    if (!await svc.checkPermission()) await showPermissionDialog();
    if (!await svc.checkEnable()) await showEnableDialog();
  }

  Future<void> ensureNotification() async {
    final ntfSvc = sl<NotificationService>();

    Future<void> showPermissionDialog() async {
      var isLoading = false;

      await showDialog<bool>(
        context: this,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Notification Permission'),
                content: const Text(
                  'This app requires notification access to function properly. Please grant notification permission.',
                ),
                actions: [
                  OutlineButton(
                    enabled: !isLoading,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  PrimaryButton(
                    enabled: !isLoading,
                    onPressed: () async {
                      setState(() => isLoading = true);
                      final granted = await ntfSvc.requestPermission(
                        sl<FirebaseService>(),
                      );
                      setState(() => isLoading = false);

                      if (!granted) {
                        showMyToast(
                          'Notification permission is required for this feature.',
                          type: ToastType.failed,
                        );
                      } else {
                        showMyToast(
                          'Notification permission granted.',
                          type: ToastType.success,
                        );

                        final repo = sl<NotificationRepository>();
                        await safeAsync(() => repo.syncToken());
                      }

                      if (context.mounted) Navigator.of(context).pop(granted);
                    },
                    child: isLoading
                        ? const Submiting(simpleText: true)
                        : const Text('Grant Permission'),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    if (!await ntfSvc.checkPermission()) return showPermissionDialog();

    final repo = sl<NotificationRepository>();
    await safeAsync(() => repo.syncToken());
    repo.onMessage((msg) async {
      logger.i('[NotificationRepository] - onMessage: ${msg.messageId}');
      final title = msg.notification?.title ?? 'Akademove';
      final body = msg.notification?.body ?? '';
      final data = msg.data;

      logger.f('📨 Foreground FCM: ${msg.toMap()}');
      await safeAsync(() => ntfSvc.show(title: title, body: body, data: data));
    });
  }
}
