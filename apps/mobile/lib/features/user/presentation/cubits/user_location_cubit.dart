import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Cubit for managing user location state with built-in caching.
///
/// This cubit automatically initializes location when created and caches
/// the result. Screens should NOT call getMyLocation in initState.
/// Instead, they should:
/// 1. Use BlocBuilder to react to location state changes
/// 2. Call `ensureLocationLoaded()` if they need to trigger a fetch
/// 3. Access `state.coordinate` which will be populated automatically
///
/// This cubit also manages map markers and polylines for order flows.
/// Call `clearMapState()` when entering a new order flow (ride/delivery/mart).
class UserLocationCubit extends BaseCubit<UserLocationState> {
  UserLocationCubit({required LocationService locationService})
    : _locationService = locationService,
      super(const UserLocationState()) {
    // Auto-initialize location when cubit is created
    _initLocation();
  }

  final LocationService _locationService;

  /// Cache duration for location data (5 minutes)
  static const _cacheDuration = Duration(minutes: 5);

  DateTime? _lastFetchTime;

  /// Initialize location automatically when cubit is created.
  /// Uses cache-first approach for better UX.
  Future<void> _initLocation() async {
    await getMyLocation(fromCache: true);
  }

  /// Check if cached location is still valid
  bool get _isCacheValid {
    final lastFetch = _lastFetchTime;
    if (lastFetch == null) return false;
    return DateTime.now().difference(lastFetch) < _cacheDuration;
  }

  /// Returns true if location data is available (either loading or has data)
  bool get hasLocation => state.coordinate != null;

  /// Ensures location is loaded. If already cached and valid, returns immediately.
  /// This is the preferred method for screens to call instead of getMyLocation.
  Future<Coordinate?> ensureLocationLoaded({
    LocationAccuracy accuracy = LocationAccuracy.best,
    bool forceRefresh = false,
  }) async {
    // Return cached coordinate if valid and not forcing refresh
    if (!forceRefresh && _isCacheValid && state.coordinate != null) {
      logger.d('[UserLocationCubit] Using cached location');
      return state.coordinate;
    }

    // Fetch fresh location
    return getMyLocation(accuracy: accuracy, fromCache: !forceRefresh);
  }

  /// Get user's current location with caching support.
  /// Prefer using `ensureLocationLoaded()` for most use cases.
  Future<Coordinate?> getMyLocation({
    LocationAccuracy accuracy = LocationAccuracy.best,
    bool fromCache = true,
    bool forceLocationManager = false,
  }) async => taskManager.executeWithCache('ULC-gML-$accuracy', () async {
    try {
      // If we have a valid cache and fromCache is true, return it
      if (fromCache && _isCacheValid && state.coordinate != null) {
        logger.d('[UserLocationCubit] Returning cached location');
        return state.coordinate;
      }

      await _locationService.ensureInitialized();

      // Only emit loading if we don't have any location yet
      if (state.coordinate == null) {
        emit(state.copyWith(location: const OperationResult.loading()));
      }

      final loc = await _locationService.getMyLocation(
        accuracy: accuracy,
        fromCache: fromCache,
        forceLocationManager: forceLocationManager,
      );

      if (loc == null) {
        // Keep existing location if available, otherwise set idle
        if (state.coordinate == null) {
          emit(state.copyWith(location: const OperationResult.idle()));
        }
        return state.coordinate;
      }

      // Update cache timestamp
      _lastFetchTime = DateTime.now();

      // First emit with coordinate only
      emit(state.copyWith(location: OperationResult.success((loc, null))));

      // Fetch placemark in background (non-blocking)
      _fetchPlacemark(loc);

      return loc;
    } catch (e, st) {
      logger.e(
        '[UserLocationCubit] getMyLocation failed',
        error: e,
        stackTrace: st,
      );
      // Wrap generic error in BaseError if possible, or create a generic one
      final error = e is BaseError
          ? e
          : UnknownError(e.toString(), code: ErrorCode.unknown);

      // Only emit error if we don't have cached location
      if (state.coordinate == null) {
        emit(state.copyWith(location: OperationResult.failed(error)));
      }
      return state.coordinate;
    }
  });

