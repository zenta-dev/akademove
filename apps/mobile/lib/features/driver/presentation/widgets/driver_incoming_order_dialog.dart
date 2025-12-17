import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog that displays incoming order notifications to the driver
/// Shows order details and provides Accept/Reject actions
class DriverIncomingOrderDialog extends StatelessWidget {
  const DriverIncomingOrderDialog({
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
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 400.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Customer info with rating
              if (order.user != null) ...[
                _buildCustomerInfoRow(context),
                SizedBox(height: 12.h),
              ],

              // Order Details
              _buildLocationDetailRow(
                context,
                icon: LucideIcons.mapPin,
                label: 'Pickup',
                address: order.pickupAddress,
                coordinate: order.pickupLocation,
              ),
              SizedBox(height: 12.h),
              _buildLocationDetailRow(
                context,
                icon: LucideIcons.navigation,
                label: 'Dropoff',
                address: order.dropoffAddress,
                coordinate: order.dropoffLocation,
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
                value:
                    'Rp ${_formatMoney(order.estimatedDriverEarning ?? order.driverEarning ?? order.totalPrice)}',
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
                                      color:
                                          context.colorScheme.mutedForeground,
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

              // Delivery item photo (only for DELIVERY orders)
              if (order.type == OrderType.DELIVERY &&
                  order.deliveryItemPhotoUrl != null) ...[
                SizedBox(height: 12.h),
                _buildDeliveryItemPhotoSection(context),
              ],
            ],
          ),
        ),
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

  Widget _buildCustomerInfoRow(BuildContext context) {
    final user = order.user;
    if (user == null) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          LucideIcons.user,
          size: 20.sp,
          color: context.colorScheme.mutedForeground,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: context.typography.small.copyWith(
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      user.name ?? 'Unknown',
                      style: context.typography.p.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (user.rating != null && user.rating != 0) ...[
                    SizedBox(width: 8.w),
                    Icon(
                      LucideIcons.star,
                      size: 14.sp,
                      color: const Color(0xFFFFC107),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      user.rating!.toStringAsFixed(1),
                      style: context.typography.small.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the delivery item photo section for DELIVERY orders
  Widget _buildDeliveryItemPhotoSection(BuildContext context) {
    final photoUrl = order.deliveryItemPhotoUrl;
    if (photoUrl == null) return const SizedBox.shrink();

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
                LucideIcons.camera,
                size: 16.sp,
                color: context.colorScheme.mutedForeground,
              ),
              SizedBox(width: 8.w),
              Text(
                'Item Photo',
                style: context.typography.small.copyWith(
                  color: context.colorScheme.mutedForeground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => _showFullImageDialog(context, photoUrl),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: photoUrl,
                height: 100.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 100.h,
                  color: context.colorScheme.muted,
                  child: const Center(
                    child: CircularProgressIndicator(size: 20),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 100.h,
                  color: context.colorScheme.muted,
                  child: Center(
                    child: Icon(
                      LucideIcons.imageOff,
                      size: 24.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Tap to view full image',
            style: context.typography.small.copyWith(
              fontSize: 10.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  /// Shows a full-screen dialog with the item photo
  void _showFullImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (dialogContext) => GestureDetector(
        onTap: () => Navigator.of(dialogContext).pop(),
        child: Container(
          color: Colors.black.withValues(alpha: 0.9),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(LucideIcons.imageOff, size: 48),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 48,
                right: 16,
                child: IconButton(
                  icon: Icon(LucideIcons.x, color: Colors.white, size: 28.sp),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  variance: ButtonVariance.ghost,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget that listens to DriverHomeCubit and shows incoming order dialog
class DriverIncomingOrderListener extends StatelessWidget {
  const DriverIncomingOrderListener({required this.child, super.key});

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
        // Listen for successful order acceptance or failure
        BlocListener<DriverOrderCubit, DriverOrderState>(
          listenWhen: (previous, current) {
            // Listen for acceptance result changes
            return previous.acceptOrderResult != current.acceptOrderResult;
          },
          listener: (context, state) {
            // Handle success - navigate to order detail
            if (state.acceptOrderResult.isSuccess) {
              final currentOrder = state.currentOrder;
              if (currentOrder != null) {
                context.pushNamed(
                  Routes.driverOrderDetail.name,
                  pathParameters: {'orderId': currentOrder.id},
                );
              }
            }

            // Handle failure - show error toast
            if (state.acceptOrderResult.isFailed) {
              showToast(
                context: context,
                builder: (context, overlay) => context.buildToast(
                  title: 'Error',
                  message:
                      state.acceptOrderResult.error?.message ??
                      'Failed to accept order. Please try again.',
                ),
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
          child: DriverIncomingOrderDialog(
            order: order,
            onAccept: () {
              // Just trigger the accept action
              // The parent BlocListener for DriverOrderCubit (lines 322-333) will
              // handle navigation when currentOrder is set on successful acceptance
              context.read<DriverOrderCubit>().acceptOrder(
                order.id,
                context.read<DriverProfileCubit>().driver?.id ?? '',
              );

              // Close the dialog - acceptance is in progress
              Navigator.of(dialogContext).pop();

              // Clear incoming order from state
              if (context.mounted) {
                context.read<DriverHomeCubit>().clearIncomingOrder();
              }
            },
            onReject: () {
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

                // Reject the order in background (fire and forget)
                context.read<DriverOrderCubit>().rejectOrder(order.id);
              }
            },
          ),
        ),
      ),
    );
  }
}
