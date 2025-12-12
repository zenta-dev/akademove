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
        logger.e("[UserDeliveryOnTripScreen] - Failed to get route: $e");
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
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.title_delivery)],
      child: BlocConsumer<UserOrderCubit, UserOrderState>(
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

  @override
  Widget build(BuildContext context) {
    final order = state.currentOrder.value;
    final orderStatus = order?.status;
    final isSearching =
        orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.REQUESTED;

    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status progress indicator
        _DeliveryStatusIndicator(status: orderStatus),
        // Driver section title
        DefaultText(
          isSearching
              ? context.l10n.text_finding_driver_title
              : context.l10n.text_your_driver_title,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        // Driver info card
        _DriverInfoCard(
          driver: state.currentAssignedDriver.value,
          orderStatus: orderStatus,
        ),
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
  const _DriverInfoCard({required this.driver, required this.orderStatus});

  final Driver? driver;
  final OrderStatus? orderStatus;

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

/// Order details card widget
class _OrderDetailsCard extends StatelessWidget {
  const _OrderDetailsCard({required this.state});

  final UserOrderState state;

  @override
  Widget build(BuildContext context) {
    final order = state.currentOrder.value;
    final payment = state.currentPayment.value;
    final estimateOrder = state.estimateOrder.value;

    // Use estimateOrder locations if available (has proper names)
    final pickupName =
        estimateOrder?.pickup.vicinity ??
        estimateOrder?.pickup.name ??
        (order != null
            ? "${order.pickupLocation.y.toStringAsFixed(4)}, ${order.pickupLocation.x.toStringAsFixed(4)}"
            : "-");

    final dropoffName =
        estimateOrder?.dropoff.vicinity ??
        estimateOrder?.dropoff.name ??
        (order != null
            ? "${order.dropoffLocation.y.toStringAsFixed(4)}, ${order.dropoffLocation.x.toStringAsFixed(4)}"
            : "-");

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
                title: context.l10n.origin,
                value: pickupName,
                allowMultiline: true,
              ),
              const Divider(),
              _DetailCell(
                title: context.l10n.destination,
                value: dropoffName,
                allowMultiline: true,
              ),
              const Divider(),
              _DetailCell(
                title: context.l10n.label_distance,
                value: order != null ? "${order.distanceKm} Km" : "-",
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
