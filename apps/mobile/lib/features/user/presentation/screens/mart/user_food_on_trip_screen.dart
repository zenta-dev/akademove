import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Food order tracking screen with merchant-specific status updates.
/// Shows the full FOOD order flow:
/// REQUESTED → ACCEPTED (merchant) → PREPARING → READY_FOR_PICKUP → MATCHING → ACCEPTED (driver) → ARRIVING → IN_TRIP → COMPLETED
class UserFoodOnTripScreen extends StatefulWidget {
  const UserFoodOnTripScreen({super.key});

  @override
  State<UserFoodOnTripScreen> createState() => _UserFoodOnTripScreenState();
}

class _UserFoodOnTripScreenState extends State<UserFoodOnTripScreen> {
  GoogleMapController? _mapController;
  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _pickupIcon;
  BitmapDescriptor? _dropoffIcon;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkerIcons();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadCustomMarkerIcons() async {
    try {
      final driverBitmap = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(64, 64)),
        Assets.images.motorcycleAbove.path,
      );

      setState(() {
        _driverIcon = driverBitmap;
      });
    } catch (e) {
      logger.e('[UserFoodOnTripScreen] - Error loading marker icons: $e');
    }
  }

  Future<void> _updateMapWithOrderData(UserOrderState state) async {
    final locationCubit = context.read<UserLocationCubit>();
    final driver = state.currentAssignedDriver.value;
    final order = state.currentOrder.value;

    if (order == null) return;

    final pickupLat = order.pickupLocation.y.toDouble();
    final pickupLng = order.pickupLocation.x.toDouble();
    final dropoffLat = order.dropoffLocation.y.toDouble();
    final dropoffLng = order.dropoffLocation.x.toDouble();

    final newMarkers = <Marker>{}
      // Add merchant/pickup marker
      ..add(
        Marker(
          markerId: const MarkerId('merchant'),
          position: LatLng(pickupLat, pickupLng),
          icon:
              _pickupIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            title: context.l10n.order_confirm_merchant,
            snippet: context.l10n.text_pickup_location,
          ),
        ),
      )
      // Add delivery/dropoff marker
      ..add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: LatLng(dropoffLat, dropoffLng),
          icon:
              _dropoffIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: context.l10n.destination,
            snippet: context.l10n.text_dropoff_location,
          ),
        ),
      );

    // Add driver marker if available
    final driverLocation = driver?.currentLocation;
    if (driver != null && driverLocation != null) {
      final driverLat = driverLocation.y.toDouble();
      final driverLng = driverLocation.x.toDouble();

      newMarkers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(driverLat, driverLng),
          icon:
              _driverIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            title:
                '${context.l10n.your_driver_is} ${driver.user?.name ?? "Driver"}',
            snippet: driver.rating != 0
                ? 'Rating: ${driver.rating.toStringAsFixed(1)}'
                : 'No rating yet',
          ),
        ),
      );

      // Animate camera to show driver if this is initial load
      if (_isFirstLoad) {
        _isFirstLoad = false;
        await _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(driverLat, driverLng)),
        );
      }
    } else {
      // If no driver location, center on merchant/pickup
      if (_isFirstLoad) {
        _isFirstLoad = false;
        await _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(pickupLat, pickupLng)),
        );
      }
    }

    // Build polylines
    final newPolylines = <Polyline>{};

    if (!mounted) return;
    final color = context.colorScheme.primary;
    final deliveryCubit = context.read<UserDeliveryCubit>();

    try {
      // Get actual route from MapService via cubit
      final routeCoordinates = await deliveryCubit.getRoutes(
        order.pickupLocation,
        order.dropoffLocation,
      );

      if (routeCoordinates.isNotEmpty) {
        final routePoints = routeCoordinates
            .map((coord) => LatLng(coord.y.toDouble(), coord.x.toDouble()))
            .toList();

        newPolylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: routePoints,
            color: color,
            width: 4,
          ),
        );
      } else {
        // Fallback to straight line if no route available
        newPolylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: [
              LatLng(pickupLat, pickupLng),
              LatLng(dropoffLat, dropoffLng),
            ],
            color: color,
            width: 4,
          ),
        );
      }
    } catch (e) {
      logger.e('[UserFoodOnTripScreen] - Failed to get route: $e');
      // Fallback to straight line on error
      newPolylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: [
            LatLng(pickupLat, pickupLng),
            LatLng(dropoffLat, dropoffLng),
          ],
          color: color,
          width: 4,
        ),
      );
    }

    if (!mounted) return;

    // Update cubit with markers and polylines
    locationCubit.setMapData(markers: newMarkers, polylines: newPolylines);
  }

  /// Determines the current step index based on order status for FOOD orders.
  /// FOOD order flow:
  /// 0. REQUESTED - Waiting for merchant
  /// 1. ACCEPTED (merchant) - Merchant accepted
  /// 2. PREPARING - Merchant preparing
  /// 3. READY_FOR_PICKUP - Food ready
  /// 4. MATCHING - Finding driver
  /// 5. ACCEPTED (driver) - Driver assigned
  /// 6. ARRIVING - Driver on the way
  /// 7. IN_TRIP - Delivering
  int _getFoodStatusStep(OrderStatus? status) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return 0;
      case OrderStatus.ACCEPTED:
        // For FOOD orders, ACCEPTED means merchant accepted (before PREPARING)
        return 1;
      case OrderStatus.PREPARING:
        return 2;
      case OrderStatus.READY_FOR_PICKUP:
        return 3;
      case OrderStatus.MATCHING:
        return 4;
      // After MATCHING, the driver accepts and status goes back to ACCEPTED
      // We need to differentiate between merchant accepted and driver accepted
      // Driver accepted is when we have a driverId assigned
      case OrderStatus.ARRIVING:
        return 6;
      case OrderStatus.IN_TRIP:
        return 7;
      case OrderStatus.COMPLETED:
        return 8;
      default:
        return 0;
    }
  }

  /// Checks if the order has moved past merchant acceptance to driver phase
  bool _isInDriverPhase(Order order) {
    final status = order.status;
    return status == OrderStatus.MATCHING ||
        status == OrderStatus.ARRIVING ||
        status == OrderStatus.IN_TRIP ||
        status == OrderStatus.COMPLETED ||
        (status == OrderStatus.ACCEPTED && order.driverId != null);
  }

  Widget _buildFoodStatusIndicator(OrderStatus? status, Order? order) {
    // Define the steps for FOOD order flow
    // Using existing localization strings where available
    final merchantSteps = [
      (context.l10n.requested, 0), // Waiting for merchant
      (context.l10n.accepted, 1), // Merchant accepted
      (context.l10n.preparing, 2), // Preparing
      (context.l10n.ready_for_pickup, 3), // Ready
    ];

    final driverSteps = [
      (context.l10n.finding_driver, 4), // Finding driver
      (context.l10n.status_driver_found, 5), // Driver found
      (context.l10n.arriving, 6), // Arriving
      (context.l10n.in_trip, 7), // Delivering
    ];

    int currentStep = _getFoodStatusStep(status);

    // Special case: if status is ACCEPTED and driverId is set, it's driver accepted (step 5)
    if (status == OrderStatus.ACCEPTED && order?.driverId != null) {
      currentStep = 5;
    }

    final isInDriverPhase = order != null && _isInDriverPhase(order);

    // Show only merchant steps if not yet in driver phase, otherwise show driver steps
    final displaySteps = isInDriverPhase ? driverSteps : merchantSteps;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phase indicator
            Row(
              children: [
                Icon(
                  isInDriverPhase ? LucideIcons.truck : LucideIcons.chefHat,
                  size: 16.sp,
                  color: context.colorScheme.primary,
                ),
                Gap(8.w),
                DefaultText(
                  isInDriverPhase
                      ? context.l10n.title_delivery
                      : context.l10n.preparing_order,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ],
            ),
            Gap(12.h),
            // Status steps
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: displaySteps.map((entry) {
                final stepLabel = entry.$1;
                final stepIndex = entry.$2;
                final isActive = currentStep >= stepIndex;
                final isCurrent = currentStep == stepIndex;

                return Expanded(
                  child: Column(
                    spacing: 4.h,
                    children: [
                      Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? context.colorScheme.primary
                              : context.colorScheme.muted,
                        ),
                        child:
                            isCurrent &&
                                (status == OrderStatus.MATCHING ||
                                    status == OrderStatus.REQUESTED ||
                                    status == OrderStatus.PREPARING)
                            ? Center(
                                child: SizedBox(
                                  width: 14.w,
                                  height: 14.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color:
                                        context.colorScheme.primaryForeground,
                                  ),
                                ),
                              )
                            : isActive
                            ? Icon(
                                LucideIcons.check,
                                size: 14.sp,
                                color: context.colorScheme.primaryForeground,
                              )
                            : null,
                      ),
                      Text(
                        stepLabel,
                        style: context.typography.small.copyWith(
                          fontSize: 8.sp,
                          color: isActive
                              ? context.colorScheme.foreground
                              : context.colorScheme.mutedForeground,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMerchantInfo(Order? order) {
    if (order == null) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Avatar(size: 48.w, initials: '?'),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    DefaultText(
                      'Merchant name',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    DefaultText(context.l10n.preparing_order, fontSize: 12.sp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).asSkeleton();
    }

    // Get merchant name from order merchant if available
    final merchantName =
        order.merchant?.name ?? context.l10n.order_confirm_merchant;
    final merchantImage = order.merchant?.image;

    String getMerchantStatusText() {
      switch (order.status) {
        case OrderStatus.REQUESTED:
          return context.l10n.requested;
        case OrderStatus.ACCEPTED:
          if (order.driverId != null) {
            return context.l10n.status_driver_found;
          }
          return context.l10n.accepted;
        case OrderStatus.PREPARING:
          return context.l10n.preparing;
        case OrderStatus.READY_FOR_PICKUP:
          return context.l10n.ready_for_pickup;
        case OrderStatus.MATCHING:
          return context.l10n.finding_driver;
        default:
          return order.status.name;
      }
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Avatar(
              size: 48.w,
              initials: Avatar.getInitials(merchantName),
              provider: merchantImage != null
                  ? CachedNetworkImageProvider(merchantImage)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  DefaultText(
                    merchantName,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  Row(
                    children: [
                      Icon(
                        _getMerchantStatusIcon(order.status, order.driverId),
                        size: 14.sp,
                        color: context.colorScheme.primary,
                      ),
                      Gap(4.w),
                      DefaultText(
                        getMerchantStatusText(),
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getMerchantStatusIcon(OrderStatus status, String? driverId) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return LucideIcons.clock;
      case OrderStatus.ACCEPTED:
        if (driverId != null) return LucideIcons.userCheck;
        return LucideIcons.circleCheck;
      case OrderStatus.PREPARING:
        return LucideIcons.chefHat;
      case OrderStatus.READY_FOR_PICKUP:
        return LucideIcons.package;
      case OrderStatus.MATCHING:
        return LucideIcons.search;
      default:
        return LucideIcons.store;
    }
  }

  Widget _buildDriverInfo(
    Driver? driver,
    OrderStatus? orderStatus,
    Order? order,
  ) {
    // Only show driver info when in driver phase
    if (order == null || !_isInDriverPhase(order)) {
      return const SizedBox.shrink();
    }

    // Show finding driver state when in matching phase
    if (orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.READY_FOR_PICKUP) {
      return _buildFindingDriverState();
    }

    // Show skeleton loading if driver should be assigned but data not loaded
    if (driver == null) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Avatar(size: 48.w, initials: '?'),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    DefaultText(
                      'Driver name',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    DefaultText(
                      context.l10n.text_license_plate,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).asSkeleton();
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Avatar(
              size: 48.w,
              initials: Avatar.getInitials(driver.user?.name ?? 'Driver'),
              provider: () {
                final image = driver.user?.image;
                return image != null ? CachedNetworkImageProvider(image) : null;
              }(),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  DefaultText(
                    driver.user?.name ?? 'Driver',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  DefaultText(
                    driver.licensePlate,
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                  if (driver.rating != 0)
                    Row(
                      spacing: 4.w,
                      children: [
                        Icon(
                          LucideIcons.star,
                          size: 14.sp,
                          color: context.colorScheme.primary,
                        ),
                        DefaultText(
                          driver.rating.toStringAsFixed(1),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFindingDriverState() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 12.h,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      DefaultText(
                        context.l10n.text_finding_driver,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                      DefaultText(
                        context.l10n.text_finding_driver_message,
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

  Widget _buildCell(String title, String value, {bool allowMultiline = false}) {
    if (allowMultiline) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.h,
        children: [
          Text(
            title,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          Text(
            value,
            style: context.typography.small.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: context.colorScheme.foreground,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultText(title, fontSize: 14.sp),
        Flexible(
          child: Text(
            value,
            style: context.typography.small.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: context.colorScheme.foreground,
            ),
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItemsList(Order? order) {
    if (order == null || order.items == null || order.items!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        DefaultText(
          context.l10n.order_items,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        Card(
          child: Column(
            children: order.items!.asMap().entries.map((entry) {
              final index = entry.key;
              final orderItem = entry.value;
              final item = orderItem.item;
              final isLast = index == order.items!.length - 1;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      children: [
                        // Item image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: item.image != null
                              ? CachedNetworkImage(
                                  imageUrl: item.image!,
                                  width: 40.w,
                                  height: 40.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: context.colorScheme.muted,
                                    child: Icon(
                                      LucideIcons.utensils,
                                      size: 20.sp,
                                      color:
                                          context.colorScheme.mutedForeground,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        color: context.colorScheme.muted,
                                        child: Icon(
                                          LucideIcons.utensils,
                                          size: 20.sp,
                                          color: context
                                              .colorScheme
                                              .mutedForeground,
                                        ),
                                      ),
                                )
                              : Container(
                                  width: 40.w,
                                  height: 40.w,
                                  color: context.colorScheme.muted,
                                  child: Icon(
                                    LucideIcons.utensils,
                                    size: 20.sp,
                                    color: context.colorScheme.mutedForeground,
                                  ),
                                ),
                        ),
                        Gap(12.w),
                        // Item details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                item.name ?? context.l10n.unknown_item,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                              DefaultText(
                                '${orderItem.quantity}x @ ${context.formatCurrency(item.price ?? 0)}',
                                fontSize: 12.sp,
                                color: context.colorScheme.mutedForeground,
                              ),
                            ],
                          ),
                        ),
                        // Item total
                        DefaultText(
                          context.formatCurrency(
                            (item.price ?? 0) * orderItem.quantity,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) const Divider(height: 1),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails(UserOrderState state) {
    final order = state.currentOrder.value;
    final payment = state.currentPayment.value;

    String getPaymentMethodDisplay() {
      if (payment == null) return '-';

      switch (payment.method) {
        case PaymentMethod.wallet:
          return 'wallet';
        case PaymentMethod.QRIS:
          return 'QRIS';
        case PaymentMethod.BANK_TRANSFER:
          final bankName = payment.bankProvider?.name ?? '';
          return 'Bank Transfer${bankName.isNotEmpty ? ' ($bankName)' : ''}';
      }
    }

    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          context.l10n.text_order_details,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        Card(
          child: Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCell(
                context.l10n.label_payment_method_lower,
                getPaymentMethodDisplay(),
              ),
              const Divider(),
              _buildCell(
                context.l10n.label_total_price,
                order != null ? context.formatCurrency(order.totalPrice) : '-',
              ),
              const Divider(),
              _buildCell(context.l10n.label_status, order?.status.name ?? '-'),
            ],
          ),
        ).asSkeleton(enabled: order == null),
      ],
    );
  }

  Widget _buildBody(BuildContext context, UserOrderState state) {
    final order = state.currentOrder.value;
    final orderStatus = order?.status;
    final isInDriverPhase = order != null && _isInDriverPhase(order);

    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Food status progress indicator
        _buildFoodStatusIndicator(orderStatus, order),

        // Merchant info section (always show for FOOD orders)
        if (!isInDriverPhase) ...[
          DefaultText(
            context.l10n.order_confirm_merchant,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
          _buildMerchantInfo(order),
        ],

        // Driver info section (only show when in driver phase)
        if (isInDriverPhase) ...[
          DefaultText(
            context.l10n.text_your_driver_title,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
          _buildDriverInfo(
            state.currentAssignedDriver.value,
            orderStatus,
            order,
          ),
        ],

        // Order items
        _buildOrderItemsList(order),

        // Order details
        _buildOrderDetails(state),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: false,
      padding: EdgeInsets.zero,
      headers: [DefaultAppBar(title: context.l10n.order_type_food)],
      body: BlocListener<UserOrderCubit, UserOrderState>(
        listener: (context, state) async {
          await _updateMapWithOrderData(state);

          final currentOrder = state.currentOrder.value;

          if (currentOrder?.status == OrderStatus.COMPLETED &&
              mounted &&
              context.mounted) {
            // Navigate to rating/review screen
            final driver = state.currentAssignedDriver.value;
            if (driver != null && currentOrder != null) {
              final result = await context.pushNamed(
                Routes.userRating.name,
                extra: {
                  'orderId': currentOrder.id,
                  'driverId': driver.userId,
                  'driverName': driver.user?.name ?? 'Driver',
                },
              );

              // If rating was submitted successfully, show success message
              if (result == true && mounted && context.mounted) {
                context.showMyToast(
                  context.l10n.text_trip_completed,
                  type: ToastType.success,
                );
                // Go back to home
                context.goNamed(Routes.userHome.name);
              }
            } else {
              context.showMyToast(
                context.l10n.text_trip_completed,
                type: ToastType.success,
              );
              context.goNamed(Routes.userHome.name);
            }
          } else if ((currentOrder?.status == OrderStatus.CANCELLED_BY_USER ||
                  currentOrder?.status == OrderStatus.CANCELLED_BY_DRIVER ||
                  currentOrder?.status == OrderStatus.CANCELLED_BY_SYSTEM ||
                  currentOrder?.status == OrderStatus.CANCELLED_BY_MERCHANT) &&
              mounted &&
              context.mounted) {
            context.showMyToast(
              context.l10n.text_trip_canceled,
              type: ToastType.failed,
            );
            // Go back to home on cancellation
            context.goNamed(Routes.userHome.name);
          }
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 250.h,
              child: Stack(
                children: [
                  BlocBuilder<UserLocationCubit, UserLocationState>(
                    buildWhen: (previous, current) =>
                        previous.markers != current.markers ||
                        previous.polylines != current.polylines,
                    builder: (context, locationState) {
                      return MapWrapperWidget(
                        onMapCreated: (controller) {
                          _mapController = controller;
                          setState(() {});
                          // Initial map update
                          final state = context.read<UserOrderCubit>().state;
                          _updateMapWithOrderData(state);
                          setState(() {});
                        },
                        markers: locationState.markers,
                        polylines: locationState.polylines,
                        myLocationEnabled: true,
                      );
                    },
                  ),
                  if (_mapController == null)
                    Positioned.fill(
                      child: Container(
                        color: context.colorScheme.mutedForeground,
                      ).asSkeleton(),
                    ),
                  // Emergency button - only show during IN_TRIP status
                  BlocBuilder<UserOrderCubit, UserOrderState>(
                    builder: (context, state) {
                      final order = state.currentOrder.value;
                      if (order == null ||
                          order.status != OrderStatus.IN_TRIP) {
                        return const SizedBox.shrink();
                      }

                      // Get current location from driver or order
                      final driverLocation =
                          state.currentAssignedDriver.value?.currentLocation;
                      final emergencyLocation = driverLocation != null
                          ? EmergencyLocation(
                              latitude: driverLocation.y.toDouble(),
                              longitude: driverLocation.x.toDouble(),
                            )
                          : EmergencyLocation(
                              latitude: order.pickupLocation.y.toDouble(),
                              longitude: order.pickupLocation.x.toDouble(),
                            );

                      return Positioned(
                        bottom: 16,
                        right: 16,
                        child: EmergencyButton(
                          orderId: order.id,
                          currentLocation: emergencyLocation,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: BlocBuilder<UserOrderCubit, UserOrderState>(
                  builder: _buildBody,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
