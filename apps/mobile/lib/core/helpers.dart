import 'package:api_client/api_client.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void noop() {}

Future<void> delay(Duration duration) async {
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
}

extension IntExt on int {
  Order get dummyOrder {
    final loc = Location(lat: 0, lng: 0);
    final now = DateTime.now();
    return Order(
      id: 'id-$this',
      userId: 'userId-$this',
      type: OrderTypeEnum.delivery,
      status: OrderStatusEnum.requested,
      pickupLocation: loc,
      dropoffLocation: loc,
      distanceKm: 2,
      basePrice: 1000,
      totalPrice: 2000,
      requestedAt: now,
      createdAt: now,
      updatedAt: now,
    );
  }
}

extension DateTimeExt on DateTime {
  String get orderFormat => DateFormat('d MMM, HH:mm').format(this);
}
