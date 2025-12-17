import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:akademove/l10n/l10n.dart';

/// Active order statuses that should show "View Real Time" button
const _activeOrderStatuses = [
  OrderStatus.REQUESTED,
  OrderStatus.MATCHING,
  OrderStatus.ACCEPTED,
  OrderStatus.PREPARING,
  OrderStatus.READY_FOR_PICKUP,
  OrderStatus.ARRIVING,
  OrderStatus.IN_TRIP,
];

class MerchantOrderCardWidget extends StatelessWidget {
  const MerchantOrderCardWidget({
    required this.order,
    this.onPressed,
    this.onAccept,
    this.onViewRealTime,
    super.key,
  });

  final Order order;
  final void Function()? onPressed;
  final void Function()? onAccept;
  final void Function()? onViewRealTime;

  bool get _isActiveOrder => _activeOrderStatuses.contains(order.status);

  @override
  Widget build(BuildContext context) {
    return Button(
      style: ButtonVariance.ghost.copyWith(
        padding: (context, states, value) => EdgeInsetsGeometry.zero,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            order.user?.name ?? 'Folks',
                            style: context.typography.small.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (order.user?.rating case final rating?
                            when rating > 0) ...[
                          SizedBox(width: 8.w),
                          Icon(
                            LucideIcons.star,
                            size: 14.sp,
                            color: const Color(0xFFFFC107),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            rating.toStringAsFixed(1),
                            style: context.typography.small.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Row(
                    spacing: 4.w,
                    children: [
                      Text(
                        context.l10n.item_count(order.itemCount ?? 0),
                        style: context.typography.textMuted.copyWith(
                          fontSize: 12.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                      Icon(
                        LucideIcons.chevronRight,
                        size: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                order.requestedAt.orderFormat,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp. ${order.totalPrice}',
                    style: context.typography.small.copyWith(fontSize: 14.sp),
                  ),
                  // Show status badge for active orders
                  if (_isActiveOrder)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          order.status,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getStatusLabel(context, order.status),
                        style: context.typography.xSmall.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(order.status),
                        ),
                      ),
                    ),
                ],
              ),
              // Only show accept button for REQUESTED orders when callback is provided
              if (onAccept != null && order.status == OrderStatus.REQUESTED)
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    onPressed: onAccept,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(context.l10n.button_accept),
                        Row(
                          spacing: 4.w,
                          children: [
                            Icon(LucideIcons.clock, size: 16.sp),
                            const Text('01:00'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              // Show "View Real Time" button for active orders
              if (_isActiveOrder && onViewRealTime != null)
                SizedBox(
                  width: double.infinity,
                  child: Button.primary(
                    onPressed: onViewRealTime,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8.w,
                      children: [
                        Icon(LucideIcons.radio, size: 16.sp),
                        Text(context.l10n.view_realtime),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
      case OrderStatus.MATCHING:
        return const Color(0xFFFFA500); // Orange
      case OrderStatus.ACCEPTED:
      case OrderStatus.PREPARING:
        return const Color(0xFF0000FF); // Blue
      case OrderStatus.READY_FOR_PICKUP:
      case OrderStatus.ARRIVING:
      case OrderStatus.IN_TRIP:
        return const Color(0xFF800080); // Purple
      case OrderStatus.COMPLETED:
        return const Color(0xFF008000); // Green
      default:
        return const Color(0xFFFF0000); // Red
    }
  }

  String _getStatusLabel(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return context.l10n.status_requested;
      case OrderStatus.MATCHING:
        return context.l10n.status_matching;
      case OrderStatus.ACCEPTED:
        return context.l10n.status_accepted;
      case OrderStatus.PREPARING:
        return context.l10n.status_preparing;
      case OrderStatus.READY_FOR_PICKUP:
        return context.l10n.status_ready_for_pickup;
      case OrderStatus.ARRIVING:
        return context.l10n.status_arriving;
      case OrderStatus.IN_TRIP:
        return context.l10n.status_in_trip;
      default:
        return status.value;
    }
  }
}
