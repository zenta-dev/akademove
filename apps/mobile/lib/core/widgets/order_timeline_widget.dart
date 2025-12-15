import "package:akademove/core/_export.dart";
import "package:api_client/api_client.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:intl/intl.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A widget that displays an order's timeline showing key events
/// with timestamps in a vertical timeline format.
class OrderTimelineWidget extends StatelessWidget {
  const OrderTimelineWidget({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final events = _buildTimelineEvents(context);

    if (events.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Timeline",
              style: context.typography.h4.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(16.h),
            ...events.asMap().entries.map((entry) {
              final index = entry.key;
              final event = entry.value;
              final isLast = index == events.length - 1;
              return _TimelineEventItem(event: event, isLast: isLast);
            }),
          ],
        ),
      ),
    );
  }

  List<_TimelineEvent> _buildTimelineEvents(BuildContext context) {
    final events = <_TimelineEvent>[];

    // Order Requested/Created
    events.add(
      _TimelineEvent(
        title: "Order Requested",
        subtitle: _getOrderTypeLabel(order.type),
        timestamp: order.requestedAt,
        icon: LucideIcons.clipboardList,
        color: const Color(0xFF2196F3),
        isCompleted: true,
      ),
    );

    // Scheduled (if applicable)
    if (order.scheduledAt != null) {
      events.add(
        _TimelineEvent(
          title: "Scheduled For",
          subtitle: "Pickup scheduled",
          timestamp: order.scheduledAt!,
          icon: LucideIcons.calendarClock,
          color: const Color(0xFF00BCD4),
          isCompleted: DateTime.now().isAfter(order.scheduledAt!),
        ),
      );
    }

    // Order Accepted (by driver or merchant)
    if (order.acceptedAt != null) {
      final isFood = order.type == OrderType.FOOD;
      events.add(
        _TimelineEvent(
          title: isFood ? "Merchant Accepted" : "Driver Accepted",
          subtitle: isFood
              ? order.merchant?.name ?? "Merchant accepted your order"
              : order.driver?.user?.name ?? "Driver accepted your order",
          timestamp: order.acceptedAt!,
          icon: LucideIcons.circleCheck,
          color: const Color(0xFF4CAF50),
          isCompleted: true,
        ),
      );
    }

    // Food Preparation Started
    if (order.preparedAt != null && order.type == OrderType.FOOD) {
      events.add(
        _TimelineEvent(
          title: "Preparation Started",
          subtitle: "Merchant started preparing your order",
          timestamp: order.preparedAt!,
          icon: LucideIcons.chefHat,
          color: const Color(0xFFFF9800),
          isCompleted: true,
        ),
      );
    }

    // Food Ready for Pickup
    if (order.readyAt != null && order.type == OrderType.FOOD) {
      events.add(
        _TimelineEvent(
          title: "Ready for Pickup",
          subtitle: "Order is ready for driver pickup",
          timestamp: order.readyAt!,
          icon: LucideIcons.package,
          color: const Color(0xFF8BC34A),
          isCompleted: true,
        ),
      );
    }

    // Driver Arrived at Pickup
    if (order.arrivedAt != null) {
      events.add(
        _TimelineEvent(
          title: "Driver Arrived",
          subtitle: _getArrivedSubtitle(),
          timestamp: order.arrivedAt!,
          icon: LucideIcons.mapPin,
          color: const Color(0xFF9C27B0),
          isCompleted: true,
        ),
      );
    }

    // OTP Verified (for delivery)
    if (order.otpVerifiedAt != null) {
      events.add(
        _TimelineEvent(
          title: "Delivery Verified",
          subtitle: "OTP verified successfully",
          timestamp: order.otpVerifiedAt!,
          icon: LucideIcons.shieldCheck,
          color: const Color(0xFF4CAF50),
          isCompleted: true,
        ),
      );
    }

    // Order Completed
    if (order.status == OrderStatus.COMPLETED) {
      events.add(
        _TimelineEvent(
          title: "Order Completed",
          subtitle: _getCompletedSubtitle(),
          timestamp: order.updatedAt,
          icon: LucideIcons.circleCheckBig,
          color: const Color(0xFF4CAF50),
          isCompleted: true,
        ),
      );
    }

    // Order Cancelled
    if (_isCancelled(order.status)) {
      events.add(
        _TimelineEvent(
          title: "Order Cancelled",
          subtitle: order.cancelReason ?? _getCancelledByText(order.status),
          timestamp: order.updatedAt,
          icon: LucideIcons.circleX,
          color: const Color(0xFFF44336),
          isCompleted: true,
        ),
      );
    }

    return events;
  }

  String _getOrderTypeLabel(OrderType type) {
    switch (type) {
      case OrderType.RIDE:
        return "Ride service requested";
      case OrderType.DELIVERY:
        return "Delivery service requested";
      case OrderType.FOOD:
        return "Food order placed";
    }
  }

  String _getArrivedSubtitle() {
    switch (order.type) {
      case OrderType.RIDE:
        return "Driver arrived at pickup location";
      case OrderType.DELIVERY:
        return "Driver arrived to pick up item";
      case OrderType.FOOD:
        return "Driver arrived at merchant";
    }
  }

  String _getCompletedSubtitle() {
    switch (order.type) {
      case OrderType.RIDE:
        return "Trip completed successfully";
      case OrderType.DELIVERY:
        return "Delivery completed successfully";
      case OrderType.FOOD:
        return "Food delivered successfully";
    }
  }

  bool _isCancelled(OrderStatus status) {
    return status == OrderStatus.CANCELLED_BY_USER ||
        status == OrderStatus.CANCELLED_BY_DRIVER ||
        status == OrderStatus.CANCELLED_BY_MERCHANT ||
        status == OrderStatus.CANCELLED_BY_SYSTEM ||
        status == OrderStatus.NO_SHOW;
  }

  String _getCancelledByText(OrderStatus status) {
    switch (status) {
      case OrderStatus.CANCELLED_BY_USER:
        return "Cancelled by user";
      case OrderStatus.CANCELLED_BY_DRIVER:
        return "Cancelled by driver";
      case OrderStatus.CANCELLED_BY_MERCHANT:
        return "Cancelled by merchant";
      case OrderStatus.CANCELLED_BY_SYSTEM:
        return "Cancelled by system";
      case OrderStatus.NO_SHOW:
        return "Customer no-show";
      default:
        return "Order cancelled";
    }
  }
}

