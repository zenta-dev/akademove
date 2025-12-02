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
  }) : _driverRepository = driverRepository,
       _orderRepository = orderRepository,
       _webSocketService = webSocketService,
       super(const DriverHomeState());

  final DriverRepository _driverRepository;
  final OrderRepository _orderRepository;
  final WebSocketService _webSocketService;

  Timer? _locationUpdateTimer;
  String? _driverId;

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
          final res = await _driverRepository.getMine();
          _driverId = res.data.id;

          emit(
            state.toSuccess(
              myDriver: res.data,
              isOnline: res.data.isTakingOrder,
              message: res.message,
            ),
          );

          if (res.data.isTakingOrder) {
            await _connectToDriverPool();
            _startLocationTracking();
          }
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverHomeCubit] - Error loading profile: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
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
            final orderDate = order.createdAt;
            return orderDate.isAfter(startOfDay);
          }).toList();

          final todayEarnings = todayOrders.fold<num>(
            0,
            (sum, order) => sum + order.totalPrice,
          );

          emit(
            state.toSuccess(
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
        final driverId = _driverId;
        if (driverId == null) return;

        try {
          final newStatus = !state.isOnline;
          emit(state.toLoading());

          final res = await _driverRepository.updateOnlineStatus(
            driverId: driverId,
            isOnline: newStatus,
          );

          emit(
            state.toSuccess(
              myDriver: res.data,
              isOnline: res.data.isTakingOrder,
              message: res.message,
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
          emit(state.toFailure(e));
        }
      });

  void _startLocationTracking() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (
      _,
    ) async {
      await _updateLocation();
    });
    _updateLocation();
  }

  void _stopLocationTracking() {
    _locationUpdateTimer?.cancel();
  }

  Future<void> _updateLocation() async {
    final driverId = _driverId;
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
        location: UpdateDriverLocationRequest(
          x: position.longitude,
          y: position.latitude,
        ),
      );

      logger.d(
        '[DriverHomeCubit] - Location updated: ${position.latitude}, ${position.longitude}',
      );
    } catch (e, st) {
      logger.e(
        '[DriverHomeCubit] - Error updating location: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _connectToDriverPool() async =>
      await taskManager.execute('DHC-cTDP5', () async {
        try {
          const driverPool = 'driver-pool';

          Future<void> handleMessage(Map<String, dynamic> json) async {
            try {
              final envelope = OrderEnvelope.fromJson(json);
              logger.d('[DriverHomeCubit] - Driver Pool Message: $envelope');

              if (envelope.e == OrderEnvelopeEvent.OFFER) {
                // New order offer received
                final order = envelope.p.detail?.order;
                if (order != null) {
                  emit(state.toSuccess(incomingOrder: order));
                }
              }

              if (envelope.e == OrderEnvelopeEvent.CANCELED) {
                // Order was cancelled before driver could accept
                emit(state.clearIncomingOrder());
              }

              if (envelope.e == OrderEnvelopeEvent.UNAVAILABLE) {
                // Order no longer available (accepted by another driver)
                emit(state.clearIncomingOrder());
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
      });

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
    emit(state.clearIncomingOrder());
  }

  void setCurrentOrder(Order order) {
    emit(state.toSuccess(currentOrder: order));
  }

  void clearCurrentOrder() {
    emit(state.clearCurrentOrder());
  }
}
