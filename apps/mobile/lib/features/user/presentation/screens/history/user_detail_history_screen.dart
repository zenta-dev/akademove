import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDetailHistoryScreen extends StatelessWidget {
  const UserDetailHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      final orderId = context
          .read<UserOrderCubit>()
          .state
          .selectedOrder
          .value
          ?.id;
      if (orderId != null) {
        await context.read<UserOrderCubit>().maybeGet(orderId);
      }
    }

    return Scaffold(
      headers: [
        BlocBuilder<UserOrderCubit, UserOrderState>(
          builder: (context, state) {
            final order = state.selectedOrder.value ?? dummyOrder;
            return DefaultAppBar(
              title: order.status.localizedName(context),
              subtitle: order.requestedAt.format('dd MMM yyyy - HH:mm'),
              trailing: [
                DefaultText(
                  '#${generateOrderCode(order.id)}',
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ).asSkeleton(enabled: state.selectedOrder.isLoading);
          },
        ),
      ],
      child: RefreshTrigger(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.dg),
            child: BlocBuilder<UserOrderCubit, UserOrderState>(
              builder: (context, state) {
                if (state.selectedOrder.isLoading) {
                  return _buildLoadingSkeleton(context);
                }

                if (state.selectedOrder.isFailure) {
                  return Center(
                    child: OopsAlertWidget(
                      message:
                          state.selectedOrder.error?.message ??
                          'Failed to load order',
                      onRefresh: () {
                        final orderId = state.selectedOrder.value?.id;
                        if (orderId != null) {
                          context.read<UserOrderCubit>().maybeGet(orderId);
                        }
                      },
                    ),
                  );
                }

                final order = state.selectedOrder.value;
                if (order == null) {
                  return Center(
                    child: DefaultText('Order not found', fontSize: 16.sp),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Card
                    _buildStatusCard(context, order),
                    Gap(16.h),

                    // Location Card
                    _buildLocationCard(context, order),
                    Gap(16.h),

                    // Order Details Card
                    _buildOrderDetailsCard(context, order),
                    Gap(16.h),

                    // Price Breakdown Card
                    _buildPriceBreakdownCard(context, order),

                    // Driver Info Card (if assigned)
                    if (order.driverId != null && order.driver != null) ...[
                      Gap(16.h),
                      _buildDriverCard(context, order),
                    ],

                    // Merchant Info Card (for FOOD orders)
                    if (order.merchantId != null && order.merchant != null) ...[
                      Gap(16.h),
                      _buildMerchantCard(context, order),
                    ],

                    // Order Items (for FOOD orders)
                    if (order.items != null && order.items!.isNotEmpty) ...[
                      Gap(16.h),
                      _buildOrderItemsCard(context, order),
                    ],

                    // Notes Card (if any)
                    if (order.note != null) ...[
                      Gap(16.h),
                      _buildNotesCard(context, order),
                    ],

                    // Cancel Reason (if cancelled)
                    if (order.cancelReason != null) ...[
                      Gap(16.h),
                      _buildCancelReasonCard(context, order),
                    ],

                    // Action Buttons
                    Gap(24.h),
                    _buildActionButtons(context, order),
                    Gap(16.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Card(
            child: SizedBox(height: 80.h, width: double.infinity),
          ),
          Gap(16.h),
          Card(
            child: SizedBox(height: 120.h, width: double.infinity),
          ),
          Gap(16.h),
          Card(
            child: SizedBox(height: 100.h, width: double.infinity),
          ),
          Gap(16.h),
          Card(
            child: SizedBox(height: 150.h, width: double.infinity),
          ),
        ],
      ).asSkeleton(),
    );
  }

  Widget _buildStatusCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: order.status.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                order.status.icon,
                color: order.status.color,
                size: 28.sp,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    order.status.localizedName(context),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(4.h),
                  DefaultText(
                    order.type.localizedName(context),
                    fontSize: 14.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ],
              ),
            ),
            // Status indicator dot
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: order.status.isActive
                    ? Colors.green
                    : order.status.color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              'Locations',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            Gap(16.h),
            // Pickup Location
            _buildLocationRow(
              context,
              icon: LucideIcons.circle,
              iconColor: Colors.green,
              label: context.l10n.pickup_location,
              coordinate: order.pickupLocation,
            ),
            Padding(
              padding: EdgeInsets.only(left: 11.w),
              child: SizedBox(
                height: 24.h,
                child: VerticalDivider(
                  color: context.colorScheme.mutedForeground.withValues(
                    alpha: 0.3,
                  ),
                ),
              ),
            ),
            // Dropoff Location
            _buildLocationRow(
              context,
              icon: LucideIcons.mapPin,
              iconColor: Colors.red,
              label: context.l10n.dropoff_location,
              coordinate: order.dropoffLocation,
            ),
            Gap(12.h),
            Row(
              children: [
                Icon(
                  LucideIcons.route,
                  size: 16.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Gap(8.w),
                DefaultText(
                  '${order.distanceKm.toStringAsFixed(2)} km',
                  fontSize: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required Coordinate coordinate,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14.sp, color: iconColor),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                label,
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
              Gap(4.h),
              FutureBuilder(
                future: context.read<LocationService>().getPlacemark(
                  lat: coordinate.y.toDouble(),
                  lng: coordinate.x.toDouble(),
                ),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  final isLoading =
                      snapshot.connectionState != ConnectionState.done;
                  return DefaultText(
                    data != null
                        ? '${data.name}, ${data.street}'
                        : 'Loading...',
                    fontSize: 14.sp,
                  ).asSkeleton(enabled: isLoading);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailsCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              'Order Details',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            Gap(12.h),
            _buildDetailRow(
              context,
              label: context.l10n.order_id,
              value: generateOrderCode(order.id),
            ),
            _buildDetailRow(
              context,
              label: 'Order Type',
              value: order.type.localizedName(context),
            ),
            _buildDetailRow(
              context,
              label: 'Requested',
              value: order.requestedAt.format('dd MMM yyyy - HH:mm'),
            ),
            if (order.acceptedAt != null)
              _buildDetailRow(
                context,
                label: 'Accepted',
                value: order.acceptedAt!.format('dd MMM yyyy - HH:mm'),
              ),
            if (order.genderPreference != null)
              _buildDetailRow(
                context,
                label: 'Gender Preference',
                value: order.genderPreference == OrderGenderPreferenceEnum.SAME
                    ? 'Same Gender'
                    : 'Any Gender',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            label,
            fontSize: 14.sp,
            color: context.colorScheme.mutedForeground,
          ),
          Flexible(child: DefaultText(value, fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdownCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              'Price Breakdown',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            Gap(12.h),
            _buildPriceRow(
              context,
              label: 'Base Price',
              amount: order.basePrice,
            ),
            if (order.tip != null && order.tip! > 0)
              _buildPriceRow(context, label: 'Tip', amount: order.tip!),
            if (order.discountAmount != null && order.discountAmount! > 0)
              _buildPriceRow(
                context,
                label: order.couponCode != null
                    ? 'Discount (${order.couponCode})'
                    : 'Discount',
                amount: -order.discountAmount!,
                isDiscount: true,
              ),
            Divider(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  context.l10n.total,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                DefaultText(
                  context.formatCurrency(order.totalPrice),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context, {
    required String label,
    required num amount,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            label,
            fontSize: 14.sp,
            color: context.colorScheme.mutedForeground,
          ),
          DefaultText(
            isDiscount
                ? '- ${context.formatCurrency(amount.abs())}'
                : context.formatCurrency(amount),
            fontSize: 14.sp,
            color: isDiscount ? Colors.green : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(BuildContext context, Order order) {
    final driverName = order.driver?.user?.name ?? context.l10n.text_driver;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              'Driver Info',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            Gap(12.h),
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.user,
                    size: 24.sp,
                    color: context.colorScheme.primary,
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        driverName,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(4.h),
                      DefaultText(
                        context.l10n.text_driver,
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMerchantCard(BuildContext context, Order order) {
    final merchantName = order.merchant?.name ?? 'Merchant';

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              'Merchant Info',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            Gap(12.h),
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.store,
                    size: 24.sp,
                    color: context.colorScheme.primary,
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: DefaultText(
                    merchantName,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              'Order Items',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            Gap(12.h),
            ...order.items!.map(
              (item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DefaultText(
                              '${item.quantity}x',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(12.w),
                          Expanded(
                            child: DefaultText(
                              item.item.name ?? 'Item',
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item.item.price != null)
                      DefaultText(
                        context.formatCurrency(
                          item.item.price! * item.quantity,
                        ),
                        fontSize: 14.sp,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context, Order order) {
    final note = order.note;
    if (note == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText('Notes', fontSize: 16.sp, fontWeight: FontWeight.w600),
            Gap(12.h),
            if (note.pickup != null && note.pickup!.isNotEmpty)
              _buildNoteRow(context, label: 'Pickup Note', value: note.pickup!),
            if (note.dropoff != null && note.dropoff!.isNotEmpty)
              _buildNoteRow(
                context,
                label: 'Dropoff Note',
                value: note.dropoff!,
              ),
            if (note.senderName != null && note.senderName!.isNotEmpty)
              _buildNoteRow(context, label: 'Sender', value: note.senderName!),
            if (note.recevierName != null && note.recevierName!.isNotEmpty)
              _buildNoteRow(
                context,
                label: 'Receiver',
                value: note.recevierName!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            label,
            fontSize: 12.sp,
            color: context.colorScheme.mutedForeground,
          ),
          Gap(4.h),
          DefaultText(value, fontSize: 14.sp),
        ],
      ),
    );
  }

  Widget _buildCancelReasonCard(BuildContext context, Order order) {
    return Card(
      borderColor: Colors.red.withValues(alpha: 0.3),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.circleAlert, size: 18.sp, color: Colors.red),
                Gap(8.w),
                DefaultText(
                  'Cancellation Reason',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ],
            ),
            Gap(12.h),
            DefaultText(
              order.cancelReason ?? 'No reason provided',
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Order order) {
    return Column(
      children: [
        // Cancel Button (if order can be cancelled)
        if (order.status.canBeCancelled) ...[
          SizedBox(
            width: double.infinity,
            child: Button.destructive(
              onPressed: () => _showCancelDialog(context, order),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.x, size: 18.sp),
                  Gap(8.w),
                  Text(context.l10n.cancel_order),
                ],
              ),
            ),
          ),
          Gap(12.h),
        ],

        // Rate Button (for completed orders with assigned driver)
        if (order.status == OrderStatus.COMPLETED && order.driverId != null)
          SizedBox(
            width: double.infinity,
            child: Button.primary(
              onPressed: () => _navigateToRating(context, order),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.star, size: 18.sp),
                  Gap(8.w),
                  Text(context.l10n.text_rate_this_order),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _showCancelDialog(BuildContext context, Order order) async {
    final reasonController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.cancel_order),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.are_you_sure_you_want_to_cancel_this_order),
            Gap(16.h),
            TextField(
              controller: reasonController,
              placeholder: const Text('Reason (optional)'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          Button.outline(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(context.l10n.no),
          ),
          Button.destructive(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(context.l10n.yes_cancel),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final reason = reasonController.text.trim();
      final cubit = context.read<UserOrderCubit>();

      final result = await cubit.cancelOrder(
        order.id,
        reason: reason.isNotEmpty ? reason : null,
      );
      await cubit.clearActiveOrder();

      if (result != null && context.mounted) {
        context.showMyToast(
          'Order cancelled successfully',
          type: ToastType.success,
        );
      } else if (context.mounted) {
        context.showMyToast(
          cubit.state.selectedOrder.error?.message ?? 'Failed to cancel order',
          type: ToastType.failed,
        );
      }
    }

    reasonController.dispose();
  }

  Future<void> _navigateToRating(BuildContext context, Order order) async {
    final result = await context.pushNamed(
      Routes.userRating.name,
      extra: {
        'orderId': order.id,
        'driverId': order.driverId!,
        'driverName': order.driver?.user?.name ?? context.l10n.text_driver,
      },
    );

    if (result == true && context.mounted) {
      context.showMyToast(
        context.l10n.text_thank_you_rating,
        type: ToastType.success,
      );
    }
  }
}