/// Data class for timeline events
class _TimelineEvent {
  const _TimelineEvent({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.icon,
    required this.color,
    required this.isCompleted,
  });

  final String title;
  final String subtitle;
  final DateTime timestamp;
  final IconData icon;
  final Color color;
  final bool isCompleted;
}

/// Widget for individual timeline event
class _TimelineEventItem extends StatelessWidget {
  const _TimelineEventItem({required this.event, required this.isLast});

  final _TimelineEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator column
          SizedBox(
            width: 40.w,
            child: Column(
              children: [
                // Icon circle
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: event.isCompleted
                        ? event.color.withValues(alpha: 0.15)
                        : context.colorScheme.muted,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: event.isCompleted
                          ? event.color
                          : context.colorScheme.mutedForeground,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    event.icon,
                    size: 16.sp,
                    color: event.isCompleted
                        ? event.color
                        : context.colorScheme.mutedForeground,
                  ),
                ),
                // Vertical line connector
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      color: event.isCompleted
                          ? event.color.withValues(alpha: 0.3)
                          : context.colorScheme.muted,
                    ),
                  ),
              ],
            ),
          ),
          Gap(12.w),
          // Event details column
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          event.title,
                          style: context.typography.p.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: event.isCompleted
                                ? context.colorScheme.foreground
                                : context.colorScheme.mutedForeground,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(event.timestamp),
                        style: context.typography.small.copyWith(
                          fontSize: 12.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  Gap(2.h),
                  Text(
                    event.subtitle,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(2.h),
                  Text(
                    _formatDate(event.timestamp),
                    style: context.typography.small.copyWith(
                      fontSize: 11.sp,
                      color: context.colorScheme.mutedForeground.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat("HH:mm").format(dateTime.toLocal());
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat("dd MMM yyyy").format(dateTime.toLocal());
  }
}
