import "package:akademove/app/router/router.dart";
import "package:akademove/core/_export.dart";
import "package:akademove/features/features.dart";
import "package:akademove/l10n/l10n.dart";
import "package:api_client/api_client.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// Merchant/Mart order tracking screen with merchant-specific status updates.
/// Shows the full merchant order flow:
/// REQUESTED → ACCEPTED (merchant) → PREPARING → READY_FOR_PICKUP → MATCHING → ACCEPTED (driver) → ARRIVING → IN_TRIP → COMPLETED
class UserMartOnTripScreen extends StatefulWidget {
  const UserMartOnTripScreen({super.key});

  @override
  State<UserMartOnTripScreen> createState() => _UserMartOnTripScreenState();
}

class _UserMartOnTripScreenState extends State<UserMartOnTripScreen> {
  GoogleMapController? _mapController;
  bool _isFirstLoad = true;
  bool _isUpdatingMap = false;

  /// Animated driver marker for smooth location updates
  late final AnimatedDriverMarker _animatedDriverMarker;

  @override
  void initState() {
    super.initState();
    _animatedDriverMarker = AnimatedDriverMarker(
      onMarkerUpdated: _onDriverMarkerUpdated,
    );
    _initMarkerIcons();

    // Initial map update after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final state = context.read<UserOrderCubit>().state;
        _updateMapWithOrderData(state);
      }
    });
  }

  @override
  void dispose() {
    _animatedDriverMarker.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  /// Initialize marker icons including the animated driver marker
  Future<void> _initMarkerIcons() async {
    await _animatedDriverMarker.loadDriverIcon();
  }

  /// Callback when the animated driver marker position updates
  void _onDriverMarkerUpdated(Marker driverMarker) {
    if (!mounted) return;

    final locationCubit = context.read<UserLocationCubit>();
    final currentMarkers = locationCubit.state.markers;

    // Replace/add driver marker while keeping other markers
    final newMarkers =
        currentMarkers.where((m) => m.markerId.value != "driver").toSet()
          ..add(driverMarker);

    locationCubit.setMarkers(newMarkers);

    // Follow driver on map during initial load
    if (_isFirstLoad) {
      _isFirstLoad = false;
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(driverMarker.position),
      );
    }
  }

  Future<void> _updateMapWithOrderData(UserOrderState state) async {
    // Prevent concurrent updates
    if (_isUpdatingMap) return;
    _isUpdatingMap = true;

    try {
      final locationCubit = context.read<UserLocationCubit>();
      final driver = state.currentAssignedDriver.value;
      final order = state.currentOrder.value;

      if (order == null) {
        _isUpdatingMap = false;
        return;
      }

      final pickupLat = order.pickupLocation.y.toDouble();
      final pickupLng = order.pickupLocation.x.toDouble();
      final dropoffLat = order.dropoffLocation.y.toDouble();
      final dropoffLng = order.dropoffLocation.x.toDouble();

      final newMarkers = <Marker>{
        // Merchant/pickup marker
        Marker(
          markerId: const MarkerId("merchant"),
          position: LatLng(pickupLat, pickupLng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: context.l10n.order_confirm_merchant,
            snippet: context.l10n.text_pickup_location,
          ),
        ),
        // Delivery/dropoff marker
        Marker(
          markerId: const MarkerId("dropoff"),
          position: LatLng(dropoffLat, dropoffLng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: context.l10n.destination,
            snippet: context.l10n.text_dropoff_location,
          ),
        ),
      };

      // Update driver marker with animation if driver location is available
      final driverLocation = driver?.currentLocation;
      if (driver != null && driverLocation != null) {
        _animatedDriverMarker.updateDriverLocation(
          driverLocation,
          driver: driver,
        );

        // Center on driver location if first load
        if (_isFirstLoad) {
          _isFirstLoad = false;
          await _mapController?.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(driverLocation.y.toDouble(), driverLocation.x.toDouble()),
            ),
          );
        }
      } else if (_isFirstLoad) {
        // If no driver location, center on merchant/pickup
        _isFirstLoad = false;
        await _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(pickupLat, pickupLng)),
        );
      }

      // Build polylines
      final newPolylines = <Polyline>{};

      if (!mounted) {
        _isUpdatingMap = false;
        return;
      }

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
              polylineId: const PolylineId("route"),
              points: routePoints,
              color: color,
              width: 4,
            ),
          );
        } else {
          // Fallback to straight line if no route available
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId("route"),
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
        logger.e("[UserMartOnTripScreen] - Failed to get route: $e");
        // Fallback to straight line on error
        newPolylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            points: [
              LatLng(pickupLat, pickupLng),
              LatLng(dropoffLat, dropoffLng),
            ],
            color: color,
            width: 4,
          ),
        );
      }

      if (!mounted) {
        _isUpdatingMap = false;
        return;
      }

      // Update cubit with markers and polylines
      locationCubit.setMapData(markers: newMarkers, polylines: newPolylines);
    } finally {
      _isUpdatingMap = false;
    }
  }

  /// Check if the order state has changed in a way that requires UI update
  bool _shouldRebuildForOrder(UserOrderState previous, UserOrderState current) {
    final prevOrder = previous.currentOrder.value;
    final currOrder = current.currentOrder.value;
    final prevDriver = previous.currentAssignedDriver.value;
    final currDriver = current.currentAssignedDriver.value;
    final prevPayment = previous.currentPayment.value;
    final currPayment = current.currentPayment.value;

    // Check order changes
    if (prevOrder?.id != currOrder?.id) return true;
    if (prevOrder?.status != currOrder?.status) return true;
    if (prevOrder?.driverId != currOrder?.driverId) return true;

    // Check driver changes
    if (prevDriver?.userId != currDriver?.userId) return true;
    if (prevDriver?.currentLocation?.x != currDriver?.currentLocation?.x) {
      return true;
    }
    if (prevDriver?.currentLocation?.y != currDriver?.currentLocation?.y) {
      return true;
    }

    // Check payment changes
    if (prevPayment?.id != currPayment?.id) return true;
    if (prevPayment?.status != currPayment?.status) return true;

    return false;
  }

  /// Handle order status changes (navigation, toasts, etc.)
  Future<void> _handleOrderStatusChange(
    BuildContext context,
    UserOrderState state,
  ) async {
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
            "orderId": currentOrder.id,
            "driverId": driver.userId,
            "driverName": driver.user?.name ?? "Driver",
          },
        );

        // If rating was submitted successfully, show success message
        if (result == true && mounted && context.mounted) {
          context.showMyToast(
            context.l10n.text_trip_completed,
            type: ToastType.success,
          );
          context.goNamed(Routes.userHome.name);
        }
      } else {
        context.showMyToast(
          context.l10n.text_trip_completed,
          type: ToastType.success,
        );
        context.goNamed(Routes.userHome.name);
      }
    } else if (_isOrderCancelled(currentOrder?.status) &&
        mounted &&
        context.mounted) {
      context.showMyToast(
        context.l10n.text_trip_canceled,
        type: ToastType.failed,
      );
      // Go back to home on cancellation
      context.goNamed(Routes.userHome.name);
    }
  }

  bool _isOrderCancelled(OrderStatus? status) {
    return status == OrderStatus.CANCELLED_BY_USER ||
        status == OrderStatus.CANCELLED_BY_DRIVER ||
        status == OrderStatus.CANCELLED_BY_SYSTEM ||
        status == OrderStatus.CANCELLED_BY_MERCHANT;
  }

  /// Check if the order can be cancelled by the user
  /// For merchant orders, cancellation is allowed until the merchant starts preparing
  bool _canCancelOrder(OrderStatus? status) {
    if (status == null) return false;
    return [
      OrderStatus.REQUESTED,
      OrderStatus.ACCEPTED,
      OrderStatus.MATCHING,
    ].contains(status);
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
              placeholder: Text(context.l10n.cancel_reason_optional),
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

      if (result != null && context.mounted) {
        context.showMyToast(
          context.l10n.order_cancelled_successfully,
          type: ToastType.success,
        );
        context.goNamed(Routes.userHome.name);
      } else if (context.mounted) {
        context.showMyToast(
          cubit.state.currentOrder.error?.message ??
              context.l10n.failed_to_cancel_order,
          type: ToastType.failed,
        );
      }
    }

    reasonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: false,
      padding: EdgeInsets.zero,
      headers: [DefaultAppBar(title: context.l10n.order_confirm_merchant)],
      body: BlocConsumer<UserOrderCubit, UserOrderState>(
        listenWhen: _shouldRebuildForOrder,
        buildWhen: _shouldRebuildForOrder,
        listener: (context, state) async {
          // Update map data when order/driver state changes
          await _updateMapWithOrderData(state);
          // Handle navigation and toasts
          if (context.mounted) {
            await _handleOrderStatusChange(context, state);
          }
        },
        builder: (context, orderState) {
          return Column(
            children: [
              // Map Section
              _MapSection(
                mapController: _mapController,
                onMapCreated: (controller) {
                  _mapController = controller;
                  setState(() {});
                  _updateMapWithOrderData(orderState);
                },
                orderState: orderState,
              ),
              // Content Section
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: _ContentSection(
                    state: orderState,
                    onCancelOrder: _showCancelDialog,
                    canCancelOrder: _canCancelOrder,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Map section widget
class _MapSection extends StatelessWidget {
  const _MapSection({
    required this.mapController,
    required this.onMapCreated,
    required this.orderState,
  });

  final GoogleMapController? mapController;
  final void Function(GoogleMapController) onMapCreated;
  final UserOrderState orderState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                onMapCreated: onMapCreated,
                markers: locationState.markers,
                polylines: locationState.polylines,
                myLocationEnabled: true,
              );
            },
          ),
          // Loading overlay when map is not ready
          if (mapController == null)
            Positioned.fill(
              child: Container(
                color: context.colorScheme.mutedForeground,
              ).asSkeleton(),
            ),
          // Emergency button - only show during IN_TRIP status
          _EmergencyButtonOverlay(orderState: orderState),
        ],
      ),
    );
  }
}

