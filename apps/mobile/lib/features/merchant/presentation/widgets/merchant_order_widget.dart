import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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
            spacing: 12.h,
            children: [
              // Header: Customer name, rating, and status badge
              _buildHeader(context),
              // Order items preview
              _buildOrderItemsPreview(context),
              // Delivery address
              _buildDeliveryAddress(context),
              const Divider(),
              // Footer: Price, item count, and time
              _buildFooter(context),
              // Action buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Customer info
        Expanded(
          child: Row(
            children: [
              // Order type icon
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  LucideIcons.utensils,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            order.user?.name ?? 'Customer',
                            style: context.typography.small.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (order.user?.rating case final rating?
                            when rating > 0) ...[
                          SizedBox(width: 6.w),
                          Icon(
                            LucideIcons.star,
                            size: 12.sp,
                            color: const Color(0xFFFFC107),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            rating.toStringAsFixed(1),
                            style: context.typography.small.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.mutedForeground,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'F-${order.id.prefix(8)}',
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Status badge
        _buildStatusBadge(context),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final statusColor = _getStatusColor(order.status);
    final isLoading =
        order.status == OrderStatus.REQUESTED ||
        order.status == OrderStatus.MATCHING ||
        order.status == OrderStatus.PREPARING;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          if (isLoading)
            SizedBox(
              width: 10.w,
              height: 10.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: statusColor,
              ),
            )
          else
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
          Text(
            _getStatusLabel(context, order.status),
            style: context.typography.xSmall.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsPreview(BuildContext context) {
    final items = order.items ?? [];
    if (items.isEmpty) {
      return Row(
        spacing: 8.w,
        children: [
          Icon(
            LucideIcons.shoppingBag,
            size: 14.sp,
            color: context.colorScheme.mutedForeground,
          ),
          Text(
            context.l10n.item_count(order.itemCount ?? 0),
            style: context.typography.small.copyWith(
              fontSize: 13.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
        ],
      );
    }

    // Show first 2 items with "and X more" if there are more
    final displayItems = items.take(2).toList();
    final remainingCount = items.length - displayItems.length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: context.colorScheme.muted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6.h,
        children: [
          ...displayItems.map((orderItem) {
            final item = orderItem.item;
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '${orderItem.quantity}x',
                    style: context.typography.xSmall.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    item.name ?? context.l10n.unknown_item,
                    style: context.typography.small.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  context.formatCurrency(item.price ?? 0),
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            );
          }),
          if (remainingCount > 0)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                '+$remainingCount ${remainingCount == 1 ? 'more item' : 'more items'}',
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress(BuildContext context) {
    final address = order.dropoffAddress;
    if (address == null || address.isEmpty) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          LucideIcons.mapPin,
          size: 14.sp,
          color: context.colorScheme.destructive,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            address,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Total price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.total,
              style: context.typography.xSmall.copyWith(
                fontSize: 10.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
            Text(
              context.formatCurrency(order.totalPrice),
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: context.colorScheme.primary,
              ),
            ),
          ],
        ),
        // Time and item count
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              spacing: 4.w,
              children: [
                Icon(
                  LucideIcons.clock,
                  size: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Text(
                  order.requestedAt.orderFormat,
                  style: context.typography.small.copyWith(
                    fontSize: 11.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              spacing: 4.w,
              children: [
                Icon(
                  LucideIcons.package,
                  size: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Text(
                  context.l10n.item_count(order.itemCount ?? 0),
                  style: context.typography.small.copyWith(
                    fontSize: 11.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final hasAcceptButton =
        onAccept != null && order.status == OrderStatus.REQUESTED;
    final hasViewRealTimeButton = _isActiveOrder && onViewRealTime != null;

    if (!hasAcceptButton && !hasViewRealTimeButton) {
      return const SizedBox.shrink();
    }

    return Column(
      spacing: 8.h,
      children: [
        // Accept button for REQUESTED orders
        if (hasAcceptButton)
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPressed: onAccept,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8.w,
                children: [
                  Icon(LucideIcons.check, size: 16.sp),
                  Text(context.l10n.button_accept),
                ],
              ),
            ),
          ),
        // View Real Time button for active orders
        if (hasViewRealTimeButton)
          SizedBox(
            width: double.infinity,
            child: Button.outline(
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
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return const Color(0xFFFF9800); // Orange
      case OrderStatus.MATCHING:
        return const Color(0xFF2196F3); // Blue
      case OrderStatus.ACCEPTED:
        return const Color(0xFF4CAF50); // Green
      case OrderStatus.PREPARING:
        return const Color(0xFFFF9800); // Orange
      case OrderStatus.READY_FOR_PICKUP:
        return const Color(0xFF4CAF50); // Green
      case OrderStatus.ARRIVING:
        return const Color(0xFF2196F3); // Blue
      case OrderStatus.IN_TRIP:
        return const Color(0xFF9C27B0); // Purple
      case OrderStatus.COMPLETED:
        return const Color(0xFF4CAF50); // Green
      case OrderStatus.CANCELLED_BY_USER:
      case OrderStatus.CANCELLED_BY_DRIVER:
      case OrderStatus.CANCELLED_BY_MERCHANT:
      case OrderStatus.CANCELLED_BY_SYSTEM:
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFF9E9E9E); // Grey
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
      case OrderStatus.COMPLETED:
        return context.l10n.completed;
      case OrderStatus.CANCELLED_BY_USER:
        return context.l10n.cancelled_by_user;
      case OrderStatus.CANCELLED_BY_DRIVER:
        return context.l10n.cancelled_by_driver;
      case OrderStatus.CANCELLED_BY_MERCHANT:
        return context.l10n.cancelled_by_merchant;
      case OrderStatus.CANCELLED_BY_SYSTEM:
        return context.l10n.cancelled_by_system;
      default:
        return status.value;
    }
  }
}
