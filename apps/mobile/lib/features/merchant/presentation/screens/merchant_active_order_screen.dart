import "package:akademove/app/router/router.dart";
import "package:akademove/core/_export.dart";
import "package:akademove/features/features.dart";
import "package:akademove/l10n/l10n.dart";
import "package:akademove/locator.dart";
import "package:api_client/api_client.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:intl/intl.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

class MerchantActiveOrderScreen extends StatefulWidget {
  const MerchantActiveOrderScreen({required this.orderId, super.key});

  final String orderId;

  @override
  State<MerchantActiveOrderScreen> createState() =>
      _MerchantActiveOrderScreenState();
}

class _MerchantActiveOrderScreenState extends State<MerchantActiveOrderScreen> {
  String? _merchantId;
  OrderStatus? _previousStatus;
  late final MerchantOrderCubit _merchantOrderCubit;

  // Map related state
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  bool _isMapReady = false;
  bool _isFirstLoad = true;

  /// Animated driver marker for smooth location updates
  late final AnimatedDriverMarker _animatedDriverMarker;

  @override
  void initState() {
    super.initState();
    _merchantOrderCubit = context.read<MerchantOrderCubit>();
    _animatedDriverMarker = AnimatedDriverMarker(
      onMarkerUpdated: _onDriverMarkerUpdated,
    );
    _loadMerchantId();
    _subscribeToOrderUpdates();
    _initMarkerIcons();
  }

  @override
  void dispose() {
    _unsubscribeFromOrderUpdates();
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

    // Check if driver marker actually changed position
    final existingDriverMarker = _markers.cast<Marker?>().firstWhere(
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
        _markers.where((m) => m.markerId.value != "driver").toSet()
          ..add(driverMarker);

    setState(() {
      _markers = newMarkers;
    });

    // Follow driver on map during initial load
    if (_isFirstLoad && _isMapReady) {
      _isFirstLoad = false;
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(driverMarker.position),
      );
    }
  }

  Future<void> _loadMerchantId() async {
    try {
      // Get merchant ID from MerchantCubit
      final merchantState = context.read<MerchantCubit>().state;
      final currentMerchant = merchantState.mine.value;

      if (currentMerchant != null) {
        setState(() {
          _merchantId = currentMerchant.id;
        });
      }
    } catch (e) {
      // Silently fail - merchantId will be checked before actions
    }
  }

  Future<void> _subscribeToOrderUpdates() async {
    await _merchantOrderCubit.subscribeToOrder(widget.orderId);
  }

  Future<void> _unsubscribeFromOrderUpdates() async {
    await _merchantOrderCubit.unsubscribeFromOrder();
  }

  Future<void> _handleAcceptOrder() async {
    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.accept_order),
        content: Text(context.l10n.message_confirm_accept_order),
        actions: [
          Button.ghost(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          Button.primary(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.accept),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<MerchantOrderCubit>().acceptOrder(
        merchantId: merchantId,
        orderId: widget.orderId,
      );
    }
  }

  Future<void> _handleRejectOrder() async {
    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    final result = await showOrderRejectionDialog(context: context);

    if (result != null && mounted) {
      context.read<MerchantOrderCubit>().rejectOrder(
        merchantId: merchantId,
        orderId: widget.orderId,
        reason: result.reason,
        note: result.note,
      );
    }
  }

  void _handleMarkPreparing() {
    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    context.read<MerchantOrderCubit>().markPreparing(
      merchantId: merchantId,
      orderId: widget.orderId,
    );
  }

  void _handleMarkReady() {
    final merchantId = _merchantId;
    if (merchantId == null) {
      context.showMyToast(
        context.l10n.toast_merchant_id_not_found,
        type: ToastType.failed,
      );
      return;
    }

    context.read<MerchantOrderCubit>().markReady(
      merchantId: merchantId,
      orderId: widget.orderId,
    );
  }

  /// Navigate to review screen after order completion
  Future<void> _navigateToReviewScreen(Order order) async {
    if (!mounted || !context.mounted) return;

    // Small delay to let the UI update
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted || !context.mounted) return;

    final user = order.user;