/// Emergency button overlay
class _EmergencyButtonOverlay extends StatelessWidget {
  const _EmergencyButtonOverlay({required this.orderState});

  final UserOrderState orderState;

  @override
  Widget build(BuildContext context) {
    final order = orderState.currentOrder.value;
    if (order == null || order.status != OrderStatus.IN_TRIP) {
      return const SizedBox.shrink();
    }

    // Get current location from driver or order
    final driverLocation =
        orderState.currentAssignedDriver.value?.currentLocation;
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
  }
}

/// Content section widget
class _ContentSection extends StatelessWidget {
  const _ContentSection({
    required this.state,
    required this.onCancelOrder,
    required this.canCancelOrder,
  });

  final UserOrderState state;
  final Future<void> Function(BuildContext, Order) onCancelOrder;
  final bool Function(OrderStatus?) canCancelOrder;

  /// Checks if the order has moved past merchant acceptance to driver phase
  bool _isInDriverPhase(Order order) {
    final status = order.status;
    return status == OrderStatus.MATCHING ||
        status == OrderStatus.ARRIVING ||
        status == OrderStatus.IN_TRIP ||
        status == OrderStatus.COMPLETED ||
        (status == OrderStatus.ACCEPTED && order.driverId != null);
  }

  @override
  Widget build(BuildContext context) {
    final order = state.currentOrder.value;
    final orderStatus = order?.status;
    final isInDriverPhase = order != null && _isInDriverPhase(order);

    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mart status progress indicator
        _MartStatusIndicator(status: orderStatus, order: order),

        // Merchant info section (always show for merchant orders)
        if (!isInDriverPhase) ...[
          DefaultText(
            context.l10n.order_confirm_merchant,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
          _MerchantInfoCard(order: order),
        ],

        // Driver info section (only show when in driver phase)
        if (isInDriverPhase) ...[
          DefaultText(
            context.l10n.text_your_driver_title,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
          _DriverInfoCard(
            driver: state.currentAssignedDriver.value,
            orderStatus: orderStatus,
            order: order,
          ),
        ],

        // Order items
        _OrderItemsList(order: order),

        // Order details
        _OrderDetailsCard(state: state),

        // Cancel button
        _CancelButton(
          order: order,
          canCancel: canCancelOrder(orderStatus),
          onCancel: onCancelOrder,
        ),
      ],
    );
  }
}

