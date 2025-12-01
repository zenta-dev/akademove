import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog that displays incoming order notifications to the driver
/// Shows order details and provides Accept/Reject actions
class IncomingOrderDialog extends StatelessWidget {
  const IncomingOrderDialog({
    required this.order,
    required this.onAccept,
    required this.onReject,
    super.key,
  });

  final Order order;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return material.Dialog(
      shape: material.RoundedRectangleBorder(
        borderRadius: material.BorderRadius.circular(16.r),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 400.w),
        padding: EdgeInsets.all(20.dg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.dg),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    _getOrderTypeIcon(order.type),
                    color: context.colorScheme.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New ${_getOrderTypeLabel(order.type)} Order',
                        style: context.typography.h4.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Order #${order.id.substring(0, 8)}',
                        style: context.typography.small.copyWith(
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Order Details
            _buildDetailRow(
              context,
              icon: material.Icons.location_on,
              label: 'Pickup',
              value:
                  '${order.pickupLocation.y.toStringAsFixed(5)}, ${order.pickupLocation.x.toStringAsFixed(5)}',
            ),
            SizedBox(height: 12.h),
            _buildDetailRow(
              context,
              icon: material.Icons.place,
              label: 'Dropoff',
              value:
                  '${order.dropoffLocation.y.toStringAsFixed(5)}, ${order.dropoffLocation.x.toStringAsFixed(5)}',
            ),
            SizedBox(height: 12.h),
            _buildDetailRow(
              context,
              icon: material.Icons.straighten,
              label: 'Distance',
              value: '${order.distanceKm.toStringAsFixed(1)} km',
            ),
            SizedBox(height: 12.h),
            _buildDetailRow(
              context,
              icon: material.Icons.attach_money,
              label: 'Earnings',
              value: 'Rp ${_formatMoney(order.totalPrice * 0.85)}',
            ),

            // Gender preference if specified
            if (order.gender != null) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.dg),
                decoration: BoxDecoration(
                  color: context.colorScheme.muted,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      material.Icons.person,
                      size: 16.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Gender preference: ${order.gender?.value}',
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Note if provided
            if (order.note != null && _hasNoteContent(order.note!)) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.dg),
                decoration: BoxDecoration(
                  color: context.colorScheme.muted,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          material.Icons.note,
                          size: 16.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Note:',
                          style: context.typography.small.copyWith(
                            color: context.colorScheme.mutedForeground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getNoteText(order.note!),
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 24.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: material.OutlinedButton(
                    onPressed: onReject,
                    style: material.OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: material.RoundedRectangleBorder(
                        borderRadius: material.BorderRadius.circular(8.r),
                      ),
                      side: material.BorderSide(
                        color: material.Colors.red,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      'Reject',
                      style: context.typography.p.copyWith(
                        color: material.Colors.red,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: material.ElevatedButton(
                    onPressed: onAccept,
                    style: material.ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.primaryForeground,
                      shape: material.RoundedRectangleBorder(
                        borderRadius: material.BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Accept',
                      style: context.typography.p.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required material.IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.sp, color: context.colorScheme.mutedForeground),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.typography.small.copyWith(
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: context.typography.p.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _hasNoteContent(OrderNote note) {
    return (note.pickup != null && note.pickup!.isNotEmpty) ||
        (note.dropoff != null && note.dropoff!.isNotEmpty) ||
        (note.instructions != null && note.instructions!.isNotEmpty);
  }

  String _getNoteText(OrderNote note) {
    final parts = <String>[];
    if (note.pickup != null && note.pickup!.isNotEmpty) {
      parts.add('Pickup: ${note.pickup}');
    }
    if (note.dropoff != null && note.dropoff!.isNotEmpty) {
      parts.add('Dropoff: ${note.dropoff}');
    }
    if (note.instructions != null && note.instructions!.isNotEmpty) {
      parts.add('Instructions: ${note.instructions}');
    }
    return parts.join('\n');
  }

  String _getOrderTypeLabel(OrderType type) {
    switch (type) {
      case OrderType.RIDE:
        return 'Ride';
      case OrderType.DELIVERY:
        return 'Delivery';
      case OrderType.FOOD:
        return 'Food';
    }
  }

  material.IconData _getOrderTypeIcon(OrderType type) {
    switch (type) {
      case OrderType.RIDE:
        return material.Icons.directions_car;
      case OrderType.DELIVERY:
        return material.Icons.local_shipping;
      case OrderType.FOOD:
        return material.Icons.restaurant;
    }
  }

  String _formatMoney(num amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }
}

/// Widget that listens to DriverHomeCubit and shows incoming order dialog
class IncomingOrderListener extends StatelessWidget {
  const IncomingOrderListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen for incoming orders
        BlocListener<DriverHomeCubit, DriverHomeState>(
          listenWhen: (previous, current) {
            // Show dialog when incoming order appears
            return previous.incomingOrder == null &&
                current.incomingOrder != null;
          },
          listener: (context, state) {
            if (state.incomingOrder != null) {
              _showIncomingOrderDialog(context, state.incomingOrder!);
            }
          },
        ),
        // Listen for successful order acceptance
        BlocListener<DriverOrderCubit, DriverOrderState>(
          listenWhen: (previous, current) {
            // Navigate when order is successfully accepted
            return previous.activeOrder == null &&
                current.activeOrder != null &&
                current.activeOrder!.status == OrderStatus.ACCEPTED;
          },
          listener: (context, state) {
            if (state.activeOrder != null) {
              // Navigate to order detail screen
              context.goNamed(
                Routes.driverOrderDetail.name,
                pathParameters: {'orderId': state.activeOrder!.id},
              );
            }
          },
        ),
      ],
      child: child,
    );
  }

  void _showIncomingOrderDialog(BuildContext context, Order order) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) =>
          BlocListener<DriverHomeCubit, DriverHomeState>(
            // Listen for order cancellation or unavailability
            listenWhen: (previous, current) {
              return previous.incomingOrder != null &&
                  current.incomingOrder == null;
            },
            listener: (context, state) {
              // Order was cancelled/unavailable, close dialog
              Navigator.of(dialogContext).pop();
              showToast(
                context: context,
                builder: (context, overlay) => context.buildToast(
                  title: 'Order Unavailable',
                  message:
                      'This order was cancelled or accepted by another driver',
                ),
              );
            },
            child: IncomingOrderDialog(
              order: order,
              onAccept: () async {
                // Close the dialog
                Navigator.of(dialogContext).pop();
                // Clear incoming order from state
                context.read<DriverHomeCubit>().clearIncomingOrder();

                // Accept the order via DriverOrderCubit
                await context.read<DriverOrderCubit>().acceptOrder(order.id);

                // Navigation will be handled by the listener above
                // when the order state changes to ACCEPTED
              },
              onReject: () async {
                // Close the dialog
                Navigator.of(dialogContext).pop();
                // Clear incoming order from state
                context.read<DriverHomeCubit>().clearIncomingOrder();

                // Reject the order
                await context.read<DriverOrderCubit>().rejectOrder(order.id);

                showToast(
                  context: context,
                  builder: (context, overlay) => context.buildToast(
                    title: 'Order Rejected',
                    message: 'You rejected the order',
                  ),
                );
              },
            ),
          ),
    );
  }
}
