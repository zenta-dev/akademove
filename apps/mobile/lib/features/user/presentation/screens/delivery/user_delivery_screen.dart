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

class UserDeliveryScreen extends StatefulWidget {
  const UserDeliveryScreen({super.key});

  @override
  State<UserDeliveryScreen> createState() => _UserDeliveryScreenState();
}

class _UserDeliveryScreenState extends State<UserDeliveryScreen> {
  late TextEditingController pickupController;
  late TextEditingController dropoffController;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

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

      var coordinate = cubit.state.coordinate;
      coordinate ??= await cubit.getMyLocation(context);

      logger.d(
        '🏁 UserDeliveryScreen | _setupLocation got coordinate: $coordinate',
      );

      if (coordinate == null) {
        logger.w(
          '[UserDeliveryScreen] Coordinate is still null after getMyLocation',
        );
        return;
      }

      final x = coordinate.x.toDouble();
      final y = coordinate.y.toDouble();

      final position = LatLng(y, x);

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(position, 15),
      );

      setState(() {});

      await _fetchDriversAtLocation(position, 10);
    } catch (e, st) {
      logger.e(
        '[UserDeliveryScreen] Location setup failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _fetchDriversAtLocation(LatLng center, int radiusKm) async {
    final user = context.read<AuthCubit>().state.data;
    await context.read<UserDeliveryCubit>().getNearbyDrivers(
      GetDriverNearbyQuery(
        x: center.longitude,
        y: center.latitude,
        radiusKm: radiusKm,
        limit: 10,
        gender: user?.gender,
      ),
    );

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _updateMapMarkers() async {
    final newMarkers = <Marker>{};
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
    }

    // Add polyline if both locations are selected
    _polylines.clear();
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
          routeCoordinates = await context.read<UserDeliveryCubit>().getRoutes(
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

          _polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: routePoints,
              color: context.colorScheme.primary,
              width: 4,
            ),
          );
        } else {
          // Fallback to straight line if no route available
          _polylines.add(
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
        }
      } catch (e) {
        if (!mounted) return;

        logger.e('Failed to get route: $e');
        // Fallback to straight line on error
        _polylines.add(
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
      }
    }

    setState(() {
      _markers
        ..clear()
        ..addAll(newMarkers);
    });

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
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.title_delivery,
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
      body: BlocListener<UserOrderCubit, UserOrderState>(
        listener: (context, state) {
          if (state.isFailure && state.error != null) {
            context.showMyToast(
              state.error?.message ?? context.l10n.toast_failed_estimate_order,
              type: ToastType.failed,
            );
          }
        },
        child: Column(
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
                          Routes.userDeliveryPickup.name,
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
                          Routes.userDeliveryDropoff.name,
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
            BlocBuilder<UserOrderCubit, UserOrderState>(
              builder: (context, state) {
                final canProceed = pickup != null && dropoff != null;

                return SizedBox(
                  width: double.infinity,
                  child: Button.primary(
                    enabled: !state.isLoading && canProceed,
                    onPressed: canProceed
                        ? () async {
                            final pickupLoc = pickup;
                            final dropoffLoc = dropoff;
                            if (pickupLoc == null || dropoffLoc == null) return;

                            await context.read<UserOrderCubit>().estimate(
                              pickupLoc,
                              dropoffLoc,
                            );

                            if (context.mounted) {
                              final orderState = context
                                  .read<UserOrderCubit>()
                                  .state;
                              if (orderState.isSuccess &&
                                  orderState.estimateOrder != null) {
                                await context.pushNamed(
                                  Routes.userDeliverySummary.name,
                                );
                              }
                            }
                          }
                        : null,
                    child: state.isLoading
                        ? const Submiting()
                        : DefaultText(context.l10n.button_proceed),
                  ),
                );
              },
            ),
          ],
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
              GoogleMap(
                initialCameraPosition: MapConstants.defaultCameraPosition,
                style: context.isDarkMode ? MapConstants.darkStyle : null,
                onMapCreated: (controller) async {
                  _mapController = controller;
                  setState(() {});
                  await _setupLocation();
                },
                markers: _markers,
                polylines: _polylines,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                onTap: (_) => navigateToDriverSearch(),
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

class UserDeliveryPickupScreen extends StatefulWidget {
  const UserDeliveryPickupScreen({super.key});

  @override
  State<UserDeliveryPickupScreen> createState() =>
      _UserDeliveryPickupScreenState();
}

class _UserDeliveryPickupScreenState extends State<UserDeliveryPickupScreen> {
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
    return MyScaffold(
      scrollable: false,
      headers: [DefaultAppBar(title: context.l10n.title_where_you_at)],
      body: PickLocationWidget(
        type: LocationType.pickup,
        pickupController: pickupController,
        dropoffController: dropoffController,
      ),
    );
  }
}

class UserDeliveryDropoffScreen extends StatefulWidget {
  const UserDeliveryDropoffScreen({super.key});

  @override
  State<UserDeliveryDropoffScreen> createState() =>
      _UserDeliveryDropoffScreenState();
}

class _UserDeliveryDropoffScreenState extends State<UserDeliveryDropoffScreen> {
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
    return MyScaffold(
      scrollable: false,
      headers: [DefaultAppBar(title: context.l10n.title_where_are_you_going)],
      body: PickLocationWidget(
        type: LocationType.dropoff,
        pickupController: pickupController,
        dropoffController: dropoffController,
      ),
    );
  }
}
