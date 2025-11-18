import 'package:api_client/api_client.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension OrderStatusExt on OrderStatus {
  Color get color {
    return switch (this) {
      OrderStatus.requested => Colors.blue,
      OrderStatus.matching => Colors.indigo,
      OrderStatus.accepted => Colors.teal,
      OrderStatus.arriving => Colors.yellow,
      OrderStatus.inTrip => Colors.purple,
      OrderStatus.completed => Colors.green,
      OrderStatus.cancelledByUser => Colors.red,
      OrderStatus.cancelledByDriver => Colors.orange,
      OrderStatus.cancelledBySystem => Colors.gray,
    };
  }

  IconData get icon {
    return switch (this) {
      OrderStatus.requested => LucideIcons.clock,
      OrderStatus.matching => LucideIcons.search,
      OrderStatus.accepted => LucideIcons.circleCheck,
      OrderStatus.arriving => LucideIcons.navigation,
      OrderStatus.inTrip => LucideIcons.car,
      OrderStatus.completed => LucideIcons.flag,
      OrderStatus.cancelledByUser => LucideIcons.userX,
      OrderStatus.cancelledByDriver => LucideIcons.octagonX,
      OrderStatus.cancelledBySystem => LucideIcons.triangleAlert,
    };
  }

  String localizedName(BuildContext context) {
    return switch (this) {
      OrderStatus.requested => 'Requested',
      OrderStatus.matching => 'Matching',
      OrderStatus.accepted => 'Accepted',
      OrderStatus.arriving => 'Arriving',
      OrderStatus.inTrip => 'In Trip',
      OrderStatus.completed => 'Completed',
      OrderStatus.cancelledByUser => 'Cancelled by User',
      OrderStatus.cancelledByDriver => 'Cancelled by Driver',
      OrderStatus.cancelledBySystem => 'Cancelled by System',
    };
  }
}

extension OrderTypeExt on OrderType {
  String localizedName(BuildContext context) {
    return switch (this) {
      OrderType.ride => 'Ride Hailing',
      OrderType.delivery => 'Package Delivery',
      OrderType.food => 'Food Delivery',
    };
  }
}
