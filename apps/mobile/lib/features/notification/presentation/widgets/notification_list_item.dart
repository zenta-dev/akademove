import 'package:akademove/core/_export.dart';
import 'package:akademove/features/notification/data/models/notification_models.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
    super.key,
  });

  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return material.Dismissible(
      key: Key(notification.id),
      direction: material.DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          color: context.colorScheme.destructive,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          LucideIcons.trash2,
          color: context.colorScheme.foreground,
          size: 24.sp,
        ),
      ),
      child: Card(
        padding: EdgeInsets.zero,
        child: material.InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(16.dg),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: notification.isRead
                  ? null
                  : context.colorScheme.primary.withValues(alpha: 0.05),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIcon(context),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: context.typography.semiBold.copyWith(
                                fontWeight: notification.isRead
                                    ? FontWeight.w500
                                    : FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      Text(
                        notification.body,
                        style: context.typography.small.copyWith(
                          color: context.colorScheme.mutedForeground,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _formatTimeAgo(context, notification.createdAt),
                        style: context.typography.small.copyWith(
                          color: context.colorScheme.mutedForeground,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final iconData = _getIconForType(notification.type);
    final iconColor = _getColorForType(context, notification.type);

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 20.sp),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'order':
        return LucideIcons.shoppingBag;
      case 'ride':
        return LucideIcons.bike;
      case 'delivery':
        return LucideIcons.package;
      case 'food':
        return LucideIcons.utensils;
      case 'wallet':
        return LucideIcons.wallet;
      case 'promo':
        return LucideIcons.tag;
      case 'system':
        return LucideIcons.settings;
      case 'alert':
        return LucideIcons.triangleAlert;
      default:
        return LucideIcons.bell;
    }
  }

  Color _getColorForType(BuildContext context, String type) {
    switch (type.toLowerCase()) {
      case 'order':
        return Colors.blue;
      case 'ride':
        return Colors.green;
      case 'delivery':
        return Colors.orange;
      case 'food':
        return Colors.pink;
      case 'wallet':
        return Colors.purple;
      case 'promo':
        return Colors.yellow.shade700;
      case 'system':
        return context.colorScheme.mutedForeground;
      case 'alert':
        return context.colorScheme.destructive;
      default:
        return context.colorScheme.primary;
    }
  }

  String _formatTimeAgo(BuildContext context, DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return context.l10n.notification_time_ago('just now');
    } else if (difference.inMinutes < 60) {
      return context.l10n.notification_time_ago('${difference.inMinutes}m');
    } else if (difference.inHours < 24) {
      return context.l10n.notification_time_ago('${difference.inHours}h');
    } else if (difference.inDays < 7) {
      return context.l10n.notification_time_ago('${difference.inDays}d');
    } else {
      return DateFormat('MMM dd').format(dateTime);
    }
  }
}
