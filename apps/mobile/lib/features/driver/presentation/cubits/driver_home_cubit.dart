import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:geolocator/geolocator.dart';

class DriverHomeCubit extends BaseCubit<DriverHomeState> {
  DriverHomeCubit({
    required DriverRepository driverRepository,
    required OrderRepository orderRepository,
    required WebSocketService webSocketService,
    required ConfigurationRepository configurationRepository,
  }) : _driverRepository = driverRepository,
       _orderRepository = orderRepository,
       _webSocketService = webSocketService,
       _configurationRepository = configurationRepository,
       super(const DriverHomeState());

  final DriverRepository _driverRepository;
  final OrderRepository _orderRepository;
  final WebSocketService _webSocketService;
  final ConfigurationRepository _configurationRepository;

  Timer? _locationUpdateTimer;
  double? _platformFeeRate;

  Future<void> init() async {
    reset();
    await loadDriverProfile();
    await loadTodayStats();
  }

  void reset() {
    emit(const DriverHomeState());
    _locationUpdateTimer?.cancel();
  }

  @override
  Future<void> close() async {
    _locationUpdateTimer?.cancel();
    await _disconnectDriverPool();
    return super.close();
  }

  Future<void> loadDriverProfile() async =>
      await taskManager.execute("DHC-lDP1", () async {
        try {
          emit(state.copyWith(initResult: const OperationResult.loading()));

          final res = await _driverRepository.getMine();

          emit(
            state.copyWith(
              initResult: OperationResult.success(res.data),
              myDriver: res.data,
              isOnline: res.data.isOnline,
            ),
          );

          if (res.data.isOnline) {
            await _connectToDriverPool();
            _startLocationTracking();
          }
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverHomeCubit] - Error loading profile: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(initResult: OperationResult.failed(e)));
        }
      });

  Future<void> loadTodayStats() async =>
      await taskManager.execute('DHC-lTS2', () async {
        try {
          final now = DateTime.now();
          final startOfDay = DateTime(now.year, now.month, now.day);

          final ordersRes = await _orderRepository.list(
            ListOrderQuery(statuses: const [OrderStatus.COMPLETED]),
          );

          final todayOrders = ordersRes.data.where((order) {
            // Convert UTC timestamp to local time for comparison
            final orderDate = order.createdAt.toLocal();
            return orderDate.isAfter(startOfDay);
          }).toList();

          // Calculate driver earnings (totalPrice - platform commission)
          final todayEarnings = await _calculateDriverEarnings(todayOrders);

          emit(
            state.copyWith(
              todayTrips: todayOrders.length,
              todayEarnings: todayEarnings,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverHomeCubit] - Error loading today stats: ${e.message}',
            error: e,
            stackTrace: st,
          );
        }
      });

  Future<void> toggleOnlineStatus() async =>
      await taskManager.execute('DHC-tOS3', () async {
        final driverId = state.myDriver?.id;
        if (driverId == null) return;

        try {
          final newStatus = !state.isOnline;
          emit(
            state.copyWith(toggleOnlineResult: const OperationResult.loading()),
          );

          final res = await _driverRepository.updateOnlineStatus(
            driverId: driverId,
            isOnline: newStatus,
          );

          emit(
            state.copyWith(
              toggleOnlineResult: OperationResult.success(res.data),
              myDriver: res.data,
              isOnline: res.data.isOnline,
            ),
          );

          if (newStatus) {
            await _connectToDriverPool();
            _startLocationTracking();
          } else {
            await _disconnectDriverPool();
            _stopLocationTracking();
          }
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverHomeCubit] - Error toggling online status: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(toggleOnlineResult: OperationResult.failed(e)));
        }
      });

  Future<void> _startLocationTracking() async {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (
      _,
    ) async {
      await _updateLocation();
    });
    // Await initial location update to catch any errors
    await _updateLocation();
  }

  void _stopLocationTracking() {
    _locationUpdateTimer?.cancel();
  }

  Future<void> _updateLocation() async {
    final driverId = state.myDriver?.id;
    if (driverId == null || !state.isOnline) return;

    try {
      // Check permission
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        logger.w('[DriverHomeCubit] - Location permission denied');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      await _driverRepository.updateLocation(
        driverId: driverId,
        location: CoordinateWithMeta(
          x: position.longitude,
          y: position.latitude,
          isMockLocation: position.isMocked,
        ),
      );

      logger.d(
        '[DriverHomeCubit] - Location updated: ${position.latitude}, ${position.longitude}, isMock: ${position.isMocked}',
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

  /// Calculate total driver earnings from orders after platform commission
  /// Fetches commission rate from configuration.
  /// NOTE: Platform fee rate MUST come from database configuration.
  /// Fallback values are forbidden per business requirements.
  Future<num> _calculateDriverEarnings(List<Order> orders) async {
    if (orders.isEmpty) return 0;

    // Fetch platform fee rate from configuration if not already cached
    if (_platformFeeRate == null) {
      try {
        // Fetch ride pricing configuration (contains platformFeeRate)
        final configRes = await _configurationRepository.get(
          'ride-service-pricing',
        );
        final pricingConfig = configRes.data.value;

        // Parse the pricing configuration JSON
        if (pricingConfig is Map<String, Object?>) {
          final platformFeeRate = pricingConfig['platformFeeRate'];
          if (platformFeeRate is num) {
            _platformFeeRate = platformFeeRate.toDouble();
          } else {
            logger.e(
              '[DriverHomeCubit] platformFeeRate not found in configuration',
            );
            // Return 0 earnings to indicate error rather than showing wrong data
            return 0;
          }
        }
      } catch (e) {
        logger.e(
          '[DriverHomeCubit] Failed to fetch platform fee rate from database',
          error: e,
        );
        // Return 0 earnings to indicate error rather than showing wrong data
        return 0;
      }
    }

    // platformFeeRate should now be available from database
    if (_platformFeeRate == null) {
      logger.e('[DriverHomeCubit] Platform fee rate not available');
      return 0;
    }

    final driverShare = 1.0 - _platformFeeRate!;

    return orders.fold<num>(
      0,
      (sum, order) => sum + (order.totalPrice * driverShare),
    );
  }
}
