import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
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
    return AlertDialog(
      title: Row(
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Order Details
          _buildDetailRow(
            context,
            icon: LucideIcons.mapPin,
            label: 'Pickup',
            value:
                '${order.pickupLocation.y.toStringAsFixed(5)}, ${order.pickupLocation.x.toStringAsFixed(5)}',
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            icon: LucideIcons.navigation,
            label: 'Dropoff',
            value:
                '${order.dropoffLocation.y.toStringAsFixed(5)}, ${order.dropoffLocation.x.toStringAsFixed(5)}',
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            icon: LucideIcons.ruler,
            label: 'Distance',
            value: '${order.distanceKm.toStringAsFixed(1)} km',
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            icon: LucideIcons.dollarSign,
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
                    LucideIcons.user,
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
          if (order.note != null) ...[
            Builder(
              builder: (context) {
                final note = order.note;
                if (note == null || !_hasNoteContent(note)) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
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
                                LucideIcons.stickyNote,
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
                            _getNoteText(note),
                            style: context.typography.small.copyWith(
                              color: context.colorScheme.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
      actions: [
        DestructiveButton(
          onPressed: onReject,
          child: Text(
            'Reject',
            style: context.typography.p.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        PrimaryButton(
          onPressed: onAccept,
          child: Text(
            'Accept',
            style: context.typography.p.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
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
    final pickup = note.pickup;
    final dropoff = note.dropoff;

    return (pickup != null && pickup.isNotEmpty) ||
        (dropoff != null && dropoff.isNotEmpty);
  }

  String _getNoteText(OrderNote note) {
    final parts = <String>[];
    final pickup = note.pickup;
    final dropoff = note.dropoff;

    if (pickup != null && pickup.isNotEmpty) {
      parts.add('Pickup: $pickup');
    }
    if (dropoff != null && dropoff.isNotEmpty) {
      parts.add('Dropoff: $dropoff');
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

  IconData _getOrderTypeIcon(OrderType type) {
    switch (type) {
      case OrderType.RIDE:
        return LucideIcons.car;
      case OrderType.DELIVERY:
        return LucideIcons.truck;
      case OrderType.FOOD:
        return LucideIcons.utensils;
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
            final incomingOrder = state.incomingOrder;
            if (incomingOrder != null) {
              _showIncomingOrderDialog(context, incomingOrder);
            }
          },
        ),
        // Listen for successful order acceptance
        BlocListener<DriverOrderCubit, DriverOrderState>(
          listener: (context, state) {
            final currentOrder = state.currentOrder;
            if (currentOrder != null) {
              // Navigate to order detail screen
              context.pushNamed(
                Routes.driverOrderDetail.name,
                pathParameters: {'orderId': currentOrder.id},
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
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<DriverHomeCubit>(),
        child: BlocListener<DriverHomeCubit, DriverHomeState>(
          // Listen for order cancellation or unavailability
          listenWhen: (previous, current) {
            return previous.incomingOrder != null &&
                current.incomingOrder == null;
          },
          listener: (context, state) {
            // Order was cancelled/unavailable, close dialog
            Navigator.of(dialogContext).pop();

            // Use a post-frame callback to ensure context is still valid
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                showToast(
                  context: context,
                  builder: (context, overlay) => context.buildToast(
                    title: 'Order Unavailable',
                    message:
                        'This order was cancelled or accepted by another driver',
                  ),
                );
              }
            });
          },
          child: IncomingOrderDialog(
            order: order,
            onAccept: () async {
              // Accept the order via DriverOrderCubit first
              try {
                await context.read<DriverOrderCubit>().acceptOrder(
                  order.id,
                  context.read<DriverHomeCubit>().state.myDriver?.id ?? '',
                );

                // Only close dialog and clear state after successful acceptance
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }

                if (context.mounted) {
                  context.read<DriverHomeCubit>().clearIncomingOrder();
                }

                // Navigation will be handled by the listener above
                // when the order state changes to ACCEPTED
              } catch (e) {
                // Handle error - show error message and keep dialog open
                if (context.mounted) {
                  showToast(
                    context: context,
                    builder: (context, overlay) => context.buildToast(
                      title: 'Error',
                      message: 'Failed to accept order. Please try again.',
                    ),
                  );
                }
              }
            },
            onReject: () async {
              // Close the dialog first
              Navigator.of(dialogContext).pop();

              // Clear incoming order from state
              if (context.mounted) {
                context.read<DriverHomeCubit>().clearIncomingOrder();

                // Show rejection toast
                showToast(
                  context: context,
                  builder: (context, overlay) => context.buildToast(
                    title: 'Order Rejected',
                    message: 'You rejected the order',
                  ),
                );

                // Reject the order in background
                try {
                  await context.read<DriverOrderCubit>().rejectOrder(order.id);
                } catch (e) {
                  // Silently handle rejection errors since user already rejected
                  // You could log this for debugging purposes
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