/// Mart status indicator widget with merchant and driver phases
class _MartStatusIndicator extends StatelessWidget {
  const _MartStatusIndicator({required this.status, required this.order});

  final OrderStatus? status;
  final Order? order;

  /// Determines the current step index based on order status for merchant orders.
  int _getMartStatusStep(OrderStatus? status) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return 0;
      case OrderStatus.ACCEPTED:
        // For merchant orders, ACCEPTED means merchant accepted (before PREPARING)
        // Unless driverId is set, then it's driver accepted
        if (order?.driverId != null) return 5;
        return 1;
      case OrderStatus.PREPARING:
        return 2;
      case OrderStatus.READY_FOR_PICKUP:
        return 3;
      case OrderStatus.MATCHING:
        return 4;
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
  bool _isInDriverPhase() {
    final currentOrder = order;
    if (currentOrder == null) return false;
    final orderStatus = currentOrder.status;
    return orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.ARRIVING ||
        orderStatus == OrderStatus.IN_TRIP ||
        orderStatus == OrderStatus.COMPLETED ||
        (orderStatus == OrderStatus.ACCEPTED && currentOrder.driverId != null);
  }

  @override
  Widget build(BuildContext context) {
    // Define the steps for merchant order flow
    final merchantSteps = [
      (context.l10n.requested, 0),
      (context.l10n.accepted, 1),
      (context.l10n.preparing, 2),
      (context.l10n.ready_for_pickup, 3),
    ];

    final driverSteps = [
      (context.l10n.finding_driver, 4),
      (context.l10n.status_driver_found, 5),
      (context.l10n.arriving, 6),
      (context.l10n.in_trip, 7),
    ];

    int currentStep = _getMartStatusStep(status);
    final isInDriverPhase = _isInDriverPhase();

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
                  isInDriverPhase ? LucideIcons.truck : LucideIcons.store,
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
                final isSearchingStep =
                    isCurrent &&
                    (status == OrderStatus.MATCHING ||
                        status == OrderStatus.REQUESTED ||
                        status == OrderStatus.PREPARING);

                return _MartStatusStepWidget(
                  label: stepLabel,
                  isActive: isActive,
                  isCurrent: isCurrent,
                  isSearching: isSearchingStep,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual mart status step widget
class _MartStatusStepWidget extends StatelessWidget {
  const _MartStatusStepWidget({
    required this.label,
    required this.isActive,
    required this.isCurrent,
    required this.isSearching,
  });

  final String label;
  final bool isActive;
  final bool isCurrent;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
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
            child: _buildStepContent(context),
          ),
          Text(
            label,
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
  }

  Widget? _buildStepContent(BuildContext context) {
    if (isSearching) {
      return Center(
        child: SizedBox(
          width: 14.w,
          height: 14.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.colorScheme.primaryForeground,
          ),
        ),
      );
    }

    if (isActive) {
      return Icon(
        LucideIcons.check,
        size: 14.sp,
        color: context.colorScheme.primaryForeground,
      );
    }

    return null;
  }
}

/// Merchant info card widget
class _MerchantInfoCard extends StatelessWidget {
  const _MerchantInfoCard({required this.order});

