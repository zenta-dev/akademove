import 'dart:async';
import 'dart:convert';

import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:timezone/timezone.dart' as tz;

void noop() {}

Future<void> delay(
  Duration duration,
) async {
  await Future.delayed(duration, noop);
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Typography get typography => theme.typography;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get mediaQuerySize => mediaQuery.size;

  Widget buildToast({
    required String title,
    required String message,
  }) {
    return SurfaceCard(
      child: Basic(
        title: Text(title),
        subtitle: Text(message),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  String formatCurrency(num amount, {Locale? locale, String? symbol}) {
    final locale = read<AppCubit>().state.data?.locale ?? const Locale('id');
    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: symbol ?? 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
}

enum ToastType {
  info,
  loading,
  success,
  error;

  Color get color {
    return switch (this) {
      ToastType.info => Colors.transparent,
      ToastType.loading => Colors.transparent,
      ToastType.success => Colors.green,
      ToastType.error => Colors.red,
    };
  }

  String title(BuildContext context) {
    return switch (this) {
      ToastType.info => 'Info',
      ToastType.loading => 'Loading',
      ToastType.success => 'Success',
      ToastType.error => 'Error',
    };
  }

  IconData get icon {
    return switch (this) {
      ToastType.info => LucideIcons.info,
      ToastType.loading => LucideIcons.loader,
      ToastType.success => LucideIcons.check,
      ToastType.error => LucideIcons.info,
    };
  }
}

extension ToastExt on BuildContext {
  void showMyToast(
    String? message, {
    ToastType type = ToastType.info,
    Widget? trailing,
  }) => showToast(
    context: this,
    location: ToastLocation.topCenter,
    builder: (context, overlay) {
      final title = type.title(context);
      final subtitle = (type != ToastType.loading && message != null)
          ? Text(
              message,
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            )
          : null;
      return SurfaceCard(
        fillColor: type.color.withValues(),
        borderColor: type.color,
        child: Basic(
          leading: Icon(type.icon, color: type.color),
          title: Text(
            title,
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle,
          trailing: trailing,
          trailingAlignment: Alignment.center,
          leadingAlignment: Alignment.center,
        ),
      );
    },
  );
}

extension IntExt on int {
  Order get dummyOrder {
    final now = DateTime.now();
    return Order(
      id: 'id-$this',
      userId: 'userId-$this',
      type: OrderType.delivery,
      status: OrderStatus.requested,
      pickupLocation: Constants.defaultCoordinate,
      dropoffLocation: Constants.defaultCoordinate,
      distanceKm: 2,
      basePrice: 1000,
      totalPrice: 2000,
      requestedAt: now,
      createdAt: now,
      updatedAt: now,
    );
  }

  Merchant get dummyMerchant {
    final now = DateTime.now();
    return Merchant(
      id: 'id-$this',
      userId: 'userId-$this',
      name: 'Bakso Solo $this',
      email: 'bakso-$this@gmail.com',
      phone: const Phone(countryCode: CountryCode.ID, number: 123456),
      address: 'St. Somewhere',
      isActive: true,
      rating: 1 * this,
      bank: const Bank(provider: BankProviderEnum.BCA, number: 12345),
      categories: ['Drink', 'Coffe', 'Desert', 'Food'],
      image: '${Constants.randomImageUrl}/seed/$this/512/512',
      createdAt: now,
      updatedAt: now,
    );
  }

  Place get dummyPlace {
    return Place(
      name: 'Zenta Dev',
      vicinity: 'St. Boulvard No.80',
      lat: 0,
      lng: 0,
      icon: '${Constants.randomImageUrl}/seed/$this/24/24',
    );
  }
}

extension DateTimeExt on DateTime {
  String get orderFormat => DateFormat('d MMM, HH:mm').format(this);
  String format(String format) {
    final dt = tz.TZDateTime.from(this, tz.local);
    return DateFormat(format).format(dt);
  }
}

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class PageTokenPaginationResult<T> {
  const PageTokenPaginationResult({required this.data, this.token});

  final T data;
  final String? token;
}

extension JsonPrettify on Object {
  String toPrettyJson({int indent = 2}) {
    try {
      final encoder = JsonEncoder.withIndent(' ' * indent);
      return encoder.convert(this);
    } catch (e) {
      return toString();
    }
  }
}

String getMethodName() {
  try {
    throw Exception();
    // ignore: avoid_catches_without_on_clauses this intended like this
  } catch (e, stack) {
    final traceString = stack.toString().split('\n')[1];
    final match = RegExp(
      r'#1\s+[A-Za-z0-9_<>.]+\.(\w+)',
    ).firstMatch(traceString);
    return match?.group(1) ?? 'Unknown';
  }
}

String getClassName() {
  try {
    throw Exception();
  } catch (e, stack) {
    final traceString = stack.toString().split('\n')[1];
    final match = RegExp(r'#1\s+([A-Za-z0-9_<>]+)\.').firstMatch(traceString);
    return match?.group(1) ?? 'Unknown';
  }
}

typedef JSON = Object?; // Can be Map<String, dynamic> or List<dynamic>

extension SafeJsonParsing on String {
  JSON? parseJson() {
    try {
      final result = jsonDecode(this);
      if (result is Map<String, dynamic> || result is List<dynamic>) {
        return result;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
