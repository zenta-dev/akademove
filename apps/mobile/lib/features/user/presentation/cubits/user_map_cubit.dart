import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Cubit for managing map-related state like routes and distance calculations.
///
/// This cubit caches route and distance data to prevent redundant API calls.
/// The cache is keyed by origin-destination pairs.
class UserMapCubit extends BaseCubit<UserMapState> {
  UserMapCubit({required this.mapService}) : super(const UserMapState());

  final MapService mapService;

  /// Cache for route data (keyed by origin-destination hash)
  final Map<String, List<Coordinate>> _routeCache = {};

  /// Cache for distance/duration data (keyed by origin-destination hash)
  final Map<String, DistanceWithDuration> _distanceCache = {};

  /// Cache duration (10 minutes)
  static const _cacheDuration = Duration(minutes: 10);

  /// Timestamps for cache entries
  final Map<String, DateTime> _cacheTimestamps = {};

  /// Generate cache key from origin and destination
  String _getCacheKey(Coordinate origin, Coordinate destination) {
    return '${origin.x},${origin.y}-${destination.x},${destination.y}';
  }

  /// Check if cache entry is still valid
  bool _isCacheValid(String key) {
    final timestamp = _cacheTimestamps[key];
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) < _cacheDuration;
  }

  /// Get routes between two points with caching support.
  Future<void> getRoutes({
    required Coordinate origin,
    required Coordinate destination,
    bool forceRefresh = false,
  }) async => await taskManager.executeWithCache(
    'UMC-gR-${origin.hashCode}-${destination.hashCode}',
    () async {
      final cacheKey = _getCacheKey(origin, destination);

      // Return cached data if valid and not forcing refresh
      if (!forceRefresh && _isCacheValid(cacheKey)) {
        final cachedRoute = _routeCache[cacheKey];
        if (cachedRoute != null) {
          logger.d('[UserMapCubit] Using cached route data');
          _emitRouteSuccess(cachedRoute, origin, destination);
          return;
        }
      }

      try {
        emit(state.copyWith(routeCoordinates: const OperationResult.loading()));

        final res = await mapService.getRoutes(origin, destination);

        // Cache the result
        _routeCache[cacheKey] = res;
        _cacheTimestamps[cacheKey] = DateTime.now();

        _emitRouteSuccess(res, origin, destination);
      } catch (e, st) {
        logger.e('[UserMapCubit] getRoutes failed', error: e, stackTrace: st);
        final error = e is BaseError
            ? e
            : UnknownError(e.toString(), code: ErrorCode.unknown);
        emit(state.copyWith(routeCoordinates: OperationResult.failed(error)));
      }
    },
  );

  /// Emit success state with route data
  void _emitRouteSuccess(
    List<Coordinate> routeCoordinates,
    Coordinate origin,
    Coordinate destination,
  ) {
    final polylines = <Polyline>{};
    polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blue,
        width: 5,
        points: routeCoordinates
            .map((e) => LatLng(e.y.toDouble(), e.x.toDouble()))
            .toList(),
      ),
    );

    final markers = <Marker>{};
    markers.addAll([
      Marker(
        markerId: const MarkerId('origin'),
        position: LatLng(origin.y.toDouble(), origin.x.toDouble()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(destination.y.toDouble(), destination.x.toDouble()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    ]);

    emit(
      state.copyWith(
        routeCoordinates: OperationResult.success(routeCoordinates),
        polylines: polylines,
        markers: markers,
      ),
    );
  }

  /// Get distance and duration between two points with caching support.
  Future<void> getDistanceAndDuration({
    required Coordinate origin,
    required Coordinate destination,
    bool forceRefresh = false,
  }) async => await taskManager.executeWithCache(
    'UMC-gRI-${origin.hashCode}-${destination.hashCode}',
    () async {
      final cacheKey = _getCacheKey(origin, destination);

      // Return cached data if valid and not forcing refresh
      if (!forceRefresh && _isCacheValid(cacheKey)) {
        final cachedDistance = _distanceCache[cacheKey];
        if (cachedDistance != null) {
          logger.d('[UserMapCubit] Using cached distance data');
          emit(
            state.copyWith(routeInfo: OperationResult.success(cachedDistance)),
          );
          return;
        }
      }

      try {
        emit(state.copyWith(routeInfo: const OperationResult.loading()));

        final res = await mapService.getRouteDistance(origin, destination);

        // Cache the result if not null
        if (res != null) {
          _distanceCache[cacheKey] = res;
          _cacheTimestamps[cacheKey] = DateTime.now();
        }

        emit(state.copyWith(routeInfo: OperationResult.success(res)));
      } catch (e, st) {
        logger.e(
          '[UserMapCubit] getDistanceAndDuration failed',
          error: e,
          stackTrace: st,
        );
        final error = e is BaseError
            ? e
            : UnknownError(e.toString(), code: ErrorCode.unknown);
        emit(state.copyWith(routeInfo: OperationResult.failed(error)));
      }
    },
  );

  /// Fetch both route and distance/duration in parallel with caching
  Future<void> getRouteWithInfo({
    required Coordinate origin,
    required Coordinate destination,
    bool forceRefresh = false,
  }) async {
    await Future.wait([
      getRoutes(
        origin: origin,
        destination: destination,
        forceRefresh: forceRefresh,
      ),
      getDistanceAndDuration(
        origin: origin,
        destination: destination,
        forceRefresh: forceRefresh,
      ),
    ]);
  }

  /// Clear all cached data
  void clearCache() {
    _routeCache.clear();
    _distanceCache.clear();
    _cacheTimestamps.clear();
  }

  /// Clear route-related state (markers, polylines) but keep cache
  void clearRouteState() {
    emit(
      state.copyWith(
        routeCoordinates: const OperationResult.idle(),
        routeInfo: const OperationResult.idle(),
        markers: const {},
        polylines: const {},
      ),
    );
  }
}
