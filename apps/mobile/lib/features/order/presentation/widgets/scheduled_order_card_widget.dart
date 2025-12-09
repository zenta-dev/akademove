import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ScheduledOrderCardWidget extends StatelessWidget {
  const ScheduledOrderCardWidget({
    required this.order,
    this.onTap,
    this.onEdit,
    this.onCancel,
    super.key,
  });

  final Order order;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final scheduledAt = order.scheduledAt;
    final scheduledMatchingAt = order.scheduledMatchingAt;

    return GhostButton(
      onPressed: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            // Header: Type badge + Status badge + Date
            Row(
              children: [
                _buildTypeBadge(context, order.type),
                SizedBox(width: 8.w),
                _buildScheduledBadge(context),
                const Spacer(),
                if (scheduledAt != null)
                  Text(
                    DateFormat('MMM dd, yyyy').format(scheduledAt),
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
              ],
            ),
            const Divider(),

            // Scheduled Time Info
            if (scheduledAt != null)
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: context.colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.calendar,
                      size: 20.sp,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.h,
                        children: [
                          Text(
                            context.l10n.scheduled_for(
                              DateFormat('EEEE, MMM dd').format(scheduledAt),
                            ),
                            style: context.typography.p.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            DateFormat('hh:mm a').format(scheduledAt),
                            style: context.typography.h3.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.primary,
                            ),
                          ),
                          if (scheduledMatchingAt != null)
                            Text(
                              context.l10n.matching_starts_at(
                                DateFormat(
                                  'hh:mm a',
                                ).format(scheduledMatchingAt),
                              ),
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

            // Pickup and Dropoff
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.w,
              children: [
                Column(
                  spacing: 8.h,
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: 16.sp,
                      color: const Color(0xFF4CAF50),
                    ),
                    Container(
                      width: 2.w,
                      height: 20.h,
                      color: context.colorScheme.mutedForeground,
                    ),
                    Icon(
                      LucideIcons.navigation,
                      size: 16.sp,
                      color: const Color(0xFFF44336),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      Text(
                        '${order.pickupLocation.y.toStringAsFixed(4)}, ${order.pickupLocation.x.toStringAsFixed(4)}',
                        style: context.typography.p.copyWith(fontSize: 14.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '${order.dropoffLocation.y.toStringAsFixed(4)}, ${order.dropoffLocation.x.toStringAsFixed(4)}',
                        style: context.typography.p.copyWith(fontSize: 14.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),

            // Footer: Distance + Fare + Actions
            Row(
              children: [
                Icon(LucideIcons.ruler, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  '${order.distanceKm.toStringAsFixed(2)} km',
                  style: context.typography.small.copyWith(fontSize: 12.sp),
                ),
                const Spacer(),
                Text(
                  context.formatCurrency(order.totalPrice),
                  style: context.typography.h4.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),

            // Action buttons
            if (onEdit != null || onCancel != null) ...[
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8.w,
                children: [
                  if (onEdit != null)
                    OutlineButton(
                      onPressed: onEdit,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.w,
                        children: [
                          Icon(LucideIcons.pencil, size: 14.sp),
                          Text(context.l10n.edit_schedule),
                        ],
                      ),
                    ),
                  if (onCancel != null)
                    DestructiveButton(
                      onPressed: onCancel,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.w,
                        children: [
                          Icon(LucideIcons.x, size: 14.sp),
                          Text(context.l10n.cancel),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(BuildContext context, OrderType type) {
    Color color;
    IconData icon;

    switch (type) {
      case OrderType.RIDE:
        color = const Color(0xFF2196F3);
        icon = LucideIcons.car;
      case OrderType.DELIVERY:
        color = const Color(0xFFFF9800);
        icon = LucideIcons.package;
      case OrderType.FOOD:
        color = const Color(0xFF4CAF50);
        icon = LucideIcons.utensils;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          Icon(icon, size: 14.sp, color: color),
          Text(
            type.name,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledBadge(BuildContext context) {
    const color = Color(0xFF9C27B0);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          Icon(LucideIcons.clock, size: 14.sp, color: color),
          Text(
            context.l10n.scheduled,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
