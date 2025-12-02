import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
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
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _pickupIcon;
  BitmapDescriptor? _dropoffIcon;

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
    final driver = state.currentAssignedDriver;
    final order = state.currentOrder;

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
            snippet: 'Pickup location',
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
            snippet: 'Dropoff location',
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
      if (_markers.isEmpty) {
        await _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(driverLat, driverLng)),
        );
      }
    } else {
      // If no driver location, center on pickup
      if (_markers.isEmpty) {
        await _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(pickupLat, pickupLng)),
        );
      }
    }

    // Add polyline between pickup and dropoff with actual route
    _polylines.clear();

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

        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: routePoints,
            color: color,
            width: 4,
          ),
        );
      } else {
        // Fallback to straight line if no route available
        _polylines.add(
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
      _polylines.add(
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

    setState(() {
      _markers
        ..clear()
        ..addAll(newMarkers);
    });
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
                        'Finding your driver...',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                      DefaultText(
                        'Please wait while we match you with a driver',
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
                _buildStatusIndicator('Searching', true),
                _buildStatusIndicator('Driver found', false),
                _buildStatusIndicator('On the way', false),
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
              Avatar(size: 48.w, initials: '?').asSkeleton(),
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
                    ).asSkeleton(),
                    DefaultText('License plate', fontSize: 12.sp).asSkeleton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
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

  Widget _buildOrderDetails(UserOrderState state) {
    final order = state.currentOrder;
    final payment = state.currentPayment;
    final estimateOrder = state.estimateOrder;

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
        case PaymentMethod.WALLET:
          return 'Wallet';
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
          'Order details',
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        Card(
          child: Column(
            spacing: 4.h,
            crossAxisAlignment: .start,
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
                'Distance',
                order != null ? '${order.distanceKm} Km' : '-',
              ),
              const Divider(),
              _buildCell('Payment Method', getPaymentMethodDisplay()),
              const Divider(),
              _buildCell(
                'Total Price',
                order != null ? context.formatCurrency(order.totalPrice) : '-',
              ),
              const Divider(),
              _buildCell('Status', order?.status.name ?? '-'),
            ],
          ),
        ).asSkeleton(enabled: order == null),
      ],
    );
  }

  Widget _buildBody(BuildContext context, UserOrderState state) {
    final orderStatus = state.currentOrder?.status;
    final isSearching =
        orderStatus == OrderStatus.MATCHING ||
        orderStatus == OrderStatus.REQUESTED;

    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          isSearching ? 'Finding driver' : 'Your driver',
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        _buildDriverInfo(state.currentAssignedDriver, orderStatus),
        _buildOrderDetails(state),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EmergencyCubit>(),
      child: MyScaffold(
        scrollable: false,
        padding: EdgeInsets.zero,
        headers: const [DefaultAppBar(title: 'On Trip')],
        body: BlocListener<UserOrderCubit, UserOrderState>(
          listener: (context, state) async {
            await _updateMapWithOrderData(state);

            if (state.currentOrder?.status == OrderStatus.COMPLETED &&
                mounted &&
                context.mounted) {
              // Navigate to rating/review screen
              final driver = state.currentAssignedDriver;
              if (driver != null) {
                final result = await context.pushNamed(
                  Routes.userRating.name,
                  extra: {
                    'orderId': state.currentOrder!.id,
                    'driverId': driver.userId,
                    'driverName': driver.user?.name ?? 'Driver',
                  },
                );

                // If rating was submitted successfully, show success message
                if (result == true && mounted && context.mounted) {
                  context.showMyToast(
                    'Trip completed!',
                    type: ToastType.success,
                  );
                  // Go back to home
                  context.goNamed(Routes.userHome.name);
                }
              } else {
                context.showMyToast('Trip completed!', type: ToastType.success);
                context.goNamed(Routes.userHome.name);
              }
            } else if ((state.currentOrder?.status ==
                        OrderStatus.CANCELLED_BY_USER ||
                    state.currentOrder?.status ==
                        OrderStatus.CANCELLED_BY_DRIVER ||
                    state.currentOrder?.status ==
                        OrderStatus.CANCELLED_BY_SYSTEM) &&
                mounted &&
                context.mounted) {
              context.showMyToast('Trip was canceled', type: ToastType.failed);
            }
          },
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 300.h,
                child: Stack(
                  children: [
                    MapWrapperWidget(
                      onMapCreated: (controller) {
                        _mapController = controller;
                        // Initial map update
                        final state = context.read<UserOrderCubit>().state;
                        _updateMapWithOrderData(state);
                      },
                      markers: _markers,
                      polylines: _polylines,
                      myLocationEnabled: true,
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
                        final order = state.currentOrder;
                        if (order == null ||
                            order.status != OrderStatus.IN_TRIP) {
                          return const SizedBox.shrink();
                        }

                        // Get current location from driver or order
                        final driverLocation =
                            state.currentAssignedDriver?.currentLocation;
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
      ),
    );
  }
}
