import 'dart:math' as math;

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
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
  final Set<Marker> _markers = {};

  int _radiusKm = 10;
  double _lastZoom = 14;
  LatLng? _lastCenter;
  CameraPosition? _currentCameraPosition;

  BitmapDescriptor _driverIcon = BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  );

  @override
  void initState() {
    super.initState();
    _loadCustomMarkerIcon();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadCustomMarkerIcon() async {
    final BitmapDescriptor bitmap = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(64, 64)),
      Assets.images.motorcycleAbove.path,
    );
    setState(() {
      _driverIcon = bitmap;
    });
  }

  Future<void> _setupLocation() async {
    try {
      final cubit = context.read<UserLocationCubit>();

      var coordinate = cubit.state.coordinate;
      coordinate ??= await cubit.getMyLocation(context);

      if (coordinate == null) {
        debugPrint('⚠️ Coordinate is still null after getMyLocation');
        return;
      }

      final x = coordinate.x.toDouble();
      final y = coordinate.y.toDouble();

      final myPos = LatLng(y, x);
      await _mapController?.animateCamera(CameraUpdate.newLatLng(myPos));

      await _fetchDriversAtLocation(myPos, _radiusKm, true);
      setState(() {});
    } catch (e) {
      debugPrint('⚠️ Location setup failed: $e');
    }
  }

  Future<void> _fetchDriversAtLocation(
    LatLng center,
    int radiusKm,
    bool useCache,
  ) async {
    if (useCache) {
      if (!mounted) return;

      _updateDriverMarkers(context.read<UserRideCubit>().state.nearbyDrivers);
      setState(() {});
      return;
    }

    final user = context.read<AuthCubit>().state.data;
    await context.read<UserRideCubit>().getNearbyDrivers(
      GetDriverNearbyQuery(
        x: center.longitude,
        y: center.latitude,
        radiusKm: radiusKm,
        limit: 10,
        gender: user?.gender,
      ),
    );

    if (!mounted) return;

    _updateDriverMarkers(context.read<UserRideCubit>().state.nearbyDrivers);
    setState(() {});
  }

  void _updateDriverMarkers(List<Driver> drivers) {
    final newMarkers = drivers
        .where((driver) => driver.currentLocation != null)
        .map((driver) {
          final loc = driver.currentLocation!;
          return Marker(
            markerId: MarkerId('driver_${driver.id}'),
            position: LatLng(loc.y.toDouble(), loc.x.toDouble()),
            infoWindow: InfoWindow(
              title: driver.user?.name ?? 'Driver',
              snippet: driver.rating != 0
                  ? 'Rating: ${driver.rating.toStringAsFixed(1)}'
                  : 'No rating yet',
            ),
            icon: _driverIcon,
          );
        })
        .toSet();

    setState(() {
      _markers
        ..clear()
        ..addAll(newMarkers);
    });
  }

  Future<void> _onCameraIdle() async {
    if (_currentCameraPosition == null) return;

    final newZoom = _currentCameraPosition!.zoom;
    final newCenter = _currentCameraPosition!.target;

    final radiusKm = zoomToRadiusKm(
      zoom: newZoom,
      latitude: newCenter.latitude,
      screenWidthPx: MediaQuery.of(context).size.width,
    ).clamp(0.5, 50.0);

    var shouldFetch = false;

    if ((newZoom - _lastZoom).abs() >= 1.0) {
      shouldFetch = true;
    }

    if (_lastCenter != null) {
      final movedKm = _distanceBetweenKm(_lastCenter!, newCenter);
      if (movedKm > radiusKm * 0.3) {
        shouldFetch = true;
      }
    }

    if (shouldFetch) {
      _lastZoom = newZoom;
      _lastCenter = newCenter;
      _radiusKm = radiusKm.round();

      debugPrint(
        '📍 Map changed → Fetching drivers | Zoom: $_lastZoom | Radius: $_radiusKm km | Center: $_lastCenter',
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
    return MyScaffold(
      scrollable: false,
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            'Nearby drivers',
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
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                MapWrapperWidget(
                  onMapCreated: (controller) {
                    _mapController = controller;
                    setState(() {});
                    _setupLocation();
                  },
                  onCameraMove: (position) => _currentCameraPosition = position,
                  onCameraIdle: _onCameraIdle,
                  myLocationEnabled: true,
                  markers: _markers,
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
                  'Your current location',
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary,
                  ),
                ),
                BlocBuilder<UserLocationCubit, UserLocationState>(
                  builder: (context, state) {
                    return Text(
                      state.placemark?.street ?? 'St. Boulevard No.80',
                      style: context.typography.small.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ).asSkeleton(
                      enabled: state.placemark == null || state.isLoading,
                    );
                  },
                ),
                BlocBuilder<UserRideCubit, UserRideState>(
                  builder: (context, state) {
                    return Text(
                      'There are ${_markers.length} drivers around you',
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ).asSkeleton(enabled: state.isLoading);
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
