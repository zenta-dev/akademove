import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:geolocator/geolocator.dart';

/// Cubit for driver home screen WebSocket and location functionality.
///
/// This cubit manages:
/// - WebSocket connection for incoming orders
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
      _startLocationTracking();
    }
  }

  /// Update driver reference when DriverProfileCubit's driver changes.
  /// Call this when toggle online status changes.
  void updateDriver(Driver? driver) {
    final wasOnline = _driver?.isOnline ?? false;
    final isNowOnline = driver?.isOnline ?? false;

    _driver = driver;

    // Handle online status changes
    if (!wasOnline && isNowOnline) {
      _connectToDriverPool();
      _startLocationTracking();
    } else if (wasOnline && !isNowOnline) {
      _disconnectDriverPool();
      _stopLocationTracking();
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

  Future<void> _onLocationUpdate(Coordinate coordinate) async {
    final currentDriver = _driver;
    if (currentDriver == null || !currentDriver.isOnline) return;

    // Skip update if location hasn't changed
    final last = _lastLocation;
    if (last != null && last.x == coordinate.x && last.y == coordinate.y) {
      return;
    }

    try {
      // Check if location is mocked (for fraud detection)
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
        '[DriverHomeCubit] - Location updated: ${coordinate.y}, ${coordinate.x}, isMock: $isMocked',
      );
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error updating location: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _connectToDriverPool() async {
    try {
      const driverPool = 'driver-pool';

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
        driverPool,
        '${UrlConstants.wsBaseUrl}/$driverPool',
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
      await _webSocketService.disconnect('driver-pool');
      logger.i('[DriverHomeCubit] - Disconnected from driver pool WebSocket');
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error disconnecting from driver pool: $e',
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
