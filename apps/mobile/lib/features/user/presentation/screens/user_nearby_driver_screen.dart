import 'dart:math' as math;

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserNearbyDriverScreen extends StatefulWidget {
  const UserNearbyDriverScreen({super.key});

  @override
  State<UserNearbyDriverScreen> createState() => _UserNearbyDriverScreenState();
}

class _UserNearbyDriverScreenState extends State<UserNearbyDriverScreen> {
  bool isMapReady = false;
  GoogleMapController? _mapController;

  int _radiusKm = 10;
  double _lastZoom = 14;
  LatLng? _lastCenter;
  CameraPosition? _currentCameraPosition;

  /// Manager for efficient driver marker updates
  late final DriverMarkersManager _driverMarkersManager;

  @override
  void initState() {
    super.initState();
    _driverMarkersManager = DriverMarkersManager(
      onMarkersUpdated: _onDriverMarkersUpdated,
    );
    _loadMarkerIcon();
  }

  @override
  void dispose() {
    _driverMarkersManager.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadMarkerIcon() async {
    await _driverMarkersManager.loadDriverIcon();
  }

  /// Callback when driver markers are updated by the manager
  void _onDriverMarkersUpdated(Set<Marker> markers) {
    if (!mounted) return;
    final locationCubit = context.read<UserLocationCubit>();
    // Use efficient update method that only emits if markers actually changed
    locationCubit.updateDriverMarkersEfficiently(markers);
  }

  Future<void> _setupLocation() async {
    try {
      final cubit = context.read<UserLocationCubit>();

      // Use ensureLocationLoaded which leverages cache automatically
      final coordinate = await cubit.ensureLocationLoaded();

      if (coordinate == null) {
        logger.w(
          '[UserNearbyDriverScreen] Coordinate is still null after ensureLocationLoaded',
        );
        return;
      }

      final x = coordinate.x.toDouble();
      final y = coordinate.y.toDouble();

      final myPos = LatLng(y, x);
      await _mapController?.animateCamera(CameraUpdate.newLatLng(myPos));

      await _fetchDriversAtLocation(myPos, _radiusKm, true);
    } catch (e, st) {
      logger.e(
        '[UserNearbyDriverScreen] Location setup failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _fetchDriversAtLocation(
    LatLng center,
    int radiusKm,
    bool useCache,
  ) async {
    final locationCubit = context.read<UserLocationCubit>();

    if (useCache) {
      if (!mounted) return;

      _updateDriverMarkers(
        locationCubit,
        context.read<UserRideCubit>().state.nearbyDrivers.value ?? [],
      );
      return;
    }

    // final user = context.read<AuthCubit>().state.user.data?.value;
    await context.read<UserRideCubit>().getNearbyDrivers(
      GetDriverNearbyQuery(
        x: center.longitude,
        y: center.latitude,
        radiusKm: radiusKm,
        limit: 10,
        // gender: user?.gender,
        gender: null,
      ),
    );

    if (!mounted) return;

    _updateDriverMarkers(
      locationCubit,
      context.read<UserRideCubit>().state.nearbyDrivers.value ?? [],
    );
  }

  void _updateDriverMarkers(
    UserLocationCubit locationCubit,
    List<Driver> drivers,
  ) {
    // Use the efficient driver markers manager
    _driverMarkersManager.updateDrivers(drivers);
  }

  Future<void> _onCameraIdle() async {
    final cameraPosition = _currentCameraPosition;
    if (cameraPosition == null) return;

    final newZoom = cameraPosition.zoom;
    final newCenter = cameraPosition.target;

    final radiusKm = zoomToRadiusKm(
      zoom: newZoom,
      latitude: newCenter.latitude,
      screenWidthPx: MediaQuery.of(context).size.width,
    ).clamp(0.5, 50.0);

    var shouldFetch = false;

    if ((newZoom - _lastZoom).abs() >= 1.0) {
      shouldFetch = true;
    }

    final lastCenter = _lastCenter;
    if (lastCenter != null) {
      final movedKm = _distanceBetweenKm(lastCenter, newCenter);
      if (movedKm > radiusKm * 0.3) {
        shouldFetch = true;
      }
    }

    if (shouldFetch) {
      _lastZoom = newZoom;
      _lastCenter = newCenter;
      _radiusKm = radiusKm.round();

      logger.d(
        '[UserNearbyDriverScreen] Map changed → Fetching drivers | Zoom: $_lastZoom | Radius: $_radiusKm km | Center: $_lastCenter',
      );

      await _fetchDriversAtLocation(newCenter, _radiusKm, false);
    }
  }

  double zoomToRadiusKm({
    required double zoom,
    required double latitude,
    double screenWidthPx = 400,
  }) {
    const metersPerPixelAtZoom0 = 156543.03392;
    final metersPerPixel =
        metersPerPixelAtZoom0 *
        math.cos(latitude * math.pi / 180) /
        math.pow(2, zoom);
    final radiusMeters = metersPerPixel * (screenWidthPx / 2);
    return radiusMeters / 1000;
  }

  double _distanceBetweenKm(LatLng a, LatLng b) {
    const double R = 6371;
    final dLat = (b.latitude - a.latitude) * math.pi / 180;
    final dLon = (b.longitude - a.longitude) * math.pi / 180;
    final lat1 = a.latitude * math.pi / 180;
    final lat2 = b.latitude * math.pi / 180;

    final h =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.sin(dLon / 2) *
            math.sin(dLon / 2) *
            math.cos(lat1) *
            math.cos(lat2);

    return 2 * R * math.atan2(math.sqrt(h), math.sqrt(1 - h));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.label_nearby_drivers,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                BlocBuilder<UserLocationCubit, UserLocationState>(
                  buildWhen: (previous, current) =>
                      previous.markers != current.markers,
                  builder: (context, locationState) {
                    return MapWrapperWidget(
                      onMapCreated: (controller) {
                        _mapController = controller;
                        setState(() {});
                        _setupLocation();
                      },
                      onCameraMove: (position) =>
                          _currentCameraPosition = position,
                      onCameraIdle: _onCameraIdle,
                      myLocationEnabled: true,
                      markers: locationState.markers,
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
          Padding(
            padding: EdgeInsetsGeometry.all(16.dg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(
                  context.l10n.text_your_current_location,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary,
                  ),
                ),
                BlocBuilder<UserLocationCubit, UserLocationState>(
                  builder: (context, state) {
                    return Text(
                      state.location.value?.$2?.street ?? 'St. Boulevard No.80',
                      style: context.typography.small.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ).asSkeleton(
                      enabled:
                          state.location.value?.$2 == null ||
                          state.location.isLoading,
                    );
                  },
                ),
                BlocBuilder<UserLocationCubit, UserLocationState>(
                  buildWhen: (previous, current) =>
                      previous.markers != current.markers,
                  builder: (context, locationState) {
                    return BlocBuilder<UserRideCubit, UserRideState>(
                      builder: (context, state) {
                        return Text(
                          context.l10n.text_drivers_around_you(
                            locationState.markers.length,
                          ),
                          style: context.typography.small.copyWith(
                            fontSize: 12.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        ).asSkeleton(enabled: state.nearbyDrivers.isLoading);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