    context.pushNamed(
      Routes.merchantOrderCompletion.name,
      extra: {
        "orderId": order.id,
        "orderType": order.type,
        "order": order,
        "user": user,
        "payment": null,
      },
    );
  }

  /// Setup map markers and polylines for the order
  Future<void> _setupMapForOrder(Order order) async {
    if (!mounted) return;

    final pickupLat = order.pickupLocation.y.toDouble();
    final pickupLng = order.pickupLocation.x.toDouble();
    final dropoffLat = order.dropoffLocation.y.toDouble();
    final dropoffLng = order.dropoffLocation.x.toDouble();

    // Create markers
    final newMarkers = <Marker>{
      Marker(
        markerId: const MarkerId("merchant"),
        position: LatLng(pickupLat, pickupLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: context.l10n.pickup_location),
      ),
      Marker(
        markerId: const MarkerId("dropoff"),
        position: LatLng(dropoffLat, dropoffLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: context.l10n.dropoff_location),
      ),
    };

    // Add driver marker if driver is assigned and has location
    final driverLocation = order.driver?.currentLocation;
    if (driverLocation != null) {
      _animatedDriverMarker.updateDriverLocation(
        driverLocation,
        orderDriver: order.driver,
      );
    }

    // Try to get route polylines
    Set<Polyline> newPolylines = {};
    try {
      final mapService = sl<MapService>();

      // Get route from merchant to dropoff (main delivery route)
      final routePoints = await mapService.getRoutes(
        order.pickupLocation,
        order.dropoffLocation,
      );

      if (routePoints.isNotEmpty) {
        newPolylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            points: routePoints
                .map((c) => LatLng(c.y.toDouble(), c.x.toDouble()))
                .toList(),
            color: context.colorScheme.primary,
            width: 4,
          ),
        );
      }

      // If driver is approaching merchant, also show driver-to-merchant route
      if (driverLocation != null &&
          _isDriverApproachingMerchant(order.status)) {
        final driverToMerchantRoute = await mapService.getRoutes(
          driverLocation,
          order.pickupLocation,
        );

        if (driverToMerchantRoute.isNotEmpty) {
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId("driver_route"),
              points: driverToMerchantRoute
                  .map((c) => LatLng(c.y.toDouble(), c.x.toDouble()))
                  .toList(),
              color: const Color(0xFF2196F3), // Blue for driver route
              width: 4,
              patterns: [PatternItem.dash(20), PatternItem.gap(10)],
            ),
          );
        }
      }
    } catch (e) {
      // Fallback to straight line
      newPolylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: [
            LatLng(pickupLat, pickupLng),
            LatLng(dropoffLat, dropoffLng),
          ],
          color: context.colorScheme.primary,
          width: 4,
        ),
      );
    }

    if (!mounted) return;

    setState(() {
      _markers = newMarkers;
      _polylines = newPolylines;
    });

    // Fit bounds
    _fitMapBounds(order);
  }

  /// Check if driver is approaching merchant (before pickup)
  bool _isDriverApproachingMerchant(OrderStatus? status) {
    return status == OrderStatus.ARRIVING ||
        (status == OrderStatus.ACCEPTED) ||
        status == OrderStatus.READY_FOR_PICKUP;
  }

  void _fitMapBounds(Order order) {
    final controller = _mapController;
    if (controller == null || !_isMapReady) return;

    final pickupLat = order.pickupLocation.y.toDouble();
    final pickupLng = order.pickupLocation.x.toDouble();
    final dropoffLat = order.dropoffLocation.y.toDouble();
    final dropoffLng = order.dropoffLocation.x.toDouble();

    final bounds = LatLngBounds(
      southwest: LatLng(
        pickupLat < dropoffLat ? pickupLat : dropoffLat,
        pickupLng < dropoffLng ? pickupLng : dropoffLng,
      ),
      northeast: LatLng(
        pickupLat > dropoffLat ? pickupLat : dropoffLat,
        pickupLng > dropoffLng ? pickupLng : dropoffLng,
      ),
    );

    try {
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
    } catch (e) {
      // Ignore map controller errors
    }
  }

  /// Get order from cubit state - check both `order` and `orders` list
  Order? _getOrderFromState(MerchantOrderState state) {
    // First try to get from selected order
    final selectedOrder = state.order.value;
    if (selectedOrder != null && selectedOrder.id == widget.orderId) {
      return selectedOrder;
    }

    // Fall back to orders list
    final orders = state.orders.value;
    if (orders != null) {
      return orders.where((o) => o.id == widget.orderId).firstOrNull;
    }

    return null;
  }

  /// Calculate estimated delivery time based on distance and order status
  /// For campus delivery, assume average speed of 15 km/h
  /// Food orders include preparation time (5-10 min based on status)
  String _formatEstimatedTime(Order order) {
    // Average campus motorcycle speed: 15 km/h
    const averageSpeedKmPerHour = 15.0;

    // Calculate travel time in minutes
    final travelMinutes = (order.distanceKm / averageSpeedKmPerHour * 60)
        .ceil();

    // Add preparation time based on order status
    int prepMinutes = 0;
    if (order.type == OrderType.FOOD) {
      switch (order.status) {
        case OrderStatus.REQUESTED:
        case OrderStatus.MATCHING:
          prepMinutes = 10;
        case OrderStatus.ACCEPTED:
          prepMinutes = 8;
        case OrderStatus.PREPARING:
          prepMinutes = 5;
        case OrderStatus.READY_FOR_PICKUP:
        case OrderStatus.ARRIVING:
        case OrderStatus.IN_TRIP:
          prepMinutes = 0;
        default:
          prepMinutes = 0;
      }
    }

    // Minimum 5 minutes for any delivery
    final totalMinutes = (travelMinutes + prepMinutes).clamp(5, 60);

    if (totalMinutes < 60) {
      return "~$totalMinutes min";
    } else {
      final hours = totalMinutes ~/ 60;
      final remainingMinutes = totalMinutes % 60;
      if (remainingMinutes == 0) {
        return "~$hours hr";
      }
      return "~$hours hr $remainingMinutes min";
    }
  }

  // ============================================
  // BUILD METHODS
  // ============================================

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen for accept order result
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) =>
              previous.acceptOrderResult != current.acceptOrderResult,
          listener: (context, state) {
            if (state.acceptOrderResult.isSuccess) {
              final message = state.acceptOrderResult.message;
              if (message != null && message.isNotEmpty) {
                context.showMyToast(message, type: ToastType.success);
              }
            }
            if (state.acceptOrderResult.isFailure) {
              context.showMyToast(
                state.acceptOrderResult.error?.message ??
                    context.l10n.an_error_occurred,
                type: ToastType.failed,
              );
            }
          },
        ),
        // Listen for reject order result
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) =>
              previous.rejectOrderResult != current.rejectOrderResult,
          listener: (context, state) {
            if (state.rejectOrderResult.isSuccess) {
              final updatedOrder = state.rejectOrderResult.value;
              if (updatedOrder != null && updatedOrder.id == widget.orderId) {
                final message = state.rejectOrderResult.message;
                if (message != null && message.isNotEmpty) {
                  context.showMyToast(message, type: ToastType.success);
                }
                // Navigate back after rejection
                context.pop();
              }
            }
            if (state.rejectOrderResult.isFailure) {
              context.showMyToast(
                state.rejectOrderResult.error?.message ??
                    context.l10n.an_error_occurred,
                type: ToastType.failed,
              );
            }
          },
        ),
        // Listen for mark preparing result
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) =>
              previous.markPreparingResult != current.markPreparingResult,
          listener: (context, state) {
            if (state.markPreparingResult.isSuccess) {
              final message = state.markPreparingResult.message;
              if (message != null && message.isNotEmpty) {
                context.showMyToast(message, type: ToastType.success);
              }
            }
            if (state.markPreparingResult.isFailure) {
              context.showMyToast(
                state.markPreparingResult.error?.message ??
                    context.l10n.an_error_occurred,
                type: ToastType.failed,
              );
            }
          },
        ),
        // Listen for mark ready result
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) =>
              previous.markReadyResult != current.markReadyResult,
          listener: (context, state) {
            if (state.markReadyResult.isSuccess) {
              final message = state.markReadyResult.message;
              if (message != null && message.isNotEmpty) {
                context.showMyToast(message, type: ToastType.success);
              }
            }
            if (state.markReadyResult.isFailure) {
              context.showMyToast(
                state.markReadyResult.error?.message ??
                    context.l10n.an_error_occurred,
                type: ToastType.failed,
              );
            }
          },
        ),
        // Listen for order completion to navigate to review screen
        BlocListener<MerchantOrderCubit, MerchantOrderState>(
          listenWhen: (previous, current) {
            final prevOrder = _getOrderFromState(previous);
            final currOrder = _getOrderFromState(current);
            return prevOrder?.status != currOrder?.status;
          },
          listener: (context, state) {
            final order = _getOrderFromState(state);
            if (order == null) return;

            final newStatus = order.status;

            // Check if order just transitioned to COMPLETED
            if (_previousStatus != null &&
                _previousStatus != OrderStatus.COMPLETED &&
                newStatus == OrderStatus.COMPLETED) {
              _navigateToReviewScreen(order);
            }

            _previousStatus = newStatus;
          },
        ),
      ],
      child: BlocBuilder<MerchantOrderCubit, MerchantOrderState>(
        builder: (context, state) {
          final order = _getOrderFromState(state);

          // Show loading if order not yet available
          if (order == null) {
            return Scaffold(
              headers: [
                DefaultAppBar(
                  title: context.l10n.order_detail,
                  subtitle: "F-${widget.orderId.prefix(8)}",
                ),
              ],
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          // Update previous status for completion detection
          _previousStatus ??= order.status;

          // Setup map when order is available
          if (_markers.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _setupMapForOrder(order);
            });
          }

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
                  context.l10n.text_order_id_short(order.id.prefix(8)),
                ),
              ),
            ],
            child: Column(
              children: [
                // Map view - same as driver screen
                Expanded(flex: 2, child: _buildMap(order)),
                // Order details and actions
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.dg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16.h,
                      children: [
                        _MerchantOrderProgressIndicator(
                          status: order.status,
                          driverId: order.driverId,
                        ),
                        _buildCustomerInfoCard(context, order),
                        if (order.driverId != null)
                          _buildDriverInfoCard(context, order),
                        _buildDeliveryLocationCard(context, order),
                        _buildOrderItemsCard(context, order),
                        _buildOrderSummaryCard(context, order),
                        if (_hasNotes(order)) _buildNotesCard(context, order),
                        // Show timeline for tracking order progress
                        OrderTimelineWidget(order: order),
                        // Show cancel reason for cancelled orders
                        if (_isCancelledStatus(order.status) &&
                            order.cancelReason != null &&
                            order.cancelReason!.isNotEmpty)
                          _buildCancelReasonCard(context, order),
                        // Show earnings breakdown for completed orders
                        if (order.status == OrderStatus.COMPLETED)
                          _buildMerchantEarningsCard(context, order),
                        // Action buttons at the bottom
                        _buildActionButtons(context, state, order),
                        // Add padding for safe area
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            if (!mounted) return;
            _mapController = controller;
            _isMapReady = true;
            _setupMapForOrder(order);
          },
        ),
        // Center on route button
        Positioned(
          bottom: 16,
          right: 16,
          child: IconButton.primary(
            onPressed: () => _fitMapBounds(order),
            icon: const Icon(LucideIcons.maximize2),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerInfoCard(BuildContext context, Order order) {
    final userName = order.user?.name ?? context.l10n.text_customer;
    final userImage = order.user?.image;
    final userRating = order.user?.rating;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.user,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  context.l10n.customer_info,
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              spacing: 12.w,
              children: [
                // Customer avatar
                if (userImage != null && userImage.isNotEmpty)
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: userImage,
                      width: 56.w,
                      height: 56.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 56.w,
                        height: 56.w,
                        color: context.colorScheme.muted,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          _buildAvatarFallback(
                            context,
                            userName,
                            context.colorScheme.primary,
                          ),
                    ),
                  )
                else
                  _buildAvatarFallback(
                    context,
                    userName,
                    context.colorScheme.primary,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        userName,
                        style: context.typography.h4.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          if (userRating != null && userRating > 0) ...[
                            Icon(
                              LucideIcons.star,
                              size: 14.sp,
                              color: const Color(0xFFFFC107),
                            ),
                            Gap(4.w),
                            Text(
                              userRating.toStringAsFixed(1),
                              style: context.typography.small.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
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
                          Text(
                            context.l10n.text_customer,
                            style: context.typography.small.copyWith(
                              fontSize: 13.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Chat button
                ChatButtonWithBadge(
                  orderId: order.id,
                  onPressed: () => _showChatDialog(context, order.id),
                  variance: ButtonVariance.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfoCard(BuildContext context, Order order) {
    final driver = order.driver;
    if (driver == null) return const SizedBox.shrink();

    final driverName = driver.user?.name ?? context.l10n.text_driver;
    final driverImage = driver.user?.image;
    final driverRating = driver.rating;
    final licensePlate = driver.licensePlate;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.bike,
                  size: 20.sp,
                  color: context.colorScheme.secondary,
                ),
                Text(
                  context.l10n.text_driver,
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              spacing: 12.w,
              children: [
                // Driver avatar
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
                      errorWidget: (context, url, error) =>
                          _buildAvatarFallback(
                            context,
                            driverName,
                            context.colorScheme.secondary,
                          ),
                    ),
                  )
                else
                  _buildAvatarFallback(
                    context,
                    driverName,
                    context.colorScheme.secondary,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        driverName,
                        style: context.typography.h4.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          // License plate badge
                          if (licensePlate != null && licensePlate.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.muted,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                licensePlate,
                                style: context.typography.small.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          // Driver rating
                          if (driverRating != null && driverRating > 0) ...[
                            if (licensePlate != null) Gap(12.w),
                            Icon(
                              LucideIcons.star,
                              size: 14.sp,
                              color: const Color(0xFFFFC107),
                            ),
                            Gap(4.w),
                            Text(
                              driverRating.toStringAsFixed(1),
                              style: context.typography.small.copyWith(
                                fontSize: 12.sp,
                                color: context.colorScheme.mutedForeground,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                // Chat button
                ChatButtonWithBadge(
                  orderId: order.id,
                  onPressed: () => _showChatDialog(context, order.id),
                  variance: ButtonVariance.outline,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryLocationCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.mapPin,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  context.l10n.delivery_location,
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            // Pickup location (Merchant location)
            _buildLocationRow(
              context,
              icon: LucideIcons.store,
              iconColor: const Color(0xFFFF9800),
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
            // Dropoff location (Customer location)
            _buildLocationRow(
              context,
              icon: LucideIcons.navigation,
              iconColor: const Color(0xFFF44336),
              label: context.l10n.dropoff_location,
              address: order.dropoffAddress,
              coordinate: order.dropoffLocation,
            ),
            const Divider(),
            // Distance info
            Row(
              children: [
                Icon(
                  LucideIcons.route,
                  size: 16.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                Gap(8.w),
                Text(
                  context.l10n.distance,
                  style: context.typography.small.copyWith(
                    fontSize: 13.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                const Spacer(),
                Text(
                  "${order.distanceKm.toStringAsFixed(2)} km",
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Gap(8.h),
            // Estimated delivery time
            Row(
              children: [
                Icon(
                  LucideIcons.clock,
                  size: 16.sp,
                  color: context.colorScheme.primary,
                ),
                Gap(8.w),
                Text(
                  context.l10n.estimated_delivery,
                  style: context.typography.small.copyWith(
                    fontSize: 13.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    _formatEstimatedTime(order),
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary,
                    ),
                  ),
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
        Icon(icon, size: 22.sp, color: iconColor),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(
                label,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              if (address != null && address.isNotEmpty)
                Text(
                  address,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              else
                AddressText(
                  address: null,
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

  Widget _buildOrderItemsCard(BuildContext context, Order order) {
    final items = order.items ?? [];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.utensils,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  context.l10n.order_items,
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "${items.length} ${items.length == 1 ? "item" : "items"}",
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            const Divider(),
            if (items.isEmpty)
              Text(
                context.l10n.no_menu_items_yet,
                style: context.typography.p.copyWith(
                  fontSize: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              )
            else
              ...items.map(
                (orderItem) => _buildOrderItemRow(context, orderItem),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemRow(BuildContext context, OrderItem orderItem) {
    final item = orderItem.item;
    final itemPrice = item.price?.toDouble() ?? 0;
    final totalPrice = itemPrice * orderItem.quantity;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 60.r,
              height: 60.r,
              color: context.colorScheme.muted,
              child: item.image != null
                  ? CachedNetworkImage(
                      imageUrl: item.image!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          LucideIcons.utensils,
                          size: 24.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        LucideIcons.utensils,
                        size: 24.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
            ),
          ),
          Gap(12.w),
          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  item.name ?? context.l10n.unknown_item,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${orderItem.quantity}x @ ${context.formatCurrency(itemPrice)}",
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          // Item total
          Text(
            context.formatCurrency(totalPrice),
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard(BuildContext context, Order order) {
    // Calculate subtotal from items
    final items = order.items ?? [];
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + (item.item.price?.toDouble() ?? 0) * item.quantity,
    );

    // Delivery fee = totalPrice - subtotal + discount
    final deliveryFee =
        order.totalPrice - subtotal + (order.discountAmount ?? 0);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.receipt,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  context.l10n.order_detail_summary,
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildSummaryRow(
              context,
              label: context.l10n.label_subtotal,
              value: context.formatCurrency(subtotal),
            ),
            _buildSummaryRow(
              context,
              label: context.l10n.delivery_fee,
              value: context.formatCurrency(deliveryFee),
            ),
            if (order.discountAmount != null && order.discountAmount! > 0)
              _buildSummaryRow(
                context,
                label: order.couponCode != null
                    ? "${context.l10n.label_discount} (${order.couponCode})"
                    : context.l10n.label_discount,
                value: "- ${context.formatCurrency(order.discountAmount!)}",
                valueColor: const Color(0xFF4CAF50),
              ),
            const Divider(),
            _buildSummaryRow(
              context,
              label: context.l10n.total,
              value: context.formatCurrency(order.totalPrice),
              isBold: true,
              valueColor: context.colorScheme.primary,
            ),
            const Divider(),
            // Order info
            _buildInfoRow(
              context,
              icon: LucideIcons.calendar,
              label: context.l10n.order_time,
              value: DateFormat(
                "dd MMM yyyy - HH:mm",
              ).format(order.requestedAt.toLocal()),
            ),
            _buildInfoRow(
              context,
              icon: LucideIcons.hash,
              label: context.l10n.order_id,
              value: order.id.prefix(8),
            ),
            // Payment method indicator
            _buildInfoRow(
              context,
              icon: LucideIcons.wallet,
              label: context.l10n.payment,
              value: context.l10n.e_wallet,
              valueIcon: LucideIcons.circleCheck,
              valueIconColor: const Color(0xFF4CAF50),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context, {
    required String label,
    required String value,
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? null : context.colorScheme.mutedForeground,
            ),
          ),
          Text(
            value,
            style: context.typography.p.copyWith(
              fontSize: isBold ? 18.sp : 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    IconData? valueIcon,
    Color? valueIconColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: context.colorScheme.mutedForeground),
          Gap(8.w),
          Text(
            label,
            style: context.typography.small.copyWith(
              fontSize: 13.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          const Spacer(),
          if (valueIcon != null) ...[
            Icon(valueIcon, size: 14.sp, color: valueIconColor),
            Gap(4.w),
          ],
          Text(
            value,
            style: context.typography.small.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  bool _hasNotes(Order order) {
    final note = order.note;
    if (note == null) return false;
    return (note.pickup != null && note.pickup!.isNotEmpty) ||
        (note.dropoff != null && note.dropoff!.isNotEmpty) ||
        (note.senderName != null && note.senderName!.isNotEmpty) ||
        (note.recevierName != null && note.recevierName!.isNotEmpty);
  }

  Widget _buildNotesCard(BuildContext context, Order order) {
    final note = order.note;
    if (note == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.stickyNote,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  context.l10n.notes,
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            if (note.pickup != null && note.pickup!.isNotEmpty)
              _buildNoteItem(
                context,
                label: context.l10n.pickup_note,
                value: note.pickup!,
                icon: LucideIcons.mapPin,
              ),
            if (note.dropoff != null && note.dropoff!.isNotEmpty)
              _buildNoteItem(
                context,
                label: context.l10n.dropoff_note,
                value: note.dropoff!,
                icon: LucideIcons.navigation,
              ),
            if (note.senderName != null && note.senderName!.isNotEmpty)
              _buildNoteItem(
                context,
                label: context.l10n.sender,
                value: note.senderName!,
                icon: LucideIcons.userCheck,
              ),
            if (note.recevierName != null && note.recevierName!.isNotEmpty)
              _buildNoteItem(
                context,
                label: context.l10n.receiver,
                value: note.recevierName!,
                icon: LucideIcons.user,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteItem(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.w,
        children: [
          Icon(icon, size: 16.sp, color: context.colorScheme.mutedForeground),
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
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    MerchantOrderState state,
    Order order,
  ) {
    final status = order.status;

    // Only show actions for food orders that belong to this merchant
    if (order.type != OrderType.FOOD || order.merchantId == null) {
      return const SizedBox.shrink();
    }

    // Extract action-specific loading states
    final isAccepting = state.acceptOrderResult.isLoading;
    final isRejecting = state.rejectOrderResult.isLoading;
    final isPreparing = state.markPreparingResult.isLoading;
    final isMarkingReady = state.markReadyResult.isLoading;

    Widget? primaryButton;
    Widget? secondaryButton;
    Widget? statusMessage;

    switch (status) {
      case OrderStatus.REQUESTED:
        // Show accept/reject buttons for new incoming orders
        primaryButton = ActionButton.primary(
          isLoading: isAccepting,
          enabled: !isRejecting,
          onPressed: _handleAcceptOrder,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.w,
            children: [
              Icon(LucideIcons.check, size: 18.sp),
              Text(
                context.l10n.accept_order,
                style: context.typography.small.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        );
        secondaryButton = ActionButton.destructive(
          isLoading: isRejecting,
          enabled: !isAccepting,
          onPressed: _handleRejectOrder,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.w,
            children: [
              Icon(LucideIcons.x, size: 18.sp),
              Text(
                context.l10n.reject_order,
                style: context.typography.small.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        );
        break;

      case OrderStatus.MATCHING:
        // Show finding driver message (order is ready, searching for driver)
        statusMessage = _buildStatusMessage(
          context,
          message: context.l10n.finding_driver,
          color: const Color(0xFF2196F3),
          icon: LucideIcons.search,
          isLoading: true,
        );
        break;

      case OrderStatus.ACCEPTED:
        // Show start preparing button
        primaryButton = ActionButton.primary(
          isLoading: isPreparing,
          onPressed: _handleMarkPreparing,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.w,
            children: [
              Icon(LucideIcons.chefHat, size: 18.sp),
              Text(
                context.l10n.start_preparing,
                style: context.typography.small.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        );
        break;

      case OrderStatus.PREPARING:
        // Show order ready button
        primaryButton = ActionButton.primary(
          isLoading: isMarkingReady,
          onPressed: _handleMarkReady,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.w,
            children: [
              Icon(LucideIcons.packageCheck, size: 18.sp),
              Text(
                context.l10n.order_ready,
                style: context.typography.small.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        );
        break;

      case OrderStatus.READY_FOR_PICKUP:
        // Show waiting for driver message
        statusMessage = _buildStatusMessage(
          context,
          message: context.l10n.waiting_for_driver_pickup,
          color: const Color(0xFF4CAF50),
          icon: LucideIcons.timer,
          isLoading: true,
        );
        break;

      case OrderStatus.ARRIVING:
        // Show driver arriving message
        statusMessage = _buildStatusMessage(
          context,
          message: context.l10n.driver_arriving,
          color: const Color(0xFF2196F3),
          icon: LucideIcons.bike,
          isLoading: true,
        );
        break;

      case OrderStatus.IN_TRIP:
        // Show order in delivery message
        statusMessage = _buildStatusMessage(
          context,
          message: context.l10n.order_in_delivery,
          color: const Color(0xFF9C27B0),
          icon: LucideIcons.truck,
          isLoading: true,
        );
        break;

      default:
        return const SizedBox.shrink();
    }

    // Build the action section
    return Column(
      spacing: 12.h,
      children: [
        ?statusMessage,
        if (primaryButton != null && secondaryButton != null)
          Row(
            spacing: 12.w,
            children: [
              Expanded(child: secondaryButton),
              Expanded(child: primaryButton),
            ],
          )
        else if (primaryButton != null)
          SizedBox(width: double.infinity, child: primaryButton),
      ],
    );
  }

  Widget _buildStatusMessage(
    BuildContext context, {
    required String message,
    required Color color,
    required IconData icon,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12.w,
        children: [
          if (isLoading)
            SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(strokeWidth: 2, color: color),
            )
          else
            Icon(icon, size: 20.sp, color: color),
          Text(
            message,
            style: context.typography.p.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFallback(BuildContext context, String name, Color color) {
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(
          name.firstChar.toUpperCase(),
          style: context.typography.h3.copyWith(fontSize: 20.sp, color: color),
        ),
      ),
    );
  }

  /// Check if order status is cancelled
  bool _isCancelledStatus(OrderStatus status) {
    return status == OrderStatus.CANCELLED_BY_USER ||
        status == OrderStatus.CANCELLED_BY_DRIVER ||
        status == OrderStatus.CANCELLED_BY_MERCHANT ||
        status == OrderStatus.CANCELLED_BY_SYSTEM;
  }

  /// Build cancel reason card for cancelled orders
  Widget _buildCancelReasonCard(BuildContext context, Order order) {
    final cancelReason = order.cancelReason;
    if (cancelReason == null || cancelReason.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.dg),
      decoration: BoxDecoration(
        color: const Color(0xFFF44336).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF44336)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Icon(
                LucideIcons.circleX,
                size: 20.sp,
                color: const Color(0xFFF44336),
              ),
              Text(
                context.l10n.cancellation_reason,
                style: context.typography.h4.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFF44336),
                ),
              ),
            ],
          ),
          Text(
            cancelReason,
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              color: context.colorScheme.foreground,
            ),
          ),
        ],
      ),
    );
  }

  /// Build merchant earnings card for completed orders
  Widget _buildMerchantEarningsCard(BuildContext context, Order order) {
    final totalOrderValue = order.totalPrice;
    final platformCommission = order.platformCommission ?? 0;
    // Use server-provided merchantCommission; fallback to calculation only if unavailable
    final merchantEarnings =
        order.merchantCommission ?? (totalOrderValue - platformCommission);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.coins,
                  size: 20.sp,
                  color: context.colorScheme.primary,
                ),
                Text(
                  context.l10n.earnings,
                  style: context.typography.h3.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildEarningsRow(
              context,
              label: context.l10n.label_total_price,
              value: context.formatCurrency(totalOrderValue),
            ),
            _buildEarningsRow(
              context,
              label: context.l10n.label_platform_commission,
              value: "- ${context.formatCurrency(platformCommission)}",
              valueColor: context.colorScheme.destructive,
            ),
            const Divider(),
            _buildEarningsRow(
              context,
              label: context.l10n.net_earnings,
              value: context.formatCurrency(merchantEarnings),
              isBold: true,
              valueColor: const Color(0xFF4CAF50),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsRow(
    BuildContext context, {
    required String label,
    required String value,
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.typography.p.copyWith(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: context.typography.p.copyWith(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
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
                  context.l10n.order_chat,
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

/// Multi-step progress indicator for merchant order screen.
/// Shows the order flow from merchant and driver perspectives.
class _MerchantOrderProgressIndicator extends StatelessWidget {
  const _MerchantOrderProgressIndicator({
    required this.status,
    required this.driverId,
  });

  final OrderStatus? status;
  final String? driverId;

  /// Determines the current step index based on order status for merchant orders.
  int _getMerchantStatusStep(OrderStatus? status) {
    switch (status) {
      case OrderStatus.REQUESTED:
        return 0;
      case OrderStatus.ACCEPTED:
        // For merchant orders, ACCEPTED means merchant accepted (before PREPARING)
        // Unless driverId is set, then it's driver accepted
        if (driverId != null) return 5;
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
    final orderStatus = status;
    return orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.ARRIVING ||
        orderStatus == OrderStatus.IN_TRIP ||
        orderStatus == OrderStatus.COMPLETED ||
        (orderStatus == OrderStatus.ACCEPTED && driverId != null);
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

    int currentStep = _getMerchantStatusStep(status);
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
                  isInDriverPhase ? LucideIcons.truck : LucideIcons.chefHat,
                  size: 16.sp,
                  color: context.colorScheme.primary,
                ),
                Gap(8.w),
                Text(
                  isInDriverPhase
                      ? context.l10n.title_delivery
                      : context.l10n.preparing_order,
                  style: context.typography.p.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                // Phase toggle hint
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    isInDriverPhase
                        ? context.l10n.text_driver
                        : context.l10n.order_confirm_merchant,
                    style: context.typography.small.copyWith(
                      fontSize: 10.sp,
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Gap(16.h),
            // Status steps with connecting lines
            Row(
              children: List.generate(displaySteps.length * 2 - 1, (index) {
                if (index.isOdd) {
                  // Connecting line
                  final stepIndex = index ~/ 2;
                  final nextStepIndex = stepIndex + 1;
                  final isLineActive =
                      currentStep >= displaySteps[nextStepIndex].$2;
                  return Expanded(
                    child: Container(
                      height: 2.h,
                      color: isLineActive
                          ? context.colorScheme.primary
                          : context.colorScheme.muted,
                    ),
                  );
                } else {
                  // Step indicator
                  final stepIdx = index ~/ 2;
                  final entry = displaySteps[stepIdx];
                  final stepLabel = entry.$1;
                  final stepIndex = entry.$2;
                  final isActive = currentStep >= stepIndex;
                  final isCurrent = currentStep == stepIndex;
                  final isSearchingStep =
                      isCurrent &&
                      (status == OrderStatus.MATCHING ||
                          status == OrderStatus.REQUESTED ||
                          status == OrderStatus.PREPARING);

                  return _MerchantStatusStepWidget(
                    label: stepLabel,
                    isActive: isActive,
                    isCurrent: isCurrent,
                    isSearching: isSearchingStep,
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual merchant status step widget
class _MerchantStatusStepWidget extends StatelessWidget {
  const _MerchantStatusStepWidget({
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
      mainAxisSize: MainAxisSize.min,
      spacing: 6.h,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? context.colorScheme.primary
                : context.colorScheme.muted,
            border: isCurrent
                ? Border.all(color: context.colorScheme.primary, width: 2)
                : null,
          ),
          child: _buildStepContent(context),
        ),
        SizedBox(
          width: 50.w,
          child: Text(
            label,
            style: context.typography.small.copyWith(
              fontSize: 9.sp,
              color: isActive
                  ? context.colorScheme.foreground
                  : context.colorScheme.mutedForeground,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
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
        size: 16.sp,
        color: context.colorScheme.primaryForeground,
      );
    }

    return null;
  }
}
