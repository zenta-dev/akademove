import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantAvailabilityToggle extends StatelessWidget {
  final bool isOnline;
  final bool isTakingOrders;
  final String operatingStatus;
  final Function(bool) onOnlineChanged;
  final Function(bool) onOrderTakingChanged;
  final Function(String) onOperatingStatusChanged;
  final bool isLoading;

  const MerchantAvailabilityToggle({
    super.key,
    required this.isOnline,
    required this.isTakingOrders,
    required this.operatingStatus,
    required this.onOnlineChanged,
    required this.onOrderTakingChanged,
    required this.onOperatingStatusChanged,
    this.isLoading = false,
  });

  Color get statusColor {
    if (!isOnline) return Colors.red;
    if (!isTakingOrders) return Colors.orange;
    if (operatingStatus == 'OPEN') return Colors.green;
    return Colors.amber;
  }

  String get statusText {
    if (!isOnline) return 'Offline';
    if (!isTakingOrders) return 'Online (Paused)';
    return 'Online - $operatingStatus';
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
                        isOnline
                            ? 'You can receive orders'
                            : 'Not receiving orders',
                        style: context.typography.small.copyWith(
                          color: context.colorScheme.mutedForeground,
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

          // Order Taking Toggle (only show when online)
          if (isOnline) ...[
            Card(
              padding: EdgeInsets.all(16.w),
              child: SwitchTile(
                title: isTakingOrders ? 'Taking Orders' : 'Paused',
                subtitle: isTakingOrders
                    ? 'Ready to accept orders'
                    : 'Temporarily paused',
                value: isTakingOrders,
                onChanged: isLoading ? null : onOrderTakingChanged,
                enabled: !isLoading,
              ),
            ),
            SizedBox(height: 16.h),

            // Operating Status Dropdown (only show when online)
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
                    'Let customers know your store status',
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
}
