import 'dart:async';
import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:geolocator/geolocator.dart';

/// Cubit for driver home screen WebSocket and location functionality.
///
/// This cubit manages:
/// - WebSocket connection for incoming orders (driver-pool)
/// - WebSocket connection for location updates (driver-location)
/// - Location tracking and updates
/// - Incoming/current order state
///
/// For driver profile and stats, use [DriverProfileCubit].
/// This cubit does NOT own the driver - it receives driver updates
/// via [updateDriver] from the screen when [DriverProfileCubit] changes.
class DriverHomeCubit extends BaseCubit<DriverHomeState> {
  DriverHomeCubit({
    required DriverRepository driverRepository,
    required WebSocketService webSocketService,
    required LocationService locationService,
  }) : _driverRepository = driverRepository,
       _webSocketService = webSocketService,
       _locationService = locationService,
       super(const DriverHomeState());

  final DriverRepository _driverRepository;
  final WebSocketService _webSocketService;
  final LocationService _locationService;

  /// Location stream subscription for real-time GPS updates
  StreamSubscription<Coordinate>? _locationStreamSubscription;

  /// Last known location to avoid duplicate updates
  Coordinate? _lastLocation;

  /// Driver reference for WebSocket/location operations.
  /// This is a cache updated via [updateDriver], NOT a source of truth.
  Driver? _driver;

  /// Initialize the cubit with a driver.
  /// Call this after DriverProfileCubit has loaded the driver.
  Future<void> initWithDriver(Driver? driver) async {
    reset();
    _driver = driver;

    // Start WebSocket and location tracking if driver is online
    if (driver != null && driver.isOnline) {
      await _connectToDriverPool();
      await _connectToDriverLocation(driver.id);
      _startLocationTracking();
      // Fetch and emit initial location immediately
      await _fetchInitialLocation();
    }
  }

