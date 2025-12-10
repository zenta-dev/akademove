import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantAvailabilityToggle extends StatelessWidget {
  final bool isOnline;
  final String operatingStatus;
  final int activeOrderCount;
  final Function(bool) onOnlineChanged;
  final Function(String) onOperatingStatusChanged;
  final bool isLoading;

  const MerchantAvailabilityToggle({
    super.key,
    required this.isOnline,
    required this.operatingStatus,
    required this.activeOrderCount,
    required this.onOnlineChanged,
    required this.onOperatingStatusChanged,
    this.isLoading = false,
  });

  Color get statusColor {
    if (!isOnline) return Colors.red;
    if (operatingStatus == 'BREAK') return Colors.orange;
    if (operatingStatus == 'OPEN') return Colors.green;
    if (operatingStatus == 'MAINTENANCE') return Colors.amber;
    return Colors.red; // CLOSED
  }

  String get statusText {
    if (!isOnline) return 'Offline';
    return 'Online - ${_getStatusLabel(operatingStatus)}';
  }

  String get statusSubtitle {
    if (!isOnline) return 'Not receiving orders';
    if (operatingStatus == 'OPEN') {
      if (activeOrderCount > 0) {
        return 'Processing $activeOrderCount order${activeOrderCount > 1 ? 's' : ''}';
      }
      return 'Ready to receive orders';
    }
    if (operatingStatus == 'BREAK') {
      return 'Temporarily not accepting new orders';
    }
    return 'Not receiving orders';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Status Summary Card
          Card(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isOnline ? LucideIcons.circleCheck : LucideIcons.circle,
                      color: statusColor,
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusText,
                        style: context.typography.h4.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        statusSubtitle,
                        style: context.typography.small.copyWith(
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                // Active order count badge
                if (isOnline && activeOrderCount > 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.shoppingBag,
                          size: 14.sp,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '$activeOrderCount',
                          style: context.typography.small.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Online Toggle
          Card(
            padding: EdgeInsets.all(16.w),
            child: SwitchTile(
              title: isOnline ? 'Online' : 'Offline',
              subtitle: isOnline ? 'Available for orders' : 'Not available',
              value: isOnline,
              onChanged: isLoading ? null : onOnlineChanged,
              enabled: !isLoading,
            ),
          ),
          SizedBox(height: 16.h),

          // Operating Status (only show when online)
          if (isOnline) ...[
            // Operating Status Dropdown
            Card(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Store Status',
                    style: context.typography.p.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Select<String>(
                    itemBuilder: (context, item) => Text(_getStatusLabel(item)),
                    value: operatingStatus,
                    onChanged: isLoading
                        ? null
                        : (String? newValue) {
                            if (newValue != null) {
                              onOperatingStatusChanged(newValue);
                            }
                          },
                    popup: SelectPopup(
                      autoClose: true,
                      items: SelectItemList(
                        children: [
                          _buildStatusItem(context, 'OPEN'),
                          _buildStatusItem(context, 'BREAK'),
                          _buildStatusItem(context, 'MAINTENANCE'),
                          _buildStatusItem(context, 'CLOSED'),
                        ],
                      ),
                    ).call,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _getStatusDescription(operatingStatus),
                    style: context.typography.small.copyWith(
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  SelectItemButton<String> _buildStatusItem(
    BuildContext context,
    String status,
  ) {
    return SelectItemButton<String>(
      value: status,
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(_getStatusLabel(status)),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    return switch (status) {
      'OPEN' => Colors.green,
      'BREAK' => Colors.orange,
      'MAINTENANCE' => Colors.amber,
      'CLOSED' => Colors.red,
      _ => Colors.neutral,
    };
  }

  String _getStatusLabel(String status) {
    return switch (status) {
      'OPEN' => 'Open',
      'BREAK' => 'On Break',
      'MAINTENANCE' => 'Maintenance',
      'CLOSED' => 'Closed',
      _ => status,
    };
  }

  String _getStatusDescription(String status) {
    return switch (status) {
      'OPEN' => 'Accepting new orders from customers',
      'BREAK' =>
        'Temporarily not accepting new orders. Toggle when you\'re busy.',
      'MAINTENANCE' => 'Store is under maintenance',
      'CLOSED' => 'Store is closed, not accepting orders',
      _ => 'Let customers know your store status',
    };
  }
}