  final Order? order;

  IconData _getMerchantStatusIcon(OrderStatus status, String? driverId) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return LucideIcons.clock;
      case OrderStatus.ACCEPTED:
        if (driverId != null) return LucideIcons.userCheck;
        return LucideIcons.circleCheck;
      case OrderStatus.PREPARING:
        return LucideIcons.packageOpen;
      case OrderStatus.READY_FOR_PICKUP:
        return LucideIcons.package;
      case OrderStatus.MATCHING:
        return LucideIcons.search;
      default:
        return LucideIcons.store;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (order == null) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Avatar(size: 48.w, initials: "?"),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    DefaultText(
                      "Merchant name",
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
    final currentOrder = order;
    if (currentOrder == null) return const SizedBox.shrink();

    final merchantName =
        currentOrder.merchant?.name ?? context.l10n.order_confirm_merchant;
    final merchantImage = currentOrder.merchant?.image;

    String getMerchantStatusText() {
      switch (currentOrder.status) {
        case OrderStatus.REQUESTED:
          return context.l10n.requested;
        case OrderStatus.ACCEPTED:
          if (currentOrder.driverId != null) {
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
          return currentOrder.status.name;
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
                        _getMerchantStatusIcon(
                          currentOrder.status,
                          currentOrder.driverId,
                        ),
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
}

/// Driver info card widget
class _DriverInfoCard extends StatelessWidget {
  const _DriverInfoCard({
    required this.driver,
    required this.orderStatus,
    required this.order,
  });

  final Driver? driver;
  final OrderStatus? orderStatus;
  final Order? order;

  /// Checks if the order has moved past merchant acceptance to driver phase
  bool _isInDriverPhase() {
    if (order == null) return false;
    final status = order!.status;
    return status == OrderStatus.MATCHING ||
        status == OrderStatus.ARRIVING ||
        status == OrderStatus.IN_TRIP ||
        status == OrderStatus.COMPLETED ||
        (status == OrderStatus.ACCEPTED && order!.driverId != null);
  }

  @override
  Widget build(BuildContext context) {
    // Only show driver info when in driver phase
    if (order == null || !_isInDriverPhase()) {
      return const SizedBox.shrink();
    }

    // Show finding driver state when in matching phase
    if (orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.READY_FOR_PICKUP) {
      return const _FindingDriverCard();
    }

    // Show skeleton loading if driver should be assigned but data not loaded
    if (driver == null) {
      return const _DriverInfoSkeleton();
    }

    return _DriverInfoContent(driver: driver!);
  }
}

/// Finding driver card widget
class _FindingDriverCard extends StatelessWidget {
  const _FindingDriverCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
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
      ),
    );
  }
}

/// Driver info skeleton widget
class _DriverInfoSkeleton extends StatelessWidget {
  const _DriverInfoSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Avatar(size: 48.w, initials: "?"),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  DefaultText(
                    "Driver name",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  DefaultText(context.l10n.text_license_plate, fontSize: 12.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    ).asSkeleton();
  }
}

/// Driver info content widget
class _DriverInfoContent extends StatelessWidget {
  const _DriverInfoContent({required this.driver});

  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Avatar(
              size: 48.w,
              initials: Avatar.getInitials(driver.user?.name ?? "Driver"),
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
                    driver.user?.name ?? "Driver",
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
}

/// Order items list widget
class _OrderItemsList extends StatelessWidget {
  const _OrderItemsList({required this.order});

