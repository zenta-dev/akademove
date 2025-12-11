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

class UserRideOnTripScreen extends StatefulWidget {
  const UserRideOnTripScreen({super.key});

  @override
  State<UserRideOnTripScreen> createState() => _UserRideOnTripScreenState();
}

class _UserRideOnTripScreenState extends State<UserRideOnTripScreen> {
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
      logger.e('[UserRideOnTripScreen] - Error loading marker icons: $e');
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
      // Add pickup marker
      ..add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: LatLng(pickupLat, pickupLng),
          icon:
              _pickupIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            title: context.l10n.origin,
            snippet: context.l10n.text_pickup_location,
          ),
        ),
      )
      // Add dropoff marker
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
      // If no driver location, center on pickup
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
    final rideCubit = context.read<UserRideCubit>();

    try {
      // Get actual route from MapService via cubit
      final routeCoordinates = await rideCubit.getRoutes(
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
      logger.e('[UserRideOnTripScreen] - Failed to get route: $e');
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
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusIndicator(context.l10n.status_searching, true),
                _buildStatusIndicator(context.l10n.status_driver_found, false),
                _buildStatusIndicator(context.l10n.status_on_the_way, false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isActive) {
    return Column(
      spacing: 4.h,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? context.colorScheme.primary
                : context.colorScheme.muted,
          ),
          child: isActive
              ? Center(
                  child: SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.colorScheme.primaryForeground,
                    ),
                  ),
                )
              : null,
        ),
        DefaultText(
          label,
          fontSize: 10.sp,
          color: isActive
              ? context.colorScheme.primary
              : context.colorScheme.mutedForeground,
        ),
      ],
    );
  }

  Widget _buildDriverInfo(Driver? driver, OrderStatus? orderStatus) {
    // Show finding driver state when in matching phase
    if (orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.REQUESTED) {
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

  Widget _buildCancelButton(Order? order) {
    if (order == null || !_canCancelOrder(order.status)) {
      return const SizedBox.shrink();
    }

    return SizedBox(
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
    );
  }

  Widget _buildOrderDetails(UserOrderState state) {
    final order = state.currentOrder.value;
    final payment = state.currentPayment.value;
    final estimateOrder = state.estimateOrder.value;

    // Use estimateOrder locations if available (has proper names)
    // Otherwise fall back to order coordinates
    final pickupName =
        estimateOrder?.pickup.vicinity ??
        estimateOrder?.pickup.name ??
        (order != null
            ? '${order.pickupLocation.y.toStringAsFixed(4)}, ${order.pickupLocation.x.toStringAsFixed(4)}'
            : '-');

    final dropoffName =
        estimateOrder?.dropoff.vicinity ??
        estimateOrder?.dropoff.name ??
        (order != null
            ? '${order.dropoffLocation.y.toStringAsFixed(4)}, ${order.dropoffLocation.x.toStringAsFixed(4)}'
            : '-');

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
              _buildCell(context.l10n.origin, pickupName, allowMultiline: true),
              const Divider(),
              _buildCell(
                context.l10n.destination,
                dropoffName,
                allowMultiline: true,
              ),
              const Divider(),
              _buildCell(
                context.l10n.label_distance,
                order != null ? '${order.distanceKm} Km' : '-',
              ),
              const Divider(),
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
    final isSearching =
        orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.REQUESTED;

    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          isSearching
              ? context.l10n.text_finding_driver_title
              : context.l10n.text_your_driver_title,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        _buildDriverInfo(state.currentAssignedDriver.value, orderStatus),
        _buildOrderDetails(state),
        _buildCancelButton(order),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: false,
      padding: EdgeInsets.zero,
      headers: [DefaultAppBar(title: context.l10n.text_on_trip)],
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
                  currentOrder?.status == OrderStatus.CANCELLED_BY_SYSTEM) &&
              mounted &&
              context.mounted) {
            context.showMyToast(
              context.l10n.text_trip_canceled,
              type: ToastType.failed,
            );
          }
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300.h,
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
