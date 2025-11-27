import 'package:api_client/api_client.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension OrderStatusExt on OrderStatus {
  Color get color {
    return switch (this) {
      OrderStatus.REQUESTED => Colors.blue,
      OrderStatus.MATCHING => Colors.indigo,
      OrderStatus.ACCEPTED => Colors.teal,
      OrderStatus.ARRIVING => Colors.yellow,
      OrderStatus.IN_TRIP => Colors.purple,
      OrderStatus.COMPLETED => Colors.green,
      OrderStatus.CANCELLED_BY_USER => Colors.red,
      OrderStatus.CANCELLED_BY_DRIVER => Colors.orange,
      OrderStatus.CANCELLED_BY_SYSTEM => Colors.gray,
    };
  }

  IconData get icon {
    return switch (this) {
      OrderStatus.REQUESTED => LucideIcons.clock,
      OrderStatus.MATCHING => LucideIcons.search,
      OrderStatus.ACCEPTED => LucideIcons.circleCheck,
      OrderStatus.ARRIVING => LucideIcons.navigation,
      OrderStatus.IN_TRIP => LucideIcons.car,
      OrderStatus.COMPLETED => LucideIcons.flag,
      OrderStatus.CANCELLED_BY_USER => LucideIcons.userX,
      OrderStatus.CANCELLED_BY_DRIVER => LucideIcons.octagonX,
      OrderStatus.CANCELLED_BY_SYSTEM => LucideIcons.triangleAlert,
    };
  }

  String localizedName(BuildContext context) {
    return switch (this) {
      OrderStatus.REQUESTED => 'Requested',
      OrderStatus.MATCHING => 'Matching',
      OrderStatus.ACCEPTED => 'Accepted',
      OrderStatus.ARRIVING => 'Arriving',
      OrderStatus.IN_TRIP => 'In Trip',
      OrderStatus.COMPLETED => 'Completed',
      OrderStatus.CANCELLED_BY_USER => 'Cancelled by User',
      OrderStatus.CANCELLED_BY_DRIVER => 'Cancelled by Driver',
      OrderStatus.CANCELLED_BY_SYSTEM => 'Cancelled by System',
    };
  }
}

extension OrderTypeExt on OrderType {
  String localizedName(BuildContext context) {
    return switch (this) {
      OrderType.RIDE => 'Ride Hailing',
      OrderType.DELIVERY => 'Package Delivery',
      OrderType.FOOD => 'Food Delivery',
    };
  }
}