  /// Fetch placemark for a coordinate (non-blocking background operation)
  Future<void> _fetchPlacemark(Coordinate loc) async {
    try {
      final placemark = await _locationService.getPlacemark(
        lat: loc.y.toDouble(),
        lng: loc.x.toDouble(),
      );

      // Only update if the coordinate hasn't changed
      if (state.coordinate == loc) {
        emit(
          state.copyWith(location: OperationResult.success((loc, placemark))),
        );
      }
    } catch (e, st) {
      logger.e(
        '[UserLocationCubit] _fetchPlacemark failed',
        error: e,
        stackTrace: st,
      );
      // Don't emit error - placemark is optional
    }
  }

  /// Force refresh location (ignores cache)
  Future<Coordinate?> refreshLocation({
    LocationAccuracy accuracy = LocationAccuracy.best,
  }) async {
    _lastFetchTime = null; // Invalidate cache
    return getMyLocation(accuracy: accuracy, fromCache: false);
  }

  /// Clear the location cache
  void clearCache() {
    _lastFetchTime = null;
  }

  // ==================== Map Markers & Polylines ====================

  /// Set markers on the map
  void setMarkers(Set<Marker> markers) {
    emit(state.copyWith(markers: markers));
  }

  /// Add a single marker to the map
  void addMarker(Marker marker) {
    final newMarkers = Set<Marker>.from(state.markers)..add(marker);
    emit(state.copyWith(markers: newMarkers));
  }

  /// Remove a marker by its id
  void removeMarker(MarkerId markerId) {
    final newMarkers = state.markers
        .where((m) => m.markerId != markerId)
        .toSet();
    emit(state.copyWith(markers: newMarkers));
  }

  /// Update markers - clears existing and sets new ones
  void updateMarkers(Set<Marker> markers) {
    emit(state.copyWith(markers: markers));
  }

  /// Set polylines on the map
  void setPolylines(Set<Polyline> polylines) {
    emit(state.copyWith(polylines: polylines));
  }

  /// Add a single polyline to the map
  void addPolyline(Polyline polyline) {
    final newPolylines = Set<Polyline>.from(state.polylines)..add(polyline);
    emit(state.copyWith(polylines: newPolylines));
  }

  /// Remove a polyline by its id
  void removePolyline(PolylineId polylineId) {
    final newPolylines = state.polylines
        .where((p) => p.polylineId != polylineId)
        .toSet();
    emit(state.copyWith(polylines: newPolylines));
  }

  /// Update polylines - clears existing and sets new ones
  void updatePolylines(Set<Polyline> polylines) {
    emit(state.copyWith(polylines: polylines));
  }

  /// Set both markers and polylines at once (more efficient)
  void setMapData({Set<Marker>? markers, Set<Polyline>? polylines}) {
    emit(
      state.copyWith(
        markers: markers ?? state.markers,
        polylines: polylines ?? state.polylines,
      ),
    );
  }

  /// Clear all map markers and polylines.
  /// Call this when entering a new order flow (ride/delivery/mart).
  void clearMapState() {
    logger.d('[UserLocationCubit] Clearing map state (markers & polylines)');
    emit(state.copyWith(markers: const {}, polylines: const {}));
  }

  /// Set pickup and dropoff markers with optional route polyline
  void setPickupDropoffMarkers({
    required LatLng pickup,
    required LatLng dropoff,
    String? pickupTitle,
    String? dropoffTitle,
    String? pickupSnippet,
    String? dropoffSnippet,
    List<LatLng>? routePoints,
    Color routeColor = Colors.blue,
    int routeWidth = 5,
  }) {
    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('pickup'),
        position: pickup,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: pickupTitle ?? 'Pickup',
          snippet: pickupSnippet,
        ),
      ),
      Marker(
        markerId: const MarkerId('dropoff'),
        position: dropoff,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: dropoffTitle ?? 'Dropoff',
          snippet: dropoffSnippet,
        ),
      ),
    };

    final polylines = <Polyline>{};
    if (routePoints != null && routePoints.isNotEmpty) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: routePoints,
          color: routeColor,
          width: routeWidth,
        ),
      );
    }

    emit(state.copyWith(markers: markers, polylines: polylines));
  }

  /// Set driver markers on the map
  void setDriverMarkers(
    List<Marker> driverMarkers, {
    bool keepExistingMarkers = false,
  }) {
    Set<Marker> newMarkers;
    if (keepExistingMarkers) {
      // Remove old driver markers and add new ones
      newMarkers =
          state.markers
              .where((m) => !m.markerId.value.startsWith('driver_'))
              .toSet()
            ..addAll(driverMarkers);
    } else {
      newMarkers = driverMarkers.toSet();
    }
    emit(state.copyWith(markers: newMarkers));
  }
}
