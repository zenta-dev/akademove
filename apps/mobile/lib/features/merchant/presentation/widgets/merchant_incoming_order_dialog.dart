import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog that displays incoming food order notifications to the merchant
/// Shows order details (items, customer, total) and provides Accept/Reject actions
class MerchantIncomingOrderDialog extends StatelessWidget {
  const MerchantIncomingOrderDialog({
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
              LucideIcons.utensils,
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
                  'New Food Order',
                  style: context.typography.h4.copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Order #${order.id.prefix(8)}',
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
          // Customer info
          if (order.user != null) ...[
            _buildDetailRow(
              context,
              icon: LucideIcons.user,
              label: 'Customer',
              value: order.user?.name ?? 'Unknown',
            ),
            SizedBox(height: 12.h),
          ],

          // Order items
          _buildOrderItemsSection(context),
          SizedBox(height: 12.h),

          // Delivery address
          _buildLocationDetailRow(
            context,
            icon: LucideIcons.navigation,
            label: 'Delivery to',
            address: order.dropoffAddress,
            coordinate: order.dropoffLocation,
          ),
          SizedBox(height: 12.h),

          // Total price
          _buildDetailRow(
            context,
            icon: LucideIcons.dollarSign,
            label: 'Total',
            value: 'Rp ${_formatMoney(order.totalPrice)}',
          ),

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

  Widget _buildOrderItemsSection(BuildContext context) {
    final items = order.items;
    if (items == null || items.isEmpty) {
      return _buildDetailRow(
        context,
        icon: LucideIcons.shoppingBag,
        label: 'Items',
        value: '${order.itemCount ?? 0} item(s)',
      );
    }

    return Container(
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
                LucideIcons.shoppingBag,
                size: 16.sp,
                color: context.colorScheme.mutedForeground,
              ),
              SizedBox(width: 8.w),
              Text(
                'Order Items',
                style: context.typography.small.copyWith(
                  color: context.colorScheme.mutedForeground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...items.take(5).map((item) => _buildOrderItemRow(context, item)),
          if (items.length > 5) ...[
            SizedBox(height: 4.h),
            Text(
              '+${items.length - 5} more item(s)',
              style: context.typography.small.copyWith(
                color: context.colorScheme.mutedForeground,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderItemRow(BuildContext context, OrderItem orderItem) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${orderItem.quantity}x ${orderItem.item.name ?? "Unknown"}',
              style: context.typography.small,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            'Rp ${_formatMoney((orderItem.item.price ?? 0) * orderItem.quantity)}',
            style: context.typography.small.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
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

  Widget _buildLocationDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String? address,
    required Coordinate coordinate,
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
              AddressText(
                address: address,
                coordinate: coordinate,
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

  String _formatMoney(num amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }
}

/// Widget that listens to MerchantOrderCubit and shows incoming order dialog
class MerchantIncomingOrderListener extends StatefulWidget {
  const MerchantIncomingOrderListener({required this.child, super.key});

  final Widget child;

  @override
  State<MerchantIncomingOrderListener> createState() =>
      _MerchantIncomingOrderListenerState();
}

class _MerchantIncomingOrderListenerState
    extends State<MerchantIncomingOrderListener> {
  @override
  void initState() {
    super.initState();
    // Subscribe to merchant orders when the listener is initialized
    _subscribeToMerchantOrders();
  }

  void _subscribeToMerchantOrders() {
    // Get merchant ID from MerchantCubit state
    final merchantState = context.read<MerchantCubit>().state;
    final merchantId = merchantState.mine.value?.id;

    if (merchantId != null) {
      context.read<MerchantOrderCubit>().subscribeToMerchantOrders(merchantId);
    } else {
      // If merchant ID is not available yet, listen for it
      logger.w(
        '[MerchantIncomingOrderListener] - Merchant ID not available, waiting...',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen for merchant data to subscribe to WebSocket
        BlocListener<MerchantCubit, MerchantState>(
          listenWhen: (previous, current) {
            // Subscribe when merchant data becomes available
            return previous.mine.value?.id == null &&
                current.mine.value?.id != null;
          },
          listener: (context, state) {
            final merchantId = state.mine.value?.id;
            if (merchantId != null) {
              context.read<MerchantOrderCubit>().subscribeToMerchantOrders(
                merchantId,
              );
            }
          },
        ),
        // Listen for incoming orders
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) {
            // Show dialog when a new incoming order appears
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
        // Listen for successful order acceptance or failure
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) {
            // Listen for acceptance result changes
            return previous.order != current.order;
          },
          listener: (context, state) {
            // Handle success - navigate to order detail
            if (state.order.isSuccess) {
              final acceptedOrder = state.order.value;
              if (acceptedOrder != null) {
                context.pushNamed(
                  Routes.merchantOrderDetail.name,
                  extra: acceptedOrder,
                );
              }
            }

            // Handle failure - show error toast
            if (state.order.isFailed) {
              showToast(
                context: context,
                builder: (context, overlay) => context.buildToast(
                  title: 'Error',
                  message:
                      state.order.error?.message ??
                      'Failed to process order. Please try again.',
                ),
              );
            }
          },
        ),
      ],
      child: widget.child,
    );
  }

  void _showIncomingOrderDialog(BuildContext context, Order order) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<MerchantCubit>()),
          BlocProvider.value(value: context.read<MerchantOrderCubit>()),
        ],
        child: BlocListener<MerchantOrderCubit, MerchantOrderState>(
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
                    message: 'This order was cancelled by the customer',
                  ),
                );
              }
            });
          },
          child: MerchantIncomingOrderDialog(
            order: order,
            onAccept: () {
              final merchantId = context
                  .read<MerchantCubit>()
                  .state
                  .mine
                  .value
                  ?.id;
              if (merchantId != null) {
                context.read<MerchantOrderCubit>().acceptOrder(
                  merchantId: merchantId,
                  orderId: order.id,
                );
              }

              // Close the dialog - acceptance is in progress
              Navigator.of(dialogContext).pop();

              // Clear incoming order from state
              if (context.mounted) {
                context.read<MerchantOrderCubit>().clearIncomingOrder();
              }
            },
            onReject: () async {
              // Close the dialog first
              Navigator.of(dialogContext).pop();

              // Show rejection dialog to get reason
              final result = await showOrderRejectionDialog(context: context);

              if (result != null && context.mounted) {
                final merchantId = context
                    .read<MerchantCubit>()
                    .state
                    .mine
                    .value
                    ?.id;
                if (merchantId != null) {
                  context.read<MerchantOrderCubit>().rejectOrder(
                    merchantId: merchantId,
                    orderId: order.id,
                    reason: result.reason,
                    note: result.note,
                  );
                }

                // Clear incoming order from state
                context.read<MerchantOrderCubit>().clearIncomingOrder();

                // Show rejection toast
                showToast(
                  context: context,
                  builder: (context, overlay) => context.buildToast(
                    title: 'Order Rejected',
                    message: 'You rejected the order',
                  ),
                );
              } else if (context.mounted) {
                // User cancelled rejection, clear incoming order anyway
                context.read<MerchantOrderCubit>().clearIncomingOrder();
              }
            },
          ),
        ),
      ),
    );
  }
}