  /// Fetch and emit the initial location when driver goes online.
  Future<void> _fetchInitialLocation() async {
    try {
      final coordinate = await _locationService.getMyLocation(
        accuracy: LocationAccuracy.high,
        fromCache: false,
      );
      if (coordinate != null) {
        _lastLocation = coordinate;
        emit(state.copyWith(currentLocation: coordinate));
        logger.i(
          '[DriverHomeCubit] - Initial location fetched: '
          '${coordinate.y}, ${coordinate.x}',
        );
      }
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error fetching initial location',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Update driver reference when DriverProfileCubit's driver changes.
  /// Call this when toggle online status changes.
  void updateDriver(Driver? driver) {
    final wasOnline = _driver?.isOnline ?? false;
    final isNowOnline = driver?.isOnline ?? false;

    _driver = driver;

    // Handle online status changes
    if (!wasOnline && isNowOnline && driver != null) {
      _connectToDriverPool();
      _connectToDriverLocation(driver.id);
      _startLocationTracking();
      // Fetch and emit initial location when going online
      _fetchInitialLocation();
    } else if (wasOnline && !isNowOnline) {
      _disconnectDriverPool();
      _disconnectDriverLocation();
      _stopLocationTracking();
      // Clear location when going offline
      emit(state.copyWith(currentLocation: null));
    }
  }

  void reset() {
    emit(const DriverHomeState());
    _stopLocationTracking();
    _driver = null;
  }

  @override
  Future<void> close() async {
    _stopLocationTracking();
    await _disconnectDriverPool();
    await _disconnectDriverLocation();
    return super.close();
  }

  void _startLocationTracking() {
    _stopLocationTracking();

    final currentDriver = _driver;
    if (currentDriver == null || !currentDriver.isOnline) return;

    logger.i('[DriverHomeCubit] - Starting location stream tracking');

    _locationStreamSubscription = _locationService
        .getLocationStream(
          accuracy: LocationAccuracy.high,
          interval: const Duration(seconds: 3),
        )
        .listen(
          (coordinate) => _onLocationUpdate(coordinate),
          onError: (Object error, StackTrace st) {
            logger.e(
              '[DriverHomeCubit] - Location stream error',
              error: error,
              stackTrace: st,
            );
          },
        );
  }

  void _stopLocationTracking() {
    _locationStreamSubscription?.cancel();
    _locationStreamSubscription = null;
    _lastLocation = null;
  }

  /// WebSocket connection key for driver pool (order offers)
  static const String _driverPoolKey = 'driver-pool';

  /// WebSocket connection key prefix for driver location updates
  static const String _driverLocationKeyPrefix = 'driver-location';

  /// Get the driver location WebSocket key for a specific driver
  String _getDriverLocationKey(String driverId) =>
      '$_driverLocationKeyPrefix-$driverId';

  Future<void> _onLocationUpdate(Coordinate coordinate) async {
    final currentDriver = _driver;
    if (currentDriver == null || !currentDriver.isOnline) return;

    // Skip update if location hasn't changed (deduplication to prevent DB heating)
    final last = _lastLocation;
    if (last != null && last.x == coordinate.x && last.y == coordinate.y) {
      return;
    }

    // Emit location to state for UI updates (map, address display)
    emit(state.copyWith(currentLocation: coordinate));

    try {
      // Check if location is mocked (for fraud detection)
      final position = await Geolocator.getLastKnownPosition();
      final isMocked = position?.isMocked ?? false;

      // WebSocket-first approach: Try WebSocket, fallback to HTTP REST
      // Use dedicated driver-location WebSocket for location updates
      final locationKey = _getDriverLocationKey(currentDriver.id);

      // Simple envelope format matching server's DriverLocationEnvelopeSchema
      final envelope = <String, dynamic>{
        'a': 'UPDATE_LOCATION', // action
        'f': 'c', // from: client
        't': 's', // to: server
        'p': {
          // payload
          'driverId': currentDriver.id,
          'x': coordinate.x, // longitude
          'y': coordinate.y, // latitude
        },
      };

      // Check if WebSocket is connected and healthy
      final isWsConnected = _webSocketService.isConnected(locationKey);
      final isWsHealthy = _webSocketService.isConnectionHealthy(locationKey);

      if (isWsConnected && isWsHealthy) {
        // Primary: Send via WebSocket (server will persist)
        _webSocketService.send(locationKey, jsonEncode(envelope));
        _lastLocation = coordinate;

        logger.d(
          '[DriverHomeCubit] - Location updated via WebSocket: '
          '${coordinate.y}, ${coordinate.x}, isMock: $isMocked',
        );
      } else {
        // Fallback: Use HTTP REST API when WebSocket is unavailable
        await _driverRepository.updateLocation(
          driverId: currentDriver.id,
          location: CoordinateWithMeta(
            x: coordinate.x,
            y: coordinate.y,
            isMockLocation: isMocked,
          ),
        );
        _lastLocation = coordinate;

        logger.d(
          '[DriverHomeCubit] - Location updated via REST (WS fallback): '
          '${coordinate.y}, ${coordinate.x}, isMock: $isMocked',
        );
      }
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error updating location: $e',
        error: e,
        stackTrace: st,
      );

      // If WebSocket send failed, try HTTP REST as fallback
      final currentDriver = _driver;
      if (currentDriver == null) return;

      try {
        final position = await Geolocator.getLastKnownPosition();
        final isMocked = position?.isMocked ?? false;

        await _driverRepository.updateLocation(
          driverId: currentDriver.id,
          location: CoordinateWithMeta(
            x: coordinate.x,
            y: coordinate.y,
            isMockLocation: isMocked,
          ),
        );
        _lastLocation = coordinate;

        logger.d(
          '[DriverHomeCubit] - Location updated via REST (error fallback): '
          '${coordinate.y}, ${coordinate.x}',
        );
      } catch (restError, restSt) {
        logger.e(
          '[DriverHomeCubit] - REST fallback also failed: $restError',
          error: restError,
          stackTrace: restSt,
        );
      }
    }
  }

  /// Connect to driver pool WebSocket for receiving order offers
  Future<void> _connectToDriverPool() async {
    try {
      Future<void> handleMessage(Map<String, dynamic> json) async {
        try {
          final envelope = OrderEnvelope.fromJson(json);
          logger.d('[DriverHomeCubit] - Driver Pool Message: $envelope');

          if (envelope.e == OrderEnvelopeEvent.OFFER ||
              envelope.a == OrderEnvelopeAction.MATCHING) {
            // New order offer received
            final order = envelope.p.detail?.order;
            if (order != null) {
              logger.i(
                '[DriverHomeCubit] - New incoming order offer: ${order.id}',
              );
              emit(state.copyWith(incomingOrder: order));
            }
          }

          if (envelope.e == OrderEnvelopeEvent.CANCELED) {
            // Order was cancelled before driver could accept
            clearIncomingOrder();
          }

          if (envelope.e == OrderEnvelopeEvent.UNAVAILABLE) {
            // Order no longer available (accepted by another driver)
            clearIncomingOrder();
          }
        } catch (e, st) {
          logger.e(
            '[DriverHomeCubit] - Error handling WebSocket message: $e',
            error: e,
            stackTrace: st,
          );
        }
      }

      await _webSocketService.connect(
        _driverPoolKey,
        '${UrlConstants.wsBaseUrl}/$_driverPoolKey',
        onMessage: (msg) async {
          final json = (msg as String).parseJson();
          if (json is Map<String, dynamic>) await handleMessage(json);
        },
      );

      logger.i('[DriverHomeCubit] - Connected to driver pool WebSocket');
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error connecting to driver pool: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _disconnectDriverPool() async {
    try {
      await _webSocketService.disconnect(_driverPoolKey);
      logger.i('[DriverHomeCubit] - Disconnected from driver pool WebSocket');
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error disconnecting from driver pool: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Connect to dedicated driver location WebSocket for sending location updates
  Future<void> _connectToDriverLocation(String driverId) async {
    final locationKey = _getDriverLocationKey(driverId);
    try {
      await _webSocketService.connect(
        locationKey,
        '${UrlConstants.wsBaseUrl}/driver-location/$driverId',
        onMessage: (msg) {
          // Driver location WebSocket is primarily for sending, not receiving
          // But we can handle any server acknowledgments here if needed
          logger.d('[DriverHomeCubit] - Driver Location WS message: $msg');
        },
      );

      logger.i(
        '[DriverHomeCubit] - Connected to driver location WebSocket: $driverId',
      );
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error connecting to driver location WS: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _disconnectDriverLocation() async {
    final currentDriver = _driver;
    if (currentDriver == null) return;

    final locationKey = _getDriverLocationKey(currentDriver.id);
    try {
      await _webSocketService.disconnect(locationKey);
      logger.i(
        '[DriverHomeCubit] - Disconnected from driver location WebSocket',
      );
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error disconnecting from driver location WS: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  void clearIncomingOrder() {
    emit(state.copyWith(incomingOrder: null));
  }

  void setCurrentOrder(Order order) {
    emit(state.copyWith(currentOrder: order));
  }

  void clearCurrentOrder() {
    emit(state.copyWith(currentOrder: null));
  }
}
