import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserRideScreen extends StatefulWidget {
  const UserRideScreen({super.key});

  @override
  State<UserRideScreen> createState() => _UserRideScreenState();
}

class _UserRideScreenState extends State<UserRideScreen> {
  late TextEditingController pickupController;
  late TextEditingController dropoffController;
  GoogleMapController? _mapController;

  Place? pickup;
  Place? dropoff;

  // Cache route to avoid redundant API calls
  List<Coordinate>? _cachedRoute;
  String? _cachedRouteKey;

  @override
  void initState() {
    super.initState();
    pickupController = TextEditingController();
    dropoffController = TextEditingController();
    // Clear map state when entering ride flow
    context.read<UserLocationCubit>().clearMapState();
    // Check for active order and redirect if exists
    _checkActiveOrderAndRedirect();
  }

  /// Check if user has an active order and redirect to on-trip screen
  Future<void> _checkActiveOrderAndRedirect() async {
    final orderCubit = context.read<UserOrderCubit>();
    final currentOrder = orderCubit.state.currentOrder.value;

    // If there's already an active order in state, check if we should redirect
    if (currentOrder != null) {
      final status = currentOrder.status;
      final activeStatuses = [
        OrderStatus.REQUESTED,
        OrderStatus.MATCHING,
        OrderStatus.ACCEPTED,
        OrderStatus.PREPARING,
        OrderStatus.READY_FOR_PICKUP,
        OrderStatus.ARRIVING,
        OrderStatus.IN_TRIP,
      ];

      if (activeStatuses.contains(status) &&
          currentOrder.type == OrderType.RIDE) {
        // Redirect to on-trip screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.pushReplacementNamed(Routes.userRideOnTrip.name);
          }
        });
        return;
      }
    }

    // Check from server for active order
    // final hasActiveOrder = await orderCubit.recoverActiveOrder();
    // if (hasActiveOrder && mounted) {
    //   final activeOrder = orderCubit.state.currentOrder.value;
    //   if (activeOrder != null && activeOrder.type == OrderType.RIDE) {
    //     context.pushReplacementNamed(Routes.userRideOnTrip.name);
    //   }
    // }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    pickupController.dispose();
    dropoffController.dispose();
    super.dispose();
  }

  Future<void> _setupLocation() async {
    try {
      final cubit = context.read<UserLocationCubit>();

      // Use ensureLocationLoaded which leverages cache automatically
      final coordinate = await cubit.ensureLocationLoaded();

      logger.d(
        '🏁 UserRideScreen | _setupLocation got coordinate: $coordinate',
      );

      if (coordinate == null) {
        logger.w(
          '[UserRideScreen] Coordinate is still null after ensureLocationLoaded',
        );
        return;
      }

      final x = coordinate.x.toDouble();
      final y = coordinate.y.toDouble();

      final position = LatLng(y, x);

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(position, 15),
      );

      await _fetchDriversAtLocation(position, 10);
    } catch (e, st) {
      logger.e(
        '[UserRideScreen] Location setup failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _fetchDriversAtLocation(LatLng center, int radiusKm) async {
    final user = context.read<AuthCubit>().state.user.data?.value;
    await context.read<UserRideCubit>().getNearbyDrivers(
      GetDriverNearbyQuery(
        x: center.longitude,
        y: center.latitude,
        radiusKm: radiusKm,
        limit: 10,
        gender: user?.gender,
      ),
    );
  }

  Future<void> _updateMapMarkers() async {
    final locationCubit = context.read<UserLocationCubit>();
    final newMarkers = <Marker>{};
    final newPolylines = <Polyline>{};
    final bounds = <LatLng>[];

    // Add pickup marker
    final pickupLocation = pickup;
    if (pickupLocation != null) {
      final pickupLatLng = LatLng(pickupLocation.lat, pickupLocation.lng);
      bounds.add(pickupLatLng);

      newMarkers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: pickupLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: context.l10n.marker_pickup,
            snippet: pickupLocation.vicinity,
          ),
        ),
      );
      setState(() {});
    }

    // Add dropoff marker
    final dropoffLocation = dropoff;
    if (dropoffLocation != null) {
      final dropoffLatLng = LatLng(dropoffLocation.lat, dropoffLocation.lng);
      bounds.add(dropoffLatLng);

      newMarkers.add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: dropoffLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: context.l10n.marker_dropoff,
            snippet: dropoffLocation.vicinity,
          ),
        ),
      );
      setState(() {});
    }

    // Add polyline if both locations are selected
    final pickupLoc = pickup;
    final dropoffLoc = dropoff;
    if (pickupLoc != null && dropoffLoc != null) {
      try {
        // Create cache key from pickup and dropoff coordinates
        final routeKey =
            '${pickupLoc.lat},${pickupLoc.lng}-${dropoffLoc.lat},${dropoffLoc.lng}';

        // Use cached route if available
        List<Coordinate> routeCoordinates;
        final cachedRoute = _cachedRoute;
        if (_cachedRouteKey == routeKey && cachedRoute != null) {
          routeCoordinates = cachedRoute;
        } else {
          // Get actual route from MapService via cubit
          routeCoordinates = await context.read<UserRideCubit>().getRoutes(
            pickupLoc.toCoordinate(),
            dropoffLoc.toCoordinate(),
          );
          // Cache the route
          _cachedRoute = routeCoordinates;
          _cachedRouteKey = routeKey;
        }

        if (!mounted) return;

        if (routeCoordinates.isNotEmpty) {
          final routePoints = routeCoordinates
              .map((coord) => LatLng(coord.y.toDouble(), coord.x.toDouble()))
              .toList();

          newPolylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: routePoints,
              color: context.colorScheme.primary,
              width: 4,
            ),
          );
          setState(() {});
        } else {
          // Fallback to straight line if no route available
          newPolylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: [
                LatLng(pickupLoc.lat, pickupLoc.lng),
                LatLng(dropoffLoc.lat, dropoffLoc.lng),
              ],
              color: context.colorScheme.primary,
              width: 4,
            ),
          );
          setState(() {});
        }
      } catch (e) {
        if (!mounted) return;

        logger.e('Failed to get route: $e');
        // Fallback to straight line on error
        newPolylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: [
              LatLng(pickupLoc.lat, pickupLoc.lng),
              LatLng(dropoffLoc.lat, dropoffLoc.lng),
            ],
            color: context.colorScheme.primary,
            width: 4,
          ),
        );
        setState(() {});
      }
    }

    // Update cubit state with new markers and polylines
    locationCubit.setMapData(markers: newMarkers, polylines: newPolylines);

    // Adjust camera to show both markers
    if (bounds.length > 1 && _mapController != null) {
      final boundsToFit = LatLngBounds(
        southwest: LatLng(
          bounds.map((e) => e.latitude).reduce((a, b) => a < b ? a : b),
          bounds.map((e) => e.longitude).reduce((a, b) => a < b ? a : b),
        ),
        northeast: LatLng(
          bounds.map((e) => e.latitude).reduce((a, b) => a > b ? a : b),
          bounds.map((e) => e.longitude).reduce((a, b) => a > b ? a : b),
        ),
      );

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(boundsToFit, 100),
      );
    } else if (bounds.length == 1 && _mapController != null) {
      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(bounds.first, 15),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.title_ride,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: BlocConsumer<UserOrderCubit, UserOrderState>(
            listener: (context, state) {
              if (state.estimateOrder.isFailure &&
                  state.estimateOrder.error != null) {
                context.showMyToast(
                  state.estimateOrder.error?.message ??
                      context.l10n.toast_failed_estimate_order,
                  type: ToastType.failed,
                );
              }

              if (state.estimateOrder.isSuccess &&
                  state.estimateOrder.hasData) {
                context.popUntilRoot();
                context.pushNamed(Routes.userRideSummary.name);
              }
            },
            builder: (context, state) {
              return Column(
                spacing: 16.h,
                children: [
                  Text(
                    context.l10n.text_choose_pickup_destination,
                    style: context.typography.h4.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    child: Column(
                      spacing: 16.h,
                      children: [
                        _buildMapSection(),
                        PickLocationCardWidget(
                          padding: EdgeInsets.zero,
                          borderColor: context.colorScheme.card,
                          pickup: PickLocationParameters(
                            enabled: false,
                            controller: pickupController,
                            onPresesed: () async {
                              pickup = await context.pushNamed(
                                Routes.userRidePickup.name,
                                extra: {
                                  LocationType.pickup.name: pickupController,
                                  LocationType.dropoff.name: dropoffController,
                                },
                              );
                              pickupController.text = pickup?.vicinity ?? '';
                              await _updateMapMarkers();
                            },
                          ),
                          dropoff: PickLocationParameters(
                            enabled: false,
                            controller: dropoffController,
                            onPresesed: () async {
                              dropoff = await context.pushNamed(
                                Routes.userRideDropoff.name,
                                extra: {
                                  LocationType.pickup.name: pickupController,
                                  LocationType.dropoff.name: dropoffController,
                                },
                              );
                              dropoffController.text = dropoff?.vicinity ?? '';
                              await _updateMapMarkers();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Button.primary(
                      enabled: !state.estimateOrder.isLoading,
                      onPressed: state.estimateOrder.isLoading
                          ? null
                          : () {
                              final pickupLoc = pickup;
                              final dropoffLoc = dropoff;

                              if (pickupLoc == null || dropoffLoc == null) {
                                context.showMyToast(
                                  "Pickup and dropoff locations are required",
                                );
                                return;
                              }
                              context.read<UserOrderCubit>().estimate(
                                req: EstimateOrder(
                                  type: OrderType.RIDE,
                                  pickupLocation: Coordinate(
                                    x: pickupLoc.lng,
                                    y: pickupLoc.lat,
                                  ),
                                  dropoffLocation: Coordinate(
                                    x: dropoffLoc.lng,
                                    y: dropoffLoc.lat,
                                  ),
                                ),
                                pickup: pickupLoc,
                                dropoff: dropoffLoc,
                              );
                            },
                      child: state.estimateOrder.isLoading
                          ? const Submiting()
                          : DefaultText(context.l10n.button_proceed),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    void navigateToDriverSearch() =>
        context.pushNamed(Routes.userDriverNearMe.name);

    return Button(
      onPressed: _mapController != null ? navigateToDriverSearch : null,
      style: const ButtonStyle.ghost(density: ButtonDensity.compact),
      child: SizedBox(
        height: 200.h,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.dg),
          child: Stack(
            children: [
              BlocBuilder<UserLocationCubit, UserLocationState>(
                buildWhen: (prev, curr) =>
                    prev.markers != curr.markers ||
                    prev.polylines != curr.polylines,
                builder: (context, locationState) {
                  return GoogleMap(
                    initialCameraPosition: MapConstants.defaultCameraPosition,
                    style: context.isDarkMode ? MapConstants.darkStyle : null,
                    onMapCreated: (controller) async {
                      _mapController = controller;
                      setState(() {});
                      await _setupLocation();
                    },
                    markers: locationState.markers,
                    polylines: locationState.polylines,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    onTap: (_) => navigateToDriverSearch(),
                  );
                },
              ),
              if (_mapController == null)
                Positioned.fill(
                  child: Container(
                    color: context.colorScheme.mutedForeground,
                  ).asSkeleton(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserRidePickupScreen extends StatefulWidget {
  const UserRidePickupScreen({super.key});

  @override
  State<UserRidePickupScreen> createState() => _UserRidePickupScreenState();
}

class _UserRidePickupScreenState extends State<UserRidePickupScreen> {
  TextEditingController? pickupController;
  TextEditingController? dropoffController;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
      pickupController =
          extra?[LocationType.pickup.name] as TextEditingController?;
      dropoffController =
          extra?[LocationType.dropoff.name] as TextEditingController?;

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.title_where_you_at)],
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: PickLocationWidget(
          type: LocationType.pickup,
          pickupController: pickupController,
          dropoffController: dropoffController,
        ),
      ),
    );
  }
}

class UserRideDropoffScreen extends StatefulWidget {
  const UserRideDropoffScreen({super.key});

  @override
  State<UserRideDropoffScreen> createState() => _UserRideDropoffScreenState();
}

class _UserRideDropoffScreenState extends State<UserRideDropoffScreen> {
  TextEditingController? pickupController;
  TextEditingController? dropoffController;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
      pickupController =
          extra?[LocationType.pickup.name] as TextEditingController?;
      dropoffController =
          extra?[LocationType.dropoff.name] as TextEditingController?;

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.title_where_going)],
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: PickLocationWidget(
          type: LocationType.dropoff,
          pickupController: pickupController,
          dropoffController: dropoffController,
        ),
      ),
    );
  }
}
