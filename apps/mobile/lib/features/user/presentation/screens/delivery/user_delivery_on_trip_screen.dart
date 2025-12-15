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

class UserDeliveryOnTripScreen extends StatefulWidget {
  const UserDeliveryOnTripScreen({super.key});

  @override
  State<UserDeliveryOnTripScreen> createState() =>
      _UserDeliveryOnTripScreenState();
}

class _UserDeliveryOnTripScreenState extends State<UserDeliveryOnTripScreen> {
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

    // Check if driver marker actually changed position
    final existingDriverMarker = currentMarkers.cast<Marker?>().firstWhere(
      (m) => m?.markerId.value == "driver",
      orElse: () => null,
    );

    if (existingDriverMarker != null) {
      // Skip update if position hasn't changed significantly
      const threshold = 0.00001;
      final latDiff =
          (existingDriverMarker.position.latitude -
                  driverMarker.position.latitude)
              .abs();
      final lngDiff =
          (existingDriverMarker.position.longitude -
                  driverMarker.position.longitude)
              .abs();
      if (latDiff < threshold && lngDiff < threshold) {
        return; // Position hasn't changed enough, skip update
      }
    }

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
        // Pickup marker
        Marker(
          markerId: const MarkerId("pickup"),
          position: LatLng(pickupLat, pickupLng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: context.l10n.origin,
            snippet: context.l10n.text_pickup_location,
          ),
        ),
        // Dropoff marker
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
        // If no driver location, center on pickup
        _isFirstLoad = false;
        await _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(pickupLat, pickupLng)),
        );
      }

      // Build polylines based on order status
      final newPolylines = <Polyline>{};

      if (!mounted) {
        _isUpdatingMap = false;
        return;
      }

      final primaryColor = context.colorScheme.primary;
      final dimmedColor = primaryColor.withValues(alpha: 0.4);
      final orderLocationCubit = context.read<OrderLocationCubit>();
      final orderStatus = order.status;

      // Determine if driver is heading to pickup or already picked up
      final isDriverHeadingToPickup =
          orderStatus == OrderStatus.ACCEPTED ||
          orderStatus == OrderStatus.ARRIVING;
      final isInTrip = orderStatus == OrderStatus.IN_TRIP;

      try {
        // Always get pickup-to-dropoff route
        final pickupToDropoffRoute = await orderLocationCubit.getRoutes(
          order.pickupLocation,
          order.dropoffLocation,
        );

        final pickupToDropoffPoints = pickupToDropoffRoute.isNotEmpty
            ? pickupToDropoffRoute
                  .map((c) => LatLng(c.y.toDouble(), c.x.toDouble()))
                  .toList()
            : [LatLng(pickupLat, pickupLng), LatLng(dropoffLat, dropoffLng)];

        // If driver is heading to pickup, show driver-to-pickup route (highlighted)
        // and pickup-to-dropoff route (dimmed)
        if (isDriverHeadingToPickup && driverLocation != null) {
          // Get driver-to-pickup route
          final driverToPickupRoute = await orderLocationCubit.getRoutes(
            driverLocation,
            order.pickupLocation,
          );

          final driverToPickupPoints = driverToPickupRoute.isNotEmpty
              ? driverToPickupRoute
                    .map((c) => LatLng(c.y.toDouble(), c.x.toDouble()))
                    .toList()
              : [
                  LatLng(
                    driverLocation.y.toDouble(),
                    driverLocation.x.toDouble(),
                  ),
                  LatLng(pickupLat, pickupLng),
                ];

          // Driver to pickup - highlighted (active route)
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId("driver_to_pickup"),
              points: driverToPickupPoints,
              color: primaryColor,
              width: 5,
            ),
          );

          // Pickup to dropoff - dimmed (planned route)
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId("pickup_to_dropoff"),
              points: pickupToDropoffPoints,
              color: dimmedColor,
              width: 4,
              patterns: [PatternItem.dash(10), PatternItem.gap(5)],
            ),
          );
        } else if (isInTrip && driverLocation != null) {
          // During trip: show driver-to-dropoff route (highlighted)
          final driverToDropoffRoute = await orderLocationCubit.getRoutes(
            driverLocation,
            order.dropoffLocation,
          );

          final driverToDropoffPoints = driverToDropoffRoute.isNotEmpty
              ? driverToDropoffRoute
                    .map((c) => LatLng(c.y.toDouble(), c.x.toDouble()))
                    .toList()
              : [
                  LatLng(
                    driverLocation.y.toDouble(),
                    driverLocation.x.toDouble(),
                  ),
                  LatLng(dropoffLat, dropoffLng),
                ];

          newPolylines.add(
            Polyline(
              polylineId: const PolylineId("driver_to_dropoff"),
              points: driverToDropoffPoints,
              color: primaryColor,
              width: 5,
            ),
          );
        } else {
          // Fallback: just show pickup-to-dropoff route
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId("pickup_to_dropoff"),
              points: pickupToDropoffPoints,
              color: primaryColor,
              width: 4,
            ),
          );
        }
      } catch (e) {
        logger.e("[UserDeliveryOnTripScreen] - Failed to get route: $e");
        // Fallback to straight line on error
        newPolylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            points: [
              LatLng(pickupLat, pickupLng),
              LatLng(dropoffLat, dropoffLng),
            ],
            color: primaryColor,
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

  /// Handle order status changes (navigation, toasts, etc.)
  Future<void> _handleOrderStatusChange(
    BuildContext context,
    UserOrderState state,
  ) async {
    final currentOrder = state.currentOrder.value;

    if (currentOrder?.status == OrderStatus.COMPLETED &&
        mounted &&
        context.mounted) {
      context.read<UserOrderCubit>().clearActiveOrder();
      // Navigate to order completion screen
      final driver = state.currentAssignedDriver.value;
      final payment = state.currentPayment.value;
      if (driver != null && currentOrder != null) {
        final result = await context.pushNamed(
          Routes.userOrderCompletion.name,
          extra: {
            "orderId": currentOrder.id,
            "orderType": OrderType.DELIVERY,
            "order": currentOrder,
            "driver": driver,
            "payment": payment,
          },
        );

        // If rating was submitted successfully, show success message
        if (result == true && mounted && context.mounted) {
          context.showMyToast(
            context.l10n.text_trip_completed,
            type: ToastType.success,
          );
          context.popUntilRoot();
        }
      } else {
        context.showMyToast(
          context.l10n.text_trip_completed,
          type: ToastType.success,
        );
        context.popUntilRoot();
      }
    } else if (_isOrderCancelled(currentOrder?.status) &&
        mounted &&
        context.mounted) {
      context.showMyToast(
        context.l10n.text_trip_canceled,
        type: ToastType.failed,
      );
    }
  }

  bool _isOrderCancelled(OrderStatus? status) {
    return status == OrderStatus.CANCELLED_BY_USER ||
        status == OrderStatus.CANCELLED_BY_DRIVER ||
        status == OrderStatus.CANCELLED_BY_SYSTEM;
  }

  /// Check if the order can be cancelled by the user
  bool _canCancelOrder(OrderStatus? status) {
    if (status == null) return false;
    return [
      OrderStatus.REQUESTED,
      OrderStatus.MATCHING,
      OrderStatus.ACCEPTED,
      OrderStatus.ARRIVING,
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
        context.popUntilRoot();
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
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.title_delivery)],
      child: MultiBlocListener(
        listeners: [
          // Listener for driver location changes ONLY - update driver marker without recreating others
          BlocListener<UserOrderCubit, UserOrderState>(
            listenWhen: (previous, current) {
              final prevDriver = previous.currentAssignedDriver.value;
              final currDriver = current.currentAssignedDriver.value;

              // Only listen for driver location changes (not assignment changes)
              if (prevDriver?.userId != currDriver?.userId) return false;

              final prevLoc = prevDriver?.currentLocation;
              final currLoc = currDriver?.currentLocation;

              // Check if location actually changed
              if (prevLoc == null && currLoc == null) return false;
              if (prevLoc == null || currLoc == null) return true;

              return prevLoc.x != currLoc.x || prevLoc.y != currLoc.y;
            },
            listener: (context, state) {
              // Only update the driver marker, not all markers
              final driver = state.currentAssignedDriver.value;
              final driverLocation = driver?.currentLocation;
              if (driver != null && driverLocation != null) {
                _animatedDriverMarker.updateDriverLocation(
                  driverLocation,
                  driver: driver,
                );
              }
            },
          ),
          // Listener for full map updates (order changes, driver assignment, status changes)
          BlocListener<UserOrderCubit, UserOrderState>(
            listenWhen: (previous, current) {
              final prevDriver = previous.currentAssignedDriver.value;
              final currDriver = current.currentAssignedDriver.value;
              final prevOrder = previous.currentOrder.value;
              final currOrder = current.currentOrder.value;

              // Listen for order changes
              if (prevOrder?.id != currOrder?.id) return true;

              // Listen for order status changes (may need polyline updates)
              if (prevOrder?.status != currOrder?.status) return true;

              // Listen for driver assignment changes (new driver assigned)
              if (prevDriver?.userId != currDriver?.userId) return true;

              return false;
            },
            listener: (context, state) async {
              await _updateMapWithOrderData(state);
            },
          ),
          // Listener for navigation/toasts (only on status changes)
          BlocListener<UserOrderCubit, UserOrderState>(
            listenWhen: (previous, current) {
              final prevOrder = previous.currentOrder.value;
              final currOrder = current.currentOrder.value;
              return prevOrder?.status != currOrder?.status;
            },
            listener: (context, state) async {
              if (context.mounted) {
                await _handleOrderStatusChange(context, state);
              }
            },
          ),
        ],
        child: Column(
          children: [
            // Map Section - rebuilds only when map data changes
            _MapSection(
              mapController: _mapController,
              onMapCreated: (controller) {
                _mapController = controller;
                if (mounted) setState(() {});
                final state = context.read<UserOrderCubit>().state;
                _updateMapWithOrderData(state);
              },
            ),
            // Content Section - uses selectors to rebuild only what's needed
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: _ContentSection(
                  onCancelOrder: _showCancelDialog,
                  canCancelOrder: _canCancelOrder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Map section widget - uses BlocSelector to only rebuild on order status changes
class _MapSection extends StatelessWidget {
  const _MapSection({required this.mapController, required this.onMapCreated});

  final GoogleMapController? mapController;
  final void Function(GoogleMapController) onMapCreated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280.h,
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
          BlocSelector<UserOrderCubit, UserOrderState, OrderStatus?>(
            selector: (state) => state.currentOrder.value?.status,
            builder: (context, status) {
              if (status != OrderStatus.IN_TRIP) {
                return const SizedBox.shrink();
              }
              return BlocSelector<
                UserOrderCubit,
                UserOrderState,
                EmergencyLocation
              >(
                selector: (state) {
                  final order = state.currentOrder.value;
                  final driverLocation =
                      state.currentAssignedDriver.value?.currentLocation;
                  if (driverLocation != null) {
                    return EmergencyLocation(
                      latitude: driverLocation.y.toDouble(),
                      longitude: driverLocation.x.toDouble(),
                    );
                  }
                  return EmergencyLocation(
                    latitude: order?.pickupLocation.y.toDouble() ?? 0,
                    longitude: order?.pickupLocation.x.toDouble() ?? 0,
                  );
                },
                builder: (context, emergencyLocation) {
                  final order = context
                      .read<UserOrderCubit>()
                      .state
                      .currentOrder
                      .value;
                  if (order == null) return const SizedBox.shrink();
                  return Positioned(
                    bottom: 16,
                    right: 16,
                    child: EmergencyButton(
                      orderId: order.id,
                      currentLocation: emergencyLocation,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Content section widget - uses BlocSelector for granular rebuilds
class _ContentSection extends StatelessWidget {
  const _ContentSection({
    required this.onCancelOrder,
    required this.canCancelOrder,
  });

  final Future<void> Function(BuildContext, Order) onCancelOrder;
  final bool Function(OrderStatus?) canCancelOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status progress indicator - rebuilds only on status change
        BlocSelector<UserOrderCubit, UserOrderState, OrderStatus?>(
          selector: (state) => state.currentOrder.value?.status,
          builder: (context, status) =>
              _DeliveryStatusIndicator(status: status),
        ),
        // Driver section title - rebuilds only on status change
        BlocSelector<UserOrderCubit, UserOrderState, OrderStatus?>(
          selector: (state) => state.currentOrder.value?.status,
          builder: (context, status) {
            final isSearching =
                status == OrderStatus.MATCHING ||
                status == OrderStatus.REQUESTED;
            return DefaultText(
              isSearching
                  ? context.l10n.text_finding_driver_title
                  : context.l10n.text_your_driver_title,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            );
          },
        ),
        // Driver info card - rebuilds on driver info or status change (NOT location)
        BlocSelector<UserOrderCubit, UserOrderState, _DriverInfoData>(
          selector: (state) => _DriverInfoData(
            driver: state.currentAssignedDriver.value,
            orderStatus: state.currentOrder.value?.status,
            orderId: state.currentOrder.value?.id,
          ),
          builder: (context, data) => _DriverInfoCard(
            driver: data.driver,
            orderStatus: data.orderStatus,
            orderId: data.orderId,
          ),
        ),
        // Order details - rebuilds on order/payment change
        BlocSelector<UserOrderCubit, UserOrderState, _OrderDetailsData>(
          selector: (state) => _OrderDetailsData(
            order: state.currentOrder.value,
            payment: state.currentPayment.value,
            estimateOrder: state.estimateOrder.value,
          ),
          builder: (context, data) => _OrderDetailsCard(
            order: data.order,
            payment: data.payment,
            estimateOrder: data.estimateOrder,
          ),
        ),
        // Cancel button - rebuilds on order/status change
        BlocSelector<UserOrderCubit, UserOrderState, Order?>(
          selector: (state) => state.currentOrder.value,
          builder: (context, order) => _CancelButton(
            order: order,
            canCancel: canCancelOrder(order?.status),
            onCancel: onCancelOrder,
          ),
        ),
      ],
    );
  }
}

/// Data class for driver info selector (excludes location)
class _DriverInfoData {
  const _DriverInfoData({this.driver, this.orderStatus, this.orderId});
  final Driver? driver;
  final OrderStatus? orderStatus;
  final String? orderId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _DriverInfoData &&
        other.driver?.userId == driver?.userId &&
        other.driver?.user?.name == driver?.user?.name &&
        other.driver?.licensePlate == driver?.licensePlate &&
        other.driver?.rating == driver?.rating &&
        other.orderStatus == orderStatus &&
        other.orderId == orderId;
  }

  @override
  int get hashCode => Object.hash(
    driver?.userId,
    driver?.user?.name,
    driver?.licensePlate,
    driver?.rating,
    orderStatus,
    orderId,
  );
}

/// Data class for order details selector
class _OrderDetailsData {
  const _OrderDetailsData({this.order, this.payment, this.estimateOrder});
  final Order? order;
  final Payment? payment;
  final EstimateOrderResult? estimateOrder;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _OrderDetailsData &&
        other.order?.id == order?.id &&
        other.order?.status == order?.status &&
        other.order?.totalPrice == order?.totalPrice &&
        other.order?.distanceKm == order?.distanceKm &&
        other.payment?.id == payment?.id &&
        other.payment?.method == payment?.method &&
        other.estimateOrder?.pickup.name == estimateOrder?.pickup.name &&
        other.estimateOrder?.dropoff.name == estimateOrder?.dropoff.name;
  }

  @override
  int get hashCode => Object.hash(
    order?.id,
    order?.status,
    order?.totalPrice,
    payment?.id,
    estimateOrder?.pickup.name,
  );
}

/// Delivery status indicator widget
class _DeliveryStatusIndicator extends StatelessWidget {
  const _DeliveryStatusIndicator({required this.status});

  final OrderStatus? status;

  @override
  Widget build(BuildContext context) {
    final steps = [
      (context.l10n.status_searching, OrderStatus.MATCHING),
      (context.l10n.status_driver_found, OrderStatus.ACCEPTED),
      (context.l10n.arriving, OrderStatus.ARRIVING),
      (context.l10n.in_trip, OrderStatus.IN_TRIP),
    ];

    int currentStep = _getCurrentStep(status);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: steps.asMap().entries.map((entry) {
            final index = entry.key;
            final stepLabel = entry.value.$1;
            final isActive = index <= currentStep;
            final isCurrent = index == currentStep;
            final isSearchingStep =
                isCurrent &&
                (status == OrderStatus.MATCHING ||
                    status == OrderStatus.REQUESTED);

            return _StatusStepWidget(
              label: stepLabel,
              isActive: isActive,
              isCurrent: isCurrent,
              isSearching: isSearchingStep,
            );
          }).toList(),
        ),
      ),
    );
  }

  int _getCurrentStep(OrderStatus? status) {
    if (status == null) return 0;

    // Map status to step index
    switch (status) {
      case OrderStatus.REQUESTED:
      case OrderStatus.MATCHING:
        return 0;
      case OrderStatus.ACCEPTED:
        return 1;
      case OrderStatus.ARRIVING:
        return 2;
      case OrderStatus.IN_TRIP:
        return 3;
      case OrderStatus.COMPLETED:
        return 3; // Show all steps completed
      default:
        return 0;
    }
  }
}

/// Individual status step widget
class _StatusStepWidget extends StatelessWidget {
  const _StatusStepWidget({
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
    return Column(
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
        DefaultText(
          label,
          fontSize: 9.sp,
          color: isActive
              ? context.colorScheme.foreground
              : context.colorScheme.mutedForeground,
        ),
      ],
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

/// Driver info card widget
class _DriverInfoCard extends StatelessWidget {
  const _DriverInfoCard({
    required this.driver,
    required this.orderStatus,
    this.orderId,
  });

  final Driver? driver;
  final OrderStatus? orderStatus;
  final String? orderId;

  @override
  Widget build(BuildContext context) {
    // Show finding driver state when in matching phase
    if (orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.REQUESTED) {
      return const _FindingDriverCard();
    }

    // Show skeleton loading if driver should be assigned but data not loaded
    if (driver == null) {
      return const _DriverInfoSkeleton();
    }

    return _DriverInfoContent(driver: driver!, orderId: orderId);
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
  const _DriverInfoContent({required this.driver, this.orderId});

  final Driver driver;
  final String? orderId;

  void _showChatDialog(BuildContext context) {
    if (orderId == null) return;
    openDrawer(
      context: context,
      position: OverlayPosition.bottom,
      expands: true,
      builder: (drawerContext) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.chat_with_driver,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.x),
                  onPressed: () => closeDrawer(drawerContext),
                  variance: ButtonVariance.ghost,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(child: OrderChatWidget(orderId: orderId!)),
          ],
        ),
      ),
    );
  }

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
            // Chat button with unread badge
            if (orderId != null)
              ChatButtonWithBadge(
                orderId: orderId!,
                onPressed: () => _showChatDialog(context),
              ),
          ],
        ),
      ),
    );
  }
}

