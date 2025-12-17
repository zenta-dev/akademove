import "package:akademove/core/_export.dart";
import "package:akademove/l10n/l10n.dart";
import "package:api_client/api_client.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

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

/// Completed order statuses
const _completedStatuses = [OrderStatus.COMPLETED];

/// Cancelled order statuses
const _cancelledStatuses = [
  OrderStatus.CANCELLED_BY_USER,
  OrderStatus.CANCELLED_BY_DRIVER,
  OrderStatus.CANCELLED_BY_MERCHANT,
  OrderStatus.CANCELLED_BY_SYSTEM,
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
  bool get _isCompletedOrder => _completedStatuses.contains(order.status);
  bool get _isCancelledOrder => _cancelledStatuses.contains(order.status);

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
              // Header: Order ID, Time badge, and status
              _buildTopHeader(context),
              const Divider(),
              // Customer info with avatar
              _buildCustomerSection(context),
              // Order items preview with images
              _buildOrderItemsPreview(context),
              // Delivery address with distance
              _buildDeliverySection(context),
              const Divider(),
              // Footer: Price breakdown and time
              _buildFooter(context),
              // Progress indicator for active orders
              if (_isActiveOrder) _buildProgressIndicator(context),
              // Completion summary for completed orders
              if (_isCompletedOrder) _buildCompletionSummary(context),
              // Cancellation info for cancelled orders
              if (_isCancelledOrder) _buildCancellationInfo(context),
              // Action buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimeAgo(Duration duration) {
    if (duration.inMinutes < 1) {
      return "Just now";
    } else if (duration.inMinutes < 60) {
      return "${duration.inMinutes}m ago";
    } else if (duration.inHours < 24) {
      return "${duration.inHours}h ago";
    } else {
      return "${duration.inDays}d ago";
    }
  }

  /// Calculate estimated delivery time based on distance and order status
  /// For campus delivery, assume average speed of 15 km/h
  /// Food orders include preparation time (5-10 min based on status)
  int _calculateEstimatedMinutes() {
    // Average campus motorcycle speed: 15 km/h
    const averageSpeedKmPerHour = 15.0;

    // Calculate travel time in minutes
    final travelMinutes = (order.distanceKm / averageSpeedKmPerHour * 60)
        .ceil();

    // Add preparation time based on order status
    int prepMinutes = 0;
    if (order.type == OrderType.FOOD) {
      switch (order.status) {
        case OrderStatus.REQUESTED:
        case OrderStatus.MATCHING:
          // Not yet accepted: include full prep time estimate
          prepMinutes = 10;
        case OrderStatus.ACCEPTED:
          // Accepted but not preparing yet
          prepMinutes = 8;
        case OrderStatus.PREPARING:
          // Currently preparing
          prepMinutes = 5;
        case OrderStatus.READY_FOR_PICKUP:
        case OrderStatus.ARRIVING:
        case OrderStatus.IN_TRIP:
          // Ready or on the way: no prep time
          prepMinutes = 0;
        default:
          prepMinutes = 0;
      }
    }

    // Minimum 5 minutes for any delivery
    return (travelMinutes + prepMinutes).clamp(5, 60);
  }

  String _formatEstimatedTime() {
    final minutes = _calculateEstimatedMinutes();
    if (minutes < 60) {
      return "~$minutes min";
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return "~$hours hr";
      }
      return "~$hours hr $remainingMinutes min";
    }
  }

  Widget _buildTopHeader(BuildContext context) {
    final isNew = order.status == OrderStatus.REQUESTED;
    final timeSinceOrder = DateTime.now().difference(order.requestedAt);
    final timeAgo = _formatTimeAgo(timeSinceOrder);

    return Row(
      children: [
        // Order ID badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.w,
            children: [
              Icon(
                LucideIcons.receipt,
                size: 14.sp,
                color: context.colorScheme.primary,
              ),
              Text(
                "#${order.id.prefix(8).toUpperCase()}",
                style: context.typography.small.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        // New order indicator
        if (isNew)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5722),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4.w,
              children: [
                Icon(LucideIcons.zap, size: 12.sp, color: Colors.white),
                Text(
                  "NEW",
                  style: context.typography.xSmall.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        const Spacer(),
        // Time ago badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: context.colorScheme.muted,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4.w,
            children: [
              Icon(
                LucideIcons.clock,
                size: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
              Text(
                timeAgo,
                style: context.typography.xSmall.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerSection(BuildContext context) {
    final userName = order.user?.name ?? "Customer";
    final userImage = order.user?.image;
    final userRating = order.user?.rating;
    final userGender = order.user?.gender;

    return Row(
      children: [
        // Customer avatar
        if (userImage != null && userImage.isNotEmpty)
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: userImage,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  _buildAvatarPlaceholder(context, userName),
              errorWidget: (context, url, error) =>
                  _buildAvatarPlaceholder(context, userName),
            ),
          )
        else
          _buildAvatarPlaceholder(context, userName),
        SizedBox(width: 12.w),
        // Customer info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      userName,
                      style: context.typography.h4.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Gender badge
                  if (userGender != null) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: userGender == UserGender.MALE
                            ? const Color(0xFF2196F3).withValues(alpha: 0.1)
                            : const Color(0xFFE91E63).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.w,
                        children: [
                          Icon(
                            userGender == UserGender.MALE
                                ? LucideIcons.user
                                : LucideIcons.user,
                            size: 10.sp,
                            color: userGender == UserGender.MALE
                                ? const Color(0xFF2196F3)
                                : const Color(0xFFE91E63),
                          ),
                          Text(
                            userGender == UserGender.MALE ? "M" : "F",
                            style: context.typography.xSmall.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: userGender == UserGender.MALE
                                  ? const Color(0xFF2196F3)
                                  : const Color(0xFFE91E63),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  // Rating
                  if (userRating != null && userRating > 0) ...[
                    Icon(
                      LucideIcons.star,
                      size: 14.sp,
                      color: const Color(0xFFFFC107),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      userRating.toStringAsFixed(1),
                      style: context.typography.small.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: BoxDecoration(
                        color: context.colorScheme.mutedForeground,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 12.w),
                  ],
                  Text(
                    context.l10n.text_customer,
                    style: context.typography.small.copyWith(
                      fontSize: 13.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Status badge
        _buildStatusBadge(context),
      ],
    );
  }

  Widget _buildAvatarPlaceholder(BuildContext context, String name) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          name.firstChar.toUpperCase(),
          style: context.typography.h3.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.primary,
          ),
        ),
      ),
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
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.colorScheme.muted.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          spacing: 8.w,
          children: [
            Icon(
              LucideIcons.shoppingBag,
              size: 16.sp,
              color: context.colorScheme.mutedForeground,
            ),
            Text(
              context.l10n.item_count(order.itemCount ?? 0),
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
      );
    }

    // Show first 3 items with images
    final displayItems = items.take(3).toList();
    final remainingCount = items.length - displayItems.length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.muted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          // Items header
          Row(
            children: [
              Icon(
                LucideIcons.utensils,
                size: 16.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                context.l10n.order_items,
                style: context.typography.small.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  "${items.length} ${items.length == 1 ? "item" : "items"}",
                  style: context.typography.xSmall.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          // Item list
          ...displayItems.map((orderItem) {
            final item = orderItem.item;
            return Row(
              children: [
                // Item image
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    color: context.colorScheme.background,
                    child: item.image != null && item.image!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: item.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: Icon(
                                LucideIcons.utensils,
                                size: 18.sp,
                                color: context.colorScheme.mutedForeground,
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                LucideIcons.utensils,
                                size: 18.sp,
                                color: context.colorScheme.mutedForeground,
                              ),
                            ),
                          )
                        : Center(
                            child: Icon(
                              LucideIcons.utensils,
                              size: 18.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: 10.w),
                // Item details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2.h,
                    children: [
                      Text(
                        item.name ?? context.l10n.unknown_item,
                        style: context.typography.small.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${orderItem.quantity}x @ ${context.formatCurrency(item.price ?? 0)}",
                        style: context.typography.xSmall.copyWith(
                          fontSize: 12.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                // Quantity badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "${orderItem.quantity}x",
                    style: context.typography.xSmall.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          }),
          if (remainingCount > 0)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.ellipsis,
                    size: 16.sp,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "+$remainingCount more ${remainingCount == 1 ? "item" : "items"}",
                    style: context.typography.small.copyWith(
                      fontSize: 13.sp,
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeliverySection(BuildContext context) {
    final address = order.dropoffAddress;
    if (address == null || address.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.muted.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.colorScheme.border.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.navigation,
                size: 16.sp,
                color: context.colorScheme.destructive,
              ),
              SizedBox(width: 8.w),
              Text(
                context.l10n.delivery_location,
                style: context.typography.small.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              // ETA badge (only for active orders)
              if (_isActiveOrder)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4.w,
                    children: [
                      Icon(
                        LucideIcons.clock,
                        size: 12.sp,
                        color: context.colorScheme.primary,
                      ),
                      Text(
                        _formatEstimatedTime(),
                        style: context.typography.xSmall.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              if (_isActiveOrder) SizedBox(width: 6.w),
              // Distance badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4.w,
                  children: [
                    Icon(
                      LucideIcons.route,
                      size: 12.sp,
                      color: context.colorScheme.secondary,
                    ),
                    Text(
                      "${order.distanceKm.toStringAsFixed(1)} km",
                      style: context.typography.xSmall.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            address,
            style: context.typography.small.copyWith(
              fontSize: 13.sp,
              color: context.colorScheme.mutedForeground,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    // Calculate subtotal from items
    final items = order.items ?? [];
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + (item.item.price?.toDouble() ?? 0) * item.quantity,
    );
    final deliveryFee = order.totalPrice - subtotal;

    return Column(
      spacing: 8.h,
      children: [
        // Price breakdown
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.label_subtotal,
                  style: context.typography.xSmall.copyWith(
                    fontSize: 11.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                Text(
                  context.formatCurrency(subtotal),
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.l10n.delivery_fee,
                  style: context.typography.xSmall.copyWith(
                    fontSize: 11.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                Text(
                  context.formatCurrency(deliveryFee > 0 ? deliveryFee : 0),
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  context.l10n.total,
                  style: context.typography.xSmall.copyWith(
                    fontSize: 11.sp,
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  context.formatCurrency(order.totalPrice),
                  style: context.typography.h4.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Time info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 6.w,
              children: [
                Icon(
                  LucideIcons.calendar,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Text(
                  order.requestedAt.orderFormat,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 6.w,
              children: [
                Icon(
                  LucideIcons.package,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Text(
                  context.l10n.item_count(order.itemCount ?? 0),
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
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

  Widget _buildProgressIndicator(BuildContext context) {
    final steps = _getMerchantOrderSteps(context);
    final currentStepIndex = _getCurrentStepIndex(order.status);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: context.colorScheme.muted.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Text(
            "Order Progress",
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isOdd) {
                // Connector line
                final stepIndex = index ~/ 2;
                final isCompleted = stepIndex < currentStepIndex;
                return Expanded(
                  child: Container(
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? context.colorScheme.primary
                          : context.colorScheme.border,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                );
              } else {
                // Step indicator
                final stepIndex = index ~/ 2;
                final isCompleted = stepIndex < currentStepIndex;
                final isCurrent = stepIndex == currentStepIndex;
                final step = steps[stepIndex];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4.h,
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: isCompleted || isCurrent
                            ? context.colorScheme.primary
                            : context.colorScheme.muted,
                        shape: BoxShape.circle,
                        border: isCurrent
                            ? Border.all(
                                color: context.colorScheme.primary.withValues(
                                  alpha: 0.3,
                                ),
                                width: 3,
                              )
                            : null,
                      ),
                      child: Center(
                        child: isCompleted
                            ? Icon(
                                LucideIcons.check,
                                size: 14.sp,
                                color: Colors.white,
                              )
                            : Icon(
                                step.icon,
                                size: 12.sp,
                                color: isCurrent
                                    ? Colors.white
                                    : context.colorScheme.mutedForeground,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 50.w,
                      child: Text(
                        step.label,
                        textAlign: TextAlign.center,
                        style: context.typography.xSmall.copyWith(
                          fontSize: 9.sp,
                          fontWeight: isCurrent
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isCurrent
                              ? context.colorScheme.primary
                              : context.colorScheme.mutedForeground,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  List<_ProgressStep> _getMerchantOrderSteps(BuildContext context) {
    return [
      _ProgressStep(
        label: context.l10n.status_requested,
        icon: LucideIcons.bell,
      ),
      _ProgressStep(
        label: context.l10n.status_accepted,
        icon: LucideIcons.circleCheck,
      ),
      _ProgressStep(
        label: context.l10n.status_preparing,
        icon: LucideIcons.chefHat,
      ),
      _ProgressStep(
        label: context.l10n.status_ready_for_pickup,
        icon: LucideIcons.packageCheck,
      ),
      _ProgressStep(label: context.l10n.status_in_trip, icon: LucideIcons.bike),
    ];
  }

  int _getCurrentStepIndex(OrderStatus status) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return 0;
      case OrderStatus.MATCHING:
      case OrderStatus.ACCEPTED:
        return 1;
      case OrderStatus.PREPARING:
        return 2;
      case OrderStatus.READY_FOR_PICKUP:
      case OrderStatus.ARRIVING:
        return 3;
      case OrderStatus.IN_TRIP:
        return 4;
      default:
        return 0;
    }
  }

  /// Build completion summary for completed orders
  Widget _buildCompletionSummary(BuildContext context) {
    // Use updatedAt as the completion time since there's no dedicated completedAt
    final completedAt = order.updatedAt;
    final platformCommission = order.platformCommission ?? 0;
    final merchantEarnings =
        order.merchantCommission ?? (order.totalPrice - platformCommission);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.circleCheck,
                  size: 16.sp,
                  color: const Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                context.l10n.order_completed,
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4CAF50),
                ),
              ),
              const Spacer(),
              Text(
                completedAt.orderFormat,
                style: context.typography.xSmall.copyWith(
                  fontSize: 11.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
          const Divider(),
          // Earnings breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  Text(
                    context.l10n.label_total_price,
                    style: context.typography.xSmall.copyWith(
                      fontSize: 11.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                  Text(
                    context.formatCurrency(order.totalPrice),
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 2.h,
                children: [
                  Text(
                    context.l10n.label_platform_commission,
                    style: context.typography.xSmall.copyWith(
                      fontSize: 11.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                  Text(
                    "-${context.formatCurrency(platformCommission)}",
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.destructive,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 2.h,
                children: [
                  Text(
                    context.l10n.net_earnings,
                    style: context.typography.xSmall.copyWith(
                      fontSize: 11.sp,
                      color: const Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    context.formatCurrency(merchantEarnings),
                    style: context.typography.h4.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build cancellation info for cancelled orders
  Widget _buildCancellationInfo(BuildContext context) {
    final cancelReason = order.cancelReason;
    // Use updatedAt as the cancellation time since there's no dedicated cancelledAt
    final cancelledAt = order.updatedAt;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF44336).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFFF44336).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF44336).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.circleX,
                  size: 16.sp,
                  color: const Color(0xFFF44336),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  _getCancellationTitle(context, order.status),
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF44336),
                  ),
                ),
              ),
              Text(
                cancelledAt.orderFormat,
                style: context.typography.xSmall.copyWith(
                  fontSize: 11.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
          // Cancellation reason
          if (cancelReason != null && cancelReason.isNotEmpty) ...[
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  LucideIcons.messageSquare,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        context.l10n.cancellation_reason,
                        style: context.typography.xSmall.copyWith(
                          fontSize: 11.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                      Text(
                        cancelReason,
                        style: context.typography.small.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          // Refund notice
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: context.colorScheme.muted.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              children: [
                Icon(
                  LucideIcons.info,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    context.l10n.text_refund_automatically,
                    style: context.typography.xSmall.copyWith(
                      fontSize: 11.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCancellationTitle(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.CANCELLED_BY_USER:
        return context.l10n.cancelled_by_user;
      case OrderStatus.CANCELLED_BY_DRIVER:
        return context.l10n.cancelled_by_driver;
      case OrderStatus.CANCELLED_BY_MERCHANT:
        return context.l10n.cancelled_by_merchant;
      case OrderStatus.CANCELLED_BY_SYSTEM:
        return context.l10n.cancelled_by_system;
      default:
        return context.l10n.cancelled;
    }
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
                  Icon(LucideIcons.check, size: 18.sp),
                  Text(
                    context.l10n.button_accept,
                    style: context.typography.small.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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

class _ProgressStep {
  const _ProgressStep({required this.label, required this.icon});
  final String label;
  final IconData icon;
}
