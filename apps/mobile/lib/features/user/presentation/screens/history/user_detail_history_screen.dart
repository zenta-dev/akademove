import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDetailHistoryScreen extends StatefulWidget {
  const UserDetailHistoryScreen({super.key, this.action});

  /// Optional action to perform when order is loaded.
  /// Supported actions: 'rate' - auto-open rating dialog
  final String? action;

  @override
  State<UserDetailHistoryScreen> createState() =>
      _UserDetailHistoryScreenState();
}

class _UserDetailHistoryScreenState extends State<UserDetailHistoryScreen> {
  bool _hasTriggeredAction = false;

  @override
  void initState() {
    super.initState();
    // Check if order is already loaded and trigger review status check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final order = context.read<UserOrderCubit>().state.selectedOrder.value;
      if (order != null) {
        _handleAutoAction(order);
      }
    });
  }

  Future<void> _onRefresh() async {
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

  void _handleAutoAction(Order order) {
    // Always check review status for completed orders with a driver
    if (order.status == OrderStatus.COMPLETED && order.driverId != null) {
      context.read<UserReviewCubit>().checkReviewStatus(order.id);
    }

    if (_hasTriggeredAction) return;
    if (widget.action == null) return;

    switch (widget.action) {
      case 'rate':
        // Auto-open rating dialog if order is completed and has a driver
        if (order.status == OrderStatus.COMPLETED && order.driverId != null) {
          _hasTriggeredAction = true;
          // Use post-frame callback to avoid building during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _navigateToRating(context, order);
            }
          });
        }
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: BlocListener<UserOrderCubit, UserOrderState>(
        listenWhen: (previous, current) {
          // Listen when order transitions from loading to success
          return previous.selectedOrder.isLoading &&
              current.selectedOrder.isSuccess &&
              current.selectedOrder.value != null;
        },
        listener: (context, state) {
          final order = state.selectedOrder.value;
          if (order != null) {
            _handleAutoAction(order);
          }
        },
        child: SafeRefreshTrigger(
          onRefresh: _onRefresh,
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

                      // Order Timeline
                      OrderTimelineWidget(order: order),
                      Gap(16.h),

                      // Delivery Info (for DELIVERY orders)
                      if (order.type == OrderType.DELIVERY)
                        DeliveryInfoWidget(order: order),
                      if (order.type == OrderType.DELIVERY) Gap(16.h),

                      // Price Breakdown Card
                      _buildPriceBreakdownCard(context, order),

                      // Driver Info Card (if assigned)
                      if (order.driverId != null && order.driver != null) ...[
                        Gap(16.h),
                        _buildDriverCard(context, order),
                      ],

                      // Merchant Info Card (for FOOD orders)
                      if (order.merchantId != null &&
                          order.merchant != null) ...[
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
              context.l10n.location,
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
              address: order.pickupAddress,
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
              address: order.dropoffAddress,
              coordinate: order.dropoffLocation,
            ),
            Gap(12.h),
            // Distance and estimated time
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
    String? address,
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
              if (address != null && address.isNotEmpty)
                DefaultText(address, fontSize: 14.sp)
              else
                AddressText(
                  address: null,
                  coordinate: coordinate,
                  style: context.typography.p.copyWith(fontSize: 14.sp),
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
              context.l10n.order_detail_summary,
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
              label: context.l10n.order_type_ride_label,
              value: order.type.localizedName(context),
            ),
            _buildDetailRow(
              context,
              label: context.l10n.distance,
              value: '${order.distanceKm.toStringAsFixed(2)} km',
            ),
            _buildDetailRow(
              context,
              label: context.l10n.order_time,
              value: order.requestedAt.format('dd MMM yyyy - HH:mm'),
            ),
            // Scheduled order info
            if (order.scheduledAt != null)
              _buildDetailRow(
                context,
                label: context.l10n.scheduled,
                value: order.scheduledAt!.format('dd MMM yyyy - HH:mm'),
                valueColor: const Color(0xFF00BCD4),
              ),
            if (order.acceptedAt != null)
              _buildDetailRow(
                context,
                label: context.l10n.accepted,
                value: order.acceptedAt!.format('dd MMM yyyy - HH:mm'),
              ),
            // Completion time
            if (order.status == OrderStatus.COMPLETED &&
                order.updatedAt != order.createdAt)
              _buildDetailRow(
                context,
                label: context.l10n.completed,
                value: order.updatedAt.format('dd MMM yyyy - HH:mm'),
                valueColor: const Color(0xFF4CAF50),
              ),
            // Gender preference
            if (order.genderPreference != null)
              _buildDetailRow(
                context,
                label: context.l10n.gender_preference,
                value: order.genderPreference == OrderGenderPreferenceEnum.SAME
                    ? 'Same Gender'
                    : 'Any',
              ),
            // Payment method
            _buildDetailRow(
              context,
              label: context.l10n.label_payment_method,
              value: context.l10n.payment_method_wallet,
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
    Color? valueColor,
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
          Flexible(
            child: DefaultText(value, fontSize: 14.sp, color: valueColor),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdownCard(BuildContext context, Order order) {
    // Calculate menu items total for FOOD orders
    final menuItemsTotal = order.type == OrderType.FOOD && order.items != null
        ? order.items!.fold<num>(
            0,
            (sum, item) => sum + (item.item.price ?? 0) * item.quantity,
          )
        : 0;

    // Delivery fee for FOOD orders = totalPrice - menuItemsTotal + discountAmount
    final deliveryFee = order.type == OrderType.FOOD
        ? order.totalPrice - menuItemsTotal + (order.discountAmount ?? 0)
        : 0;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              context.l10n.label_payment_summary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            Gap(12.h),

            // For FOOD orders, show menu items total and delivery fee separately
            if (order.type == OrderType.FOOD) ...[
              _buildPriceRow(
                context,
                label: 'Menu Items',
                amount: menuItemsTotal,
              ),
              _buildPriceRow(
                context,
                label: 'Delivery Fee',
                amount: deliveryFee,
              ),
            ] else ...[
              // For RIDE/DELIVERY, show base price
              _buildPriceRow(
                context,
                label: context.l10n.base_price,
                amount: order.basePrice,
              ),
            ],

            if (order.tip != null && order.tip! > 0)
              _buildPriceRow(context, label: 'Tip', amount: order.tip!),

            if (order.discountAmount != null && order.discountAmount! > 0)
              _buildPriceRow(
                context,
                label: order.couponCode != null
                    ? '${context.l10n.label_discount} (${order.couponCode})'
                    : context.l10n.label_discount,
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

            // Show commission breakdown for completed orders (transparent fee disclosure)
            if (order.status == OrderStatus.COMPLETED &&
                order.platformCommission != null) ...[
              Gap(16.h),
              Divider(height: 1.h),
              Gap(16.h),
              DefaultText(
                context.l10n.fee_breakdown,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.mutedForeground,
              ),
              Gap(8.h),
              _buildPriceRow(
                context,
                label: context.l10n.platform_fee,
                amount: order.platformCommission!,
                isMuted: true,
              ),
              if (order.driverEarning != null)
                _buildPriceRow(
                  context,
                  label: context.l10n.driver_receives,
                  amount: order.driverEarning!,
                  isMuted: true,
                ),
              // Show merchant fees for FOOD orders (merchants involved)
              if (order.type == OrderType.FOOD &&
                  order.merchantCommission != null &&
                  order.merchantCommission! > 0)
                _buildPriceRow(
                  context,
                  label: context.l10n.merchant_fee,
                  amount: order.merchantCommission!,
                  isMuted: true,
                ),
              if (order.type == OrderType.FOOD && order.merchantEarning != null)
                _buildPriceRow(
                  context,
                  label: context.l10n.merchant_receives,
                  amount: order.merchantEarning!,
                  isMuted: true,
                ),
            ],

            Gap(12.h),
            // Payment status indicator
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    LucideIcons.circleCheck,
                    size: 16.sp,
                    color: const Color(0xFF4CAF50),
                  ),
                  Gap(8.w),
                  DefaultText(
                    context.l10n.payment_method_wallet,
                    fontSize: 14.sp,
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
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
    bool isMuted = false,
  }) {
    final textColor = isDiscount
        ? Colors.green
        : isMuted
        ? context.colorScheme.mutedForeground
        : null;

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
            color: textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(BuildContext context, Order order) {
    final driver = order.driver;
    final driverUser = driver?.user;
    final driverName = driverUser?.name ?? context.l10n.text_driver;
    final driverImage = driverUser?.image;
    final driverRating = driver?.rating;
    final licensePlate = driver?.licensePlate;

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
                // Driver avatar with image support
                if (driverImage != null && driverImage.isNotEmpty)
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: driverImage,
                      width: 56.w,
                      height: 56.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 56.w,
                        height: 56.w,
                        color: context.colorScheme.muted,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 56.w,
                        height: 56.w,
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.user,
                          size: 28.sp,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.user,
                      size: 28.sp,
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
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(4.h),
                      Row(
                        children: [
                          // Rating
                          if (driverRating != null && driverRating > 0) ...[
                            Icon(
                              LucideIcons.star,
                              size: 14.sp,
                              color: const Color(0xFFFFC107),
                            ),
                            Gap(4.w),
                            DefaultText(
                              driverRating.toStringAsFixed(1),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            Gap(8.w),
                            Container(
                              width: 4.w,
                              height: 4.w,
                              decoration: BoxDecoration(
                                color: context.colorScheme.mutedForeground,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Gap(8.w),
                          ],
                          DefaultText(
                            context.l10n.text_driver,
                            fontSize: 13.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Vehicle info (license plate)
            if (licensePlate != null && licensePlate.isNotEmpty) ...[
              Gap(12.h),
              Divider(color: context.colorScheme.border.withValues(alpha: 0.5)),
              Gap(12.h),
              Row(
                children: [
                  Icon(
                    LucideIcons.bike,
                    size: 18.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                  Gap(8.w),
                  DefaultText(
                    'License Plate',
                    fontSize: 13.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                  Gap(8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.muted,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: DefaultText(
                      licensePlate,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
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

  Widget _buildMerchantCard(BuildContext context, Order order) {
    final merchant = order.merchant;
    final merchantName = merchant?.name ?? 'Merchant';
    final merchantImage = merchant?.image;
    final merchantRating = merchant?.rating;
    final merchantAddress = merchant?.address;
    final merchantCategory = merchant?.category;

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
                // Merchant image
                if (merchantImage != null && merchantImage.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CachedNetworkImage(
                      imageUrl: merchantImage,
                      width: 56.w,
                      height: 56.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 56.w,
                        height: 56.w,
                        color: context.colorScheme.muted,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 56.w,
                        height: 56.w,
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          LucideIcons.store,
                          size: 28.sp,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      LucideIcons.store,
                      size: 28.sp,
                      color: context.colorScheme.primary,
                    ),
                  ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        merchantName,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(4.h),
                      Row(
                        children: [
                          // Rating
                          if (merchantRating != null && merchantRating > 0) ...[
                            Icon(
                              LucideIcons.star,
                              size: 14.sp,
                              color: const Color(0xFFFFC107),
                            ),
                            Gap(4.w),
                            DefaultText(
                              merchantRating.toStringAsFixed(1),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            Gap(8.w),
                            Container(
                              width: 4.w,
                              height: 4.w,
                              decoration: BoxDecoration(
                                color: context.colorScheme.mutedForeground,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Gap(8.w),
                          ],
                          // Category
                          if (merchantCategory != null)
                            Flexible(
                              child: DefaultText(
                                merchantCategory.name,
                                fontSize: 13.sp,
                                color: context.colorScheme.mutedForeground,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Address
            if (merchantAddress != null && merchantAddress.isNotEmpty) ...[
              Gap(12.h),
              Divider(color: context.colorScheme.border.withValues(alpha: 0.5)),
              Gap(12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    LucideIcons.mapPin,
                    size: 16.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                  Gap(8.w),
                  Expanded(
                    child: DefaultText(
                      merchantAddress,
                      fontSize: 13.sp,
                      color: context.colorScheme.mutedForeground,
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

  /// Build the review section that shows either existing review or rate button
  Widget _buildReviewSection(BuildContext context, Order order) {
    // Only show for completed orders with a driver
    if (order.status != OrderStatus.COMPLETED || order.driverId == null) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<UserReviewCubit, UserReviewState>(
      builder: (context, state) {
        // Show loading state while fetching review status (including initial idle state)
        if (state.reviewStatus.isIdle || state.reviewStatus.isLoading) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                  Gap(12.w),
                  DefaultText(
                    context.l10n.loading,
                    fontSize: 14.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ],
              ),
            ),
          );
        }

        // Show error state with retry
        if (state.reviewStatus.isFailure) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Icon(
                    LucideIcons.circleAlert,
                    size: 24.sp,
                    color: context.colorScheme.destructive,
                  ),
                  Gap(8.h),
                  Text(
                    state.reviewStatus.error?.message ??
                        context.l10n.error_generic,
                    textAlign: TextAlign.center,
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                  Gap(12.h),
                  Button.outline(
                    onPressed: () => context
                        .read<UserReviewCubit>()
                        .checkReviewStatus(order.id),
                    child: Text(context.l10n.button_retry),
                  ),
                ],
              ),
            ),
          );
        }

        final reviewStatus = state.reviewStatus.value;

        // If already reviewed, show existing review card
        if (reviewStatus != null &&
            reviewStatus.alreadyReviewed &&
            reviewStatus.existingReview != null) {
          return _buildExistingReviewCard(
            context,
            reviewStatus.existingReview!,
          );
        }

        // Otherwise show the "Rate this order" button
        return SizedBox(
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
        );
      },
    );
  }

  /// Build existing review card showing the user's submitted review
  Widget _buildExistingReviewCard(BuildContext context, Review review) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with badge
            Row(
              children: [
                Icon(
                  LucideIcons.circleCheck,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Gap(8.w),
                Expanded(
                  child: DefaultText(
                    context.l10n.text_already_reviewed,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Gap(16.h),

            // Star rating display
            _buildExistingRatingStars(context, review.score),
            Gap(12.h),

            // Categories display
            if (review.categories.isNotEmpty) ...[
              _buildExistingCategoriesChips(context, review.categories),
              Gap(12.h),
            ],

            // Comment display (if any)
            if (review.comment != null && review.comment!.isNotEmpty) ...[
              _buildExistingCommentDisplay(context, review.comment!),
              Gap(12.h),
            ],

            // Review date
            Divider(color: context.colorScheme.border.withValues(alpha: 0.5)),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.calendar,
                  size: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Gap(8.w),
                DefaultText(
                  context.l10n.text_reviewed_on(
                    review.createdAt.format('d MMM yyyy'),
                  ),
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExistingRatingStars(BuildContext context, int score) {
    return Row(
      children: [
        Flexible(
          child: DefaultText(
            context.l10n.text_your_rating,
            fontSize: 14.sp,
            color: context.colorScheme.mutedForeground,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Gap(12.w),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            final starValue = index + 1;
            return Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Icon(
                LucideIcons.star,
                size: 18.sp,
                color: starValue <= score
                    ? const Color(0xFFFFA000)
                    : context.colorScheme.mutedForeground,
                fill: starValue <= score ? 1.0 : 0.0,
              ),
            );
          }),
        ),
        Gap(8.w),
        Flexible(
          child: DefaultText(
            _getRatingLabel(context, score),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.primary,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildExistingCategoriesChips(
    BuildContext context,
    List<ReviewCategory> categories,
  ) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: categories.map((category) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: context.colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getCategoryIcon(category),
                size: 12.sp,
                color: context.colorScheme.primary,
              ),
              Gap(6.w),
              DefaultText(
                _getCategoryLabel(context, category),
                fontSize: 12.sp,
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExistingCommentDisplay(BuildContext context, String comment) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.muted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.quote,
            size: 16.sp,
            color: context.colorScheme.mutedForeground,
          ),
          Gap(10.w),
          Expanded(
            child: Text(
              comment,
              style: context.typography.small.copyWith(
                fontSize: 13.sp,
                fontStyle: FontStyle.italic,
                color: context.colorScheme.foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return LucideIcons.sparkles;
      case ReviewCategory.COURTESY:
        return LucideIcons.heart;
      case ReviewCategory.PUNCTUALITY:
        return LucideIcons.clock;
      case ReviewCategory.SAFETY:
        return LucideIcons.shield;
      case ReviewCategory.COMMUNICATION:
        return LucideIcons.messageCircle;
      case ReviewCategory.OTHER:
        return LucideIcons.star;
    }
  }

  String _getCategoryLabel(BuildContext context, ReviewCategory category) {
    switch (category) {
      case ReviewCategory.CLEANLINESS:
        return context.l10n.category_cleanliness;
      case ReviewCategory.COURTESY:
        return context.l10n.category_courtesy;
      case ReviewCategory.PUNCTUALITY:
        return context.l10n.category_punctuality;
      case ReviewCategory.SAFETY:
        return context.l10n.category_safety;
      case ReviewCategory.COMMUNICATION:
        return context.l10n.category_communication;
      case ReviewCategory.OTHER:
        return context.l10n.category_overall;
    }
  }

  String _getRatingLabel(BuildContext context, int rating) {
    switch (rating) {
      case 1:
        return context.l10n.rating_poor;
      case 2:
        return context.l10n.rating_below_average;
      case 3:
        return context.l10n.rating_average;
      case 4:
        return context.l10n.rating_good;
      case 5:
        return context.l10n.rating_excellent;
      default:
        return '';
    }
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

        // Review section (for completed orders with assigned driver)
        // Shows existing review if already reviewed, or rate button if not
        _buildReviewSection(context, order),
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
    // Use driver's userId (not driverId) for review submission
    // The server validates that toUserId matches the driver's userId
    final driverUserId = order.driver?.userId;
    if (driverUserId == null) {
      context.showMyToast(context.l10n.error_generic, type: ToastType.failed);
      return;
    }

    final result = await context.pushNamed(
      Routes.userRating.name,
      extra: {
        'orderId': order.id,
        'driverId': driverUserId,
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