  final Order? order;

  @override
  Widget build(BuildContext context) {
    final currentOrder = order;
    final items = currentOrder?.items;
    if (currentOrder == null || items == null || items.isEmpty) {
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
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final orderItem = entry.value;
              final item = orderItem.item;
              final isLast = index == items.length - 1;

              return Column(
                children: [
                  _OrderItemRow(orderItem: orderItem, item: item),
                  if (!isLast) const Divider(height: 1),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Individual order item row widget
class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({required this.orderItem, required this.item});

  final OrderItem orderItem;
  final OrderItemItem item;

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.image;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          // Item image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _ItemImagePlaceholder(),
                    errorWidget: (context, url, error) =>
                        _ItemImagePlaceholder(),
                  )
                : _ItemImagePlaceholder(),
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
                  "${orderItem.quantity}x @ ${context.formatCurrency(item.price ?? 0)}",
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ),
          ),
          // Item total
          DefaultText(
            context.formatCurrency((item.price ?? 0) * orderItem.quantity),
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}

/// Item image placeholder widget
class _ItemImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      color: context.colorScheme.muted,
      child: Icon(
        LucideIcons.shoppingBag,
        size: 20.sp,
        color: context.colorScheme.mutedForeground,
      ),
    );
  }
}

/// Order details card widget
class _OrderDetailsCard extends StatelessWidget {
  const _OrderDetailsCard({required this.state});

  final UserOrderState state;

  @override
  Widget build(BuildContext context) {
    final order = state.currentOrder.value;
    final payment = state.currentPayment.value;

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
              _DetailCell(
                title: context.l10n.label_payment_method_lower,
                value: _getPaymentMethodDisplay(payment),
              ),
              const Divider(),
              _DetailCell(
                title: context.l10n.label_total_price,
                value: order != null
                    ? context.formatCurrency(order.totalPrice)
                    : "-",
              ),
              const Divider(),
              _DetailCell(
                title: context.l10n.label_status,
                value: order?.status.name ?? "-",
              ),
            ],
          ),
        ).asSkeleton(enabled: order == null),
      ],
    );
  }

  String _getPaymentMethodDisplay(Payment? payment) {
    if (payment == null) return "-";

    switch (payment.method) {
      case PaymentMethod.wallet:
        return "wallet";
      case PaymentMethod.QRIS:
        return "QRIS";
      case PaymentMethod.BANK_TRANSFER:
        final bankName = payment.bankProvider?.name ?? "";
        return "Bank Transfer${bankName.isNotEmpty ? " ($bankName)" : ""}";
    }
  }
}

/// Detail cell widget
class _DetailCell extends StatelessWidget {
  const _DetailCell({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
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
}

/// Cancel button widget
class _CancelButton extends StatelessWidget {
  const _CancelButton({
    required this.order,
    required this.canCancel,
    required this.onCancel,
  });

  final Order? order;
  final bool canCancel;
  final Future<void> Function(BuildContext, Order) onCancel;

  @override
  Widget build(BuildContext context) {
    if (order == null || !canCancel) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: Button.destructive(
        onPressed: () => onCancel(context, order!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.x, size: 18.sp),
            Gap(8.w),
            Text(context.l10n.cancel_order),
          ],
        ),
      ),
    );
  }
}
