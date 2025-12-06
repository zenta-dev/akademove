import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension OrderStatusExt on OrderStatus {
  Color get color {
    return switch (this) {
      OrderStatus.REQUESTED => Colors.blue,
      OrderStatus.MATCHING => Colors.indigo,
      OrderStatus.ACCEPTED => Colors.teal,
      OrderStatus.PREPARING => Colors.amber,
      OrderStatus.READY_FOR_PICKUP => Colors.lime,
      OrderStatus.ARRIVING => Colors.yellow,
      OrderStatus.IN_TRIP => Colors.purple,
      OrderStatus.COMPLETED => Colors.green,
      OrderStatus.CANCELLED_BY_USER => Colors.red,
      OrderStatus.CANCELLED_BY_DRIVER => Colors.orange,
      OrderStatus.CANCELLED_BY_MERCHANT => Colors.pink,
      OrderStatus.CANCELLED_BY_SYSTEM => Colors.gray,
      OrderStatus.NO_SHOW => Colors.stone,
    };
  }

  IconData get icon {
    return switch (this) {
      OrderStatus.REQUESTED => LucideIcons.clock,
      OrderStatus.MATCHING => LucideIcons.search,
      OrderStatus.ACCEPTED => LucideIcons.circleCheck,
      OrderStatus.PREPARING => LucideIcons.chefHat,
      OrderStatus.READY_FOR_PICKUP => LucideIcons.packageCheck,
      OrderStatus.ARRIVING => LucideIcons.navigation,
      OrderStatus.IN_TRIP => LucideIcons.car,
      OrderStatus.COMPLETED => LucideIcons.flag,
      OrderStatus.CANCELLED_BY_USER => LucideIcons.userX,
      OrderStatus.CANCELLED_BY_DRIVER => LucideIcons.octagonX,
      OrderStatus.CANCELLED_BY_MERCHANT => LucideIcons.store,
      OrderStatus.CANCELLED_BY_SYSTEM => LucideIcons.triangleAlert,
      OrderStatus.NO_SHOW => LucideIcons.forward,
    };
  }

  String localizedName(BuildContext context) {
    return switch (this) {
      OrderStatus.REQUESTED => context.l10n.requested,
      OrderStatus.MATCHING => context.l10n.matching,
      OrderStatus.ACCEPTED => context.l10n.accepted,
      OrderStatus.PREPARING => context.l10n.preparing,
      OrderStatus.READY_FOR_PICKUP => context.l10n.ready_for_pickup,
      OrderStatus.ARRIVING => context.l10n.arriving,
      OrderStatus.IN_TRIP => context.l10n.in_trip,
      OrderStatus.COMPLETED => context.l10n.completed,
      OrderStatus.CANCELLED_BY_USER => context.l10n.cancelled_by_user,
      OrderStatus.CANCELLED_BY_DRIVER => context.l10n.cancelled_by_driver,
      OrderStatus.CANCELLED_BY_MERCHANT => context.l10n.cancelled_by_merchant,
      OrderStatus.CANCELLED_BY_SYSTEM => context.l10n.cancelled_by_system,
      OrderStatus.NO_SHOW => context.l10n.no_show,
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
