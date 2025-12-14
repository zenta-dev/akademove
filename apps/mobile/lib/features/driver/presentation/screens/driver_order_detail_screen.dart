import 'dart:async';

import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverOrderDetailScreen extends StatefulWidget {
  const DriverOrderDetailScreen({required this.orderId, super.key});

  final String orderId;

  @override
  State<DriverOrderDetailScreen> createState() =>
      _DriverOrderDetailScreenState();
}

class _DriverOrderDetailScreenState extends State<DriverOrderDetailScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  bool _isUpdatingMap = false;
  Coordinate? _currentDriverLocation;

  /// Track the previous order status to detect transitions (not initial load)
  OrderStatus? _previousOrderStatus;

  /// Flag to indicate if we're viewing a historical order (already terminal)
  bool _isHistoricalView = false;

  /// Animated driver marker for smooth location updates with bike icon
  late final AnimatedDriverMarker _animatedDriverMarker;

  /// Stream subscription for real-time location tracking
  StreamSubscription<Coordinate>? _locationStreamSubscription;

  @override
  void initState() {
    super.initState();
    _animatedDriverMarker = AnimatedDriverMarker(
      onMarkerUpdated: _onDriverMarkerUpdated,
      markerId: 'driver',
    );
    _initializeMarkerAndLocation();
    _initializeOrder();
  }

  /// Initialize marker icon and start location streaming
  Future<void> _initializeMarkerAndLocation() async {
    await _animatedDriverMarker.loadDriverIcon();
    _startLocationStream();
  }

  /// Start real-time location streaming for driver marker
  void _startLocationStream() {
    final locationService = sl<LocationService>();
    final driverOrderCubit = context.read<DriverOrderCubit>();
    _locationStreamSubscription = locationService
        .getLocationStream(
          accuracy: LocationAccuracy.high,
          interval: const Duration(seconds: 3),
        )
        .listen(
          (coordinate) {
            _currentDriverLocation = coordinate;
            _animatedDriverMarker.updateDriverLocation(coordinate);

            // Update polylines when driver location changes during active order
            final state = driverOrderCubit.state;
            final order = state.currentOrder;
            if (order != null &&
                _shouldUpdateRouteForStatus(state.orderStatus)) {
              _updatePolylinesOnly(order);
            }
          },
          onError: (error) {
            logger.e('[DriverOrderDetailScreen] Location stream error: $error');
          },
        );
  }

  /// Check if we should update route for the current order status
  bool _shouldUpdateRouteForStatus(OrderStatus? status) {
    return status == OrderStatus.ACCEPTED ||
        status == OrderStatus.ARRIVING ||
        status == OrderStatus.IN_TRIP;
  }

  /// Callback when animated driver marker position updates
  void _onDriverMarkerUpdated(Marker driverMarker) {
    if (!mounted) return;

    // Schedule setState for next frame to avoid "Build scheduled during frame" error
    // This can happen when the animation timer fires during layout phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        // Remove old driver marker and add updated one
        _markers = _markers.where((m) => m.markerId.value != 'driver').toSet()
          ..add(driverMarker);
      });
    });
  }

  /// Update only polylines when driver location changes (without full map rebuild)
  Future<void> _updatePolylinesOnly(Order order) async {
    if (_isUpdatingMap) return;
    _isUpdatingMap = true;

    try {
      final driverLocation = _currentDriverLocation;
      if (driverLocation == null || !mounted) {
        _isUpdatingMap = false;
        return;
      }

      final pickupLat = order.pickupLocation.y.toDouble();
      final pickupLng = order.pickupLocation.x.toDouble();
      final dropoffLat = order.dropoffLocation.y.toDouble();
      final dropoffLng = order.dropoffLocation.x.toDouble();

      final primaryColor = context.colorScheme.primary;
      final dimmedColor = primaryColor.withValues(alpha: 0.4);
      final mapService = sl<MapService>();
      final orderStatus = order.status;

      final isDriverHeadingToPickup =
          orderStatus == OrderStatus.ACCEPTED ||
          orderStatus == OrderStatus.ARRIVING;
      final isInTrip = orderStatus == OrderStatus.IN_TRIP;

      final newPolylines = <Polyline>{};

      try {
        // Always get pickup-to-dropoff route
        final pickupToDropoffRoute = await mapService.getRoutes(
          order.pickupLocation,
          order.dropoffLocation,
        );

        final pickupToDropoffPoints = pickupToDropoffRoute.isNotEmpty
            ? pickupToDropoffRoute
                  .map((c) => LatLng(c.y.toDouble(), c.x.toDouble()))
                  .toList()
            : [LatLng(pickupLat, pickupLng), LatLng(dropoffLat, dropoffLng)];

        if (isDriverHeadingToPickup) {
          final driverToPickupRoute = await mapService.getRoutes(
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

          newPolylines
            ..add(
              Polyline(
                polylineId: const PolylineId('driver_to_pickup'),
                points: driverToPickupPoints,
                color: primaryColor,
                width: 5,
              ),
            )
            ..add(
              Polyline(
                polylineId: const PolylineId('pickup_to_dropoff'),
                points: pickupToDropoffPoints,
                color: dimmedColor,
                width: 4,
                patterns: [PatternItem.dash(10), PatternItem.gap(5)],
              ),
            );
        } else if (isInTrip) {
          final driverToDropoffRoute = await mapService.getRoutes(
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
              polylineId: const PolylineId('driver_to_dropoff'),
              points: driverToDropoffPoints,
              color: primaryColor,
              width: 5,
            ),
          );
        } else {
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId('pickup_to_dropoff'),
              points: pickupToDropoffPoints,
              color: primaryColor,
              width: 4,
            ),
          );
        }
      } catch (e) {
        logger.e('[DriverOrderDetailScreen] - Failed to update polylines: $e');
      }

      if (!mounted) {
        _isUpdatingMap = false;
        return;
      }

      if (newPolylines.isNotEmpty) {
        setState(() {
          _polylines = newPolylines;
        });
      }
    } finally {
      _isUpdatingMap = false;
    }
  }

  Future<void> _initializeOrder() async {
    // Load order details
    final order = await sl<OrderRepository>()
        .get(widget.orderId)
        .then((res) => res.data);
    if (mounted) {
      // Check if this is a historical order (already in terminal state)
      // to prevent auto-navigation back when viewing order history
      final isTerminal = _isTerminalStatus(order.status);
      if (_previousOrderStatus == null && isTerminal) {
        _isHistoricalView = true;
      }
      _previousOrderStatus = order.status;
      context.read<DriverOrderCubit>().init(order);
    }
  }

  /// Check if order status is terminal (completed or cancelled)
  bool _isTerminalStatus(OrderStatus status) {
    return status == OrderStatus.COMPLETED ||
        status == OrderStatus.CANCELLED_BY_USER ||
        status == OrderStatus.CANCELLED_BY_DRIVER ||
        status == OrderStatus.CANCELLED_BY_MERCHANT ||
        status == OrderStatus.CANCELLED_BY_SYSTEM ||
        status == OrderStatus.NO_SHOW;
  }

  Future<void> _onRefresh() async {
    await _initializeOrder();
  }

  @override
  void dispose() {
    _locationStreamSubscription?.cancel();
    _animatedDriverMarker.dispose();
    _mapController?.dispose();
    _mapController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverOrderCubit, DriverOrderState>(
      listener: (context, state) {
        // Show error messages
        if (state.fetchOrderResult.isFailure) {
          context.showMyToast(
            state.fetchOrderResult.error?.message ??
                context.l10n.an_error_occurred,
            type: ToastType.failed,
          );
        }

        // Show success messages for various actions
        if (state.acceptOrderResult.isSuccess ||
            state.markArrivedResult.isSuccess ||
            state.startTripResult.isSuccess ||
            state.completeTripResult.isSuccess) {
          context.showMyToast("Status updated", type: ToastType.success);
        }

        // Navigate back when order status TRANSITIONS to completed or cancelled
        // Skip if this is a historical view (order was already terminal on load)
        final currentStatus = state.orderStatus;
        final isTerminal =
            currentStatus != null && _isTerminalStatus(currentStatus);
        final wasTerminalBefore =
            _previousOrderStatus != null &&
            _isTerminalStatus(_previousOrderStatus!);
        final isStatusTransition =
            isTerminal && !wasTerminalBefore && !_isHistoricalView;

        if (isStatusTransition) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted && context.mounted) {
              context.popUntilRoot();
            }
          });
        }

        // Update previous status for next comparison
        if (currentStatus != null) {
          _previousOrderStatus = currentStatus;
        }

        // Update map when order data changes
        final currentOrder = state.currentOrder;
        if (currentOrder != null && mounted) {
          _updateMapWithOrderData(currentOrder);
        }
      },
      builder: (context, state) {
        if (state.currentOrder == null) {
          return const Scaffold(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final order = state.currentOrder;
        if (order == null) {
          return const Scaffold(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final status = state.orderStatus;

        return Scaffold(
          headers: [
            AppBar(
              leading: [
                IconButton(
                  icon: const Icon(LucideIcons.arrowLeft),
                  onPressed: () => context.pop(),
                  variance: ButtonVariance.ghost,
                ),
              ],
              title: Text(
                context.l10n.text_order_id_short(order.id.substring(0, 8)),
              ),
            ),
          ],
          child: Column(
            children: [
              // Map view
              Expanded(flex: 2, child: _buildMap(order)),
              // Order details and actions
              Expanded(
                flex: 3,
                child: SafeRefreshTrigger(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.dg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20.h,
                      children: [
                        if (status != null)
                          _buildStatusIndicator(context, status),
                        _buildOrderInfo(order),
                        _buildCustomerInfo(order),
                        _buildActionButtons(state, order),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMap(Order order) {
    return Stack(
      children: [
        MapWrapperWidget(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              order.pickupLocation.y.toDouble(),
              order.pickupLocation.x.toDouble(),
            ),
            zoom: 14,
          ),
          markers: _markers,
          polylines: _polylines,
          myLocationEnabled: false, // Use bike marker instead of blue dot
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            if (!mounted) return;
            _mapController = controller;
            _updateMapWithOrderData(order);
          },
        ),
        // Center on driver location button
        Positioned(
          bottom: 80,
          right: 16,
          child: IconButton.primary(
            onPressed: _centerOnDriverLocation,
            icon: const Icon(LucideIcons.locateFixed),
          ),
        ),
        // Emergency button - only show during IN_TRIP status
        BlocBuilder<DriverOrderCubit, DriverOrderState>(
          builder: (context, state) {
            if (state.orderStatus != OrderStatus.IN_TRIP) {
              return const SizedBox.shrink();
            }

            // Use pickup location as fallback for emergency location
            final emergencyLocation = EmergencyLocation(
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
    );
  }

  /// Center map on driver's current location
  Future<void> _centerOnDriverLocation() async {
    final driverLocation = _currentDriverLocation;
    final mapController = _mapController;
    if (driverLocation != null && mapController != null && mounted) {
      try {
        if (_mapController != null) {
          await mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(driverLocation.y.toDouble(), driverLocation.x.toDouble()),
              16,
            ),
          );
        }
      } catch (e) {
        logger.e('[DriverOrderDetailScreen] - Map controller error: $e');
      }
    }
  }

  Future<void> _updateMapWithOrderData(Order order) async {
    // Prevent updates if widget is disposed
    if (!mounted) return;

    // Prevent concurrent updates
    if (_isUpdatingMap) return;
    _isUpdatingMap = true;

    try {
      final pickupLat = order.pickupLocation.y.toDouble();
      final pickupLng = order.pickupLocation.x.toDouble();
      final dropoffLat = order.dropoffLocation.y.toDouble();
      final dropoffLng = order.dropoffLocation.x.toDouble();

      // Get driver's current location
      final locationService = sl<LocationService>();
      _currentDriverLocation = await locationService.getMyLocation(
        accuracy: LocationAccuracy.high,
        fromCache: false,
      );

      // Check mounted again after async operation
      if (!mounted) {
        _isUpdatingMap = false;
        return;
      }

      String pickupTitle = 'Pickup';
      String dropoffTitle = 'Dropoff';
      if (mounted && context.mounted) {
        pickupTitle = context.l10n.pickup_location;
        dropoffTitle = context.l10n.dropoff_location;
      }

      final newMarkers = <Marker>{}
        ..add(
          Marker(
            markerId: const MarkerId('pickup'),
            position: LatLng(pickupLat, pickupLng),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            infoWindow: InfoWindow(title: pickupTitle),
          ),
        )
        ..add(
          Marker(
            markerId: const MarkerId('dropoff'),
            position: LatLng(dropoffLat, dropoffLng),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            infoWindow: InfoWindow(title: dropoffTitle),
          ),
        );

      // Initialize driver marker with current location using bike icon
      final driverLocation = _currentDriverLocation;
      if (driverLocation != null) {
        _animatedDriverMarker.updateDriverLocation(
          driverLocation,
          animate: false, // No animation on initial load
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
      final mapService = sl<MapService>();
      final orderStatus = order.status;

      // Determine route based on order status
      // ACCEPTED/ARRIVING: Driver heading to pickup
      // IN_TRIP: Driver heading to dropoff
      final isDriverHeadingToPickup =
          orderStatus == OrderStatus.ACCEPTED ||
          orderStatus == OrderStatus.ARRIVING;
      final isInTrip = orderStatus == OrderStatus.IN_TRIP;

      try {
        // Always get pickup-to-dropoff route
        final pickupToDropoffRoute = await mapService.getRoutes(
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
          final driverToPickupRoute = await mapService.getRoutes(
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
              polylineId: const PolylineId('driver_to_pickup'),
              points: driverToPickupPoints,
              color: primaryColor,
              width: 5,
            ),
          );

          // Pickup to dropoff - dimmed (planned route)
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId('pickup_to_dropoff'),
              points: pickupToDropoffPoints,
              color: dimmedColor,
              width: 4,
              patterns: [PatternItem.dash(10), PatternItem.gap(5)],
            ),
          );
        } else if (isInTrip && driverLocation != null) {
          // During trip: show driver-to-dropoff route (highlighted)
          final driverToDropoffRoute = await mapService.getRoutes(
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
              polylineId: const PolylineId('driver_to_dropoff'),
              points: driverToDropoffPoints,
              color: primaryColor,
              width: 5,
            ),
          );
        } else {
          // Fallback: just show pickup-to-dropoff route
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId('pickup_to_dropoff'),
              points: pickupToDropoffPoints,
              color: primaryColor,
              width: 4,
            ),
          );
        }
      } catch (e) {
        logger.e('[DriverOrderDetailScreen] - Failed to get route: $e');
        // Fallback to straight line on error
        newPolylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
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

      setState(() {
        _markers = newMarkers;
        _polylines = newPolylines;
      });

      // Fit bounds to show all relevant points
      final mapController = _mapController;
      if (mapController != null && mounted) {
        final allPoints = <LatLng>[
          LatLng(pickupLat, pickupLng),
          LatLng(dropoffLat, dropoffLng),
        ];

        // Include driver location in bounds if available
        if (driverLocation != null) {
          allPoints.add(
            LatLng(driverLocation.y.toDouble(), driverLocation.x.toDouble()),
          );
        }

        double minLat = allPoints.first.latitude;
        double maxLat = allPoints.first.latitude;
        double minLng = allPoints.first.longitude;
        double maxLng = allPoints.first.longitude;

        for (final point in allPoints) {
          if (point.latitude < minLat) minLat = point.latitude;
          if (point.latitude > maxLat) maxLat = point.latitude;
          if (point.longitude < minLng) minLng = point.longitude;
          if (point.longitude > maxLng) maxLng = point.longitude;
        }

        final bounds = LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        );

        // Wrap in try-catch to handle disposed controller
        try {
          if (mounted && _mapController != null) {
            await mapController.animateCamera(
              CameraUpdate.newLatLngBounds(bounds, 100),
            );
          }
        } catch (e) {
          logger.e('[DriverOrderDetailScreen] - Map controller error: $e');
        }
      }
    } finally {
      _isUpdatingMap = false;
    }
  }

  Widget _buildStatusIndicator(BuildContext context, OrderStatus status) {
    String statusText;
    Color statusColor;

    switch (status) {
      case OrderStatus.REQUESTED:
        statusText = context.l10n.requested;
        statusColor = const Color(0xFFFF9800);
      case OrderStatus.MATCHING:
        statusText = context.l10n.finding_driver;
        statusColor = const Color(0xFF2196F3);
      case OrderStatus.PREPARING:
        statusText = context.l10n.preparing_order;
        statusColor = const Color(0xFFFF9800);
      case OrderStatus.READY_FOR_PICKUP:
        statusText = context.l10n.ready_for_pickup;
        statusColor = const Color(0xFF4CAF50);
      case OrderStatus.ACCEPTED:
        statusText = context.l10n.accepted;
        statusColor = const Color(0xFF4CAF50);
      case OrderStatus.ARRIVING:
        statusText = context.l10n.arriving;
        statusColor = const Color(0xFF2196F3);
      case OrderStatus.IN_TRIP:
        statusText = context.l10n.in_trip;
        statusColor = const Color(0xFF9C27B0);
      case OrderStatus.COMPLETED:
        statusText = context.l10n.completed;
        statusColor = const Color(0xFF4CAF50);
      case OrderStatus.CANCELLED_BY_USER:
        statusText = context.l10n.cancelled_by_user;
        statusColor = const Color(0xFFF44336);
      case OrderStatus.CANCELLED_BY_DRIVER:
        statusText = context.l10n.cancelled_by_driver;
        statusColor = const Color(0xFFF44336);
      case OrderStatus.CANCELLED_BY_MERCHANT:
        statusText = context.l10n.cancelled_by_merchant;
        statusColor = const Color(0xFFF44336);
      case OrderStatus.CANCELLED_BY_SYSTEM:
        statusText = context.l10n.cancelled_by_system;
        statusColor = const Color(0xFFF44336);
      case OrderStatus.NO_SHOW:
        statusText = 'No Show';
        statusColor = const Color(0xFFFF5722);
      case OrderStatus.SCHEDULED:
        statusText = context.l10n.scheduled;
        statusColor = const Color(0xFF00BCD4);
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: statusColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8.w,
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            statusText,
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              'Order Details',
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            _buildInfoRow(
              LucideIcons.package,
              context.l10n.service,
              order.type.name,
            ),
            _buildLocationInfoRow(
              LucideIcons.mapPin,
              context.l10n.pickup_location,
              order.pickupAddress,
              order.pickupLocation,
            ),
            _buildLocationInfoRow(
              LucideIcons.navigation,
              context.l10n.dropoff_location,
              order.dropoffAddress,
              order.dropoffLocation,
            ),
            _buildInfoRow(
              LucideIcons.ruler,
              context.l10n.distance,
              '${order.distanceKm.toStringAsFixed(2)} km',
            ),
            _buildInfoRow(
              LucideIcons.dollarSign,
              context.l10n.fare,
              context.formatCurrency(order.totalPrice),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfo(Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Text(
              context.l10n.customer_info,
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              spacing: 12.w,
              children: [
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    border: Border.all(
                      color: context.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      order.user?.name?.substring(0, 1).toUpperCase() ?? 'U',
                      style: context.typography.h3.copyWith(
                        fontSize: 20.sp,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        order.user?.name ?? context.l10n.text_unknown_user,
                        style: context.typography.h4.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          final phone = order.user?.phone;
                          if (phone == null) return const SizedBox.shrink();

                          return Text(
                            _formatPhone(phone),
                            style: context.typography.small.copyWith(
                              fontSize: 14.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.phone),
                  onPressed: () {
                    final phone = order.user?.phone;
                    if (phone != null) {
                      _showCallDialog(context, phone);
                    } else {
                      context.showMyToast(
                        context.l10n.customer_phone_number_not_available,
                        type: ToastType.warning,
                      );
                    }
                  },
                  variance: ButtonVariance.ghost,
                ),
                ChatButtonWithBadge(
                  orderId: order.id,
                  onPressed: () {
                    _showChatDialog(context, order.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(DriverOrderState state, Order order) {
    final status = state.orderStatus;

    // Pending order - show accept/reject
    if (status == OrderStatus.REQUESTED || status == OrderStatus.MATCHING) {
      final isAccepting = state.acceptOrderResult.isLoading;
      final isRejecting = state.rejectOrderResult.isLoading;

      return Row(
        spacing: 12.w,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ActionButton.outline(
                isLoading: isRejecting,
                enabled: !isAccepting,
                onPressed: () => _showRejectDialog(context, order.id),
                child: Text(context.l10n.reject_order),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ActionButton.primary(
                isLoading: isAccepting,
                enabled: !isRejecting,
                onPressed: () {
                  final orderId = order.id;
                  final driverId =
                      context.read<AuthCubit>().state.driver.value?.id ?? '';
                  context.read<DriverOrderCubit>().acceptOrder(
                    orderId,
                    driverId,
                  );
                },
                child: Text(context.l10n.accept_order),
              ),
            ),
          ),
        ],
      );
    }

    // Accepted - show arriving button
    if (status == OrderStatus.ACCEPTED) {
      final isMarkingArrived = state.markArrivedResult.isLoading;
      final isCanceling = state.cancelOrderResult.isLoading;

      return Column(
        spacing: 12.h,
        children: [
          // Show photo upload button for DELIVERY orders
          if (order.type == OrderType.DELIVERY)
            _buildDeliveryItemPhotoButton(order),
          SizedBox(
            width: double.infinity,
            child: ActionButton.primary(
              isLoading: isMarkingArrived,
              enabled: !isCanceling,
              onPressed: () => context.read<DriverOrderCubit>().markArrived(),
              child: Text(context.l10n.mark_as_arrived),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ActionButton.outline(
              isLoading: isCanceling,
              enabled: !isMarkingArrived,
              onPressed: () => _showCancelDialog(context, order.id),
              child: Text(context.l10n.cancel_order),
            ),
          ),
        ],
      );
    }

    // Arriving - show start trip button
    if (status == OrderStatus.ARRIVING) {
      final isStartingTrip = state.startTripResult.isLoading;
      final isCanceling = state.cancelOrderResult.isLoading;

      return Column(
        spacing: 12.h,
        children: [
          // Show photo upload button for DELIVERY orders
          if (order.type == OrderType.DELIVERY)
            _buildDeliveryItemPhotoButton(order),
          SizedBox(
            width: double.infinity,
            child: ActionButton.primary(
              isLoading: isStartingTrip,
              enabled: !isCanceling,
              onPressed: () => context.read<DriverOrderCubit>().startTrip(),
              child: Text(context.l10n.start_trip),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ActionButton.outline(
              isLoading: isCanceling,
              enabled: !isStartingTrip,
              onPressed: () => _showCancelDialog(context, order.id),
              child: Text(context.l10n.cancel_order),
            ),
          ),
        ],
      );
    }

    // In trip - show complete trip button
    if (status == OrderStatus.IN_TRIP) {
      final isCompletingTrip = state.completeTripResult.isLoading;

      return SizedBox(
        width: double.infinity,
        child: ActionButton.primary(
          isLoading: isCompletingTrip,
          onPressed: () {
            context.read<DriverOrderCubit>().completeTrip();
            // Refresh stats after trip completion
            context.read<DriverProfileCubit>().refreshStats();
          },
          child: Text(context.l10n.complete_trip),
        ),
      );
    }

    // Completed - show rating and back button
    if (status == OrderStatus.COMPLETED) {
      return Column(
        spacing: 12.h,
        children: [
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPressed: () async {
                await showReviewDialog(
                  context: context,
                  orderId: order.id,
                  toUserId: order.userId,
                  toUserName: order.user?.name ?? context.l10n.text_customer,
                );
              },
              child: Text(context.l10n.rate_customer),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              onPressed: () => context.goNamed(Routes.driverHome.name),
              child: Text(context.l10n.back_to_home),
            ),
          ),
        ],
      );
    }

    // Cancelled - show back button only
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        onPressed: () => context.goNamed(Routes.driverHome.name),
        child: Text(context.l10n.back_to_home),
      ),
    );
  }

  /// Build the delivery item photo upload button for DELIVERY orders
  Widget _buildDeliveryItemPhotoButton(Order order) {
    // Note: deliveryItemPhotoUrl will be available after API client regeneration
    // For now, we always show the "Take Item Photo" button
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        onPressed: () => _showDeliveryItemPhotoDialog(context, order.id),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.w,
          children: [
            Icon(LucideIcons.camera, size: 20.sp),
            const Text('Take Item Photo'),
          ],
        ),
      ),
    );
  }

  void _showDeliveryItemPhotoDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<DriverOrderCubit>(),
        child: DeliveryItemPhotoUploadDialog(orderId: orderId),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.w,
      children: [
        Icon(icon, size: 20.sp, color: context.colorScheme.mutedForeground),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              Text(
                label,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
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

  Widget _buildLocationInfoRow(
    IconData icon,
    String label,
    String? address,
    Coordinate coordinate,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.w,
      children: [
        Icon(icon, size: 20.sp, color: context.colorScheme.mutedForeground),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              Text(
                label,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
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

  String _formatPhone(Phone phone) {
    return '+${phone.countryCode.value}${phone.number}';
  }

  void _showRejectDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.reject_order),
        content: Text(context.l10n.are_you_sure_you_want_to_reject_this_order),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          DestructiveButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<DriverOrderCubit>().rejectOrder(orderId);
            },
            child: Text(context.l10n.reject_order),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.cancel_order),
        content: Text(context.l10n.are_you_sure_you_want_to_cancel_this_order),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.no),
          ),
          DestructiveButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<DriverOrderCubit>().cancelOrder();
            },
            child: Text(context.l10n.yes_cancel),
          ),
        ],
      ),
    );
  }

  void _showCallDialog(BuildContext context, Phone phone) {
    final phoneNumber = '+${phone.countryCode.value}${phone.number}';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.button_call_customer),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Text(
              context.l10n.customer_phone_number,
              style: context.typography.p.copyWith(fontSize: 14.sp),
            ),
            SelectableText(
              phoneNumber,
              style: context.typography.h3.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              context
                  .l10n
                  .tap_the_phone_number_to_copy_it_then_use_your_phone_app_to_call,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
        actions: [
          PrimaryButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.close),
          ),
        ],
      ),
    );
  }

  void _showChatDialog(BuildContext context, String orderId) {
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
                  context.l10n.chat_with_customer,
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
            Expanded(child: OrderChatWidget(orderId: orderId)),
          ],
        ),
      ),
    );
  }
}