/// Order details card widget
class _OrderDetailsCard extends StatelessWidget {
  const _OrderDetailsCard({
    required this.order,
    required this.payment,
    required this.estimateOrder,
  });

  final Order? order;
  final Payment? payment;
  final EstimateOrderResult? estimateOrder;

  @override
  Widget build(BuildContext context) {
    // Use estimateOrder locations if available (has proper names)
    final pickupAddress =
        estimateOrder?.pickup.vicinity ??
        estimateOrder?.pickup.name ??
        order?.pickupAddress;

    final dropoffAddress =
        estimateOrder?.dropoff.vicinity ??
        estimateOrder?.dropoff.name ??
        order?.dropoffAddress;

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
              if (order != null)
                _LocationDetailCell(
                  title: context.l10n.origin,
                  address: pickupAddress,
                  coordinate: order!.pickupLocation,
                )
              else
                _DetailCell(
                  title: context.l10n.origin,
                  value: pickupAddress ?? "-",
                  allowMultiline: true,
                ),
              const Divider(),
              if (order != null)
                _LocationDetailCell(
                  title: context.l10n.destination,
                  address: dropoffAddress,
                  coordinate: order!.dropoffLocation,
                )
              else
                _DetailCell(
                  title: context.l10n.destination,
                  value: dropoffAddress ?? "-",
                  allowMultiline: true,
                ),
              const Divider(),
              _DetailCell(
                title: context.l10n.label_distance,
                value: order != null ? "${order!.distanceKm} Km" : "-",
              ),
              const Divider(),
              _DetailCell(
                title: context.l10n.label_payment_method_lower,
                value: _getPaymentMethodDisplay(payment),
              ),
              const Divider(),
              _DetailCell(
                title: context.l10n.label_total_price,
                value: order != null
                    ? context.formatCurrency(order!.totalPrice)
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
  const _DetailCell({
    required this.title,
    required this.value,
    this.allowMultiline = false,
  });

  final String title;
  final String value;
  final bool allowMultiline;

  @override
  Widget build(BuildContext context) {
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
}

/// Location detail cell widget - uses AddressText for reverse geocoding
class _LocationDetailCell extends StatelessWidget {
  const _LocationDetailCell({
    required this.title,
    required this.address,
    required this.coordinate,
  });

  final String title;
  final String? address;
  final Coordinate coordinate;

  @override
  Widget build(BuildContext context) {
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
        AddressText(
          address: address,
          coordinate: coordinate,
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
