import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:geolocator/geolocator.dart';

class DriverOrderCubit extends BaseCubit<DriverOrderState> {
  DriverOrderCubit({
    required OrderRepository orderRepository,
    required WebSocketService webSocketService,
    required DriverRepository driverRepository,
  }) : _orderRepository = orderRepository,
       _webSocketService = webSocketService,
       _driverRepository = driverRepository,
       super(const DriverOrderState());

  final OrderRepository _orderRepository;
  final WebSocketService _webSocketService;
  final DriverRepository _driverRepository;

  Timer? _locationUpdateTimer;
  String? _currentOrderId;

  Future<void> init(Order order) async {
    _currentOrderId = order.id;
    emit(state.toSuccess(currentOrder: order, orderStatus: order.status));
    await _setupOrderWebSocket(order.id);
    _startLocationTracking();
  }

  void reset() {
    _stopLocationTracking();
    _currentOrderId = null;
    emit(const DriverOrderState());
  }

  @override
  Future<void> close() async {
    await teardownWebSocket();
    _stopLocationTracking();
    return super.close();
  }

  Future<void> acceptOrder(String orderId) async =>
      await taskManager.execute('DOC-aO1-$orderId', () async {
        try {
          emit(state.toLoading());

          final res = await _orderRepository.update(
            orderId,
            const UpdateOrder(status: OrderStatus.ACCEPTED),
          );

          emit(
            state.toSuccess(
              currentOrder: res.data,
              orderStatus: res.data.status,
              message: res.message,
            ),
          );

          await _setupOrderWebSocket(orderId);
          _startLocationTracking();
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverOrderCubit] - Error accepting order: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> rejectOrder(String orderId, {String? reason}) async =>
      await taskManager.execute('DOC-rO2-$orderId', () async {
        try {
          emit(state.toLoading());

          await _orderRepository.update(
            orderId,
            const UpdateOrder(
              status: OrderStatus.CANCELLED_BY_DRIVER,
              // Note: Backend should handle reject reason
            ),
          );

          emit(state.clearOrder());
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverOrderCubit] - Error rejecting order: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> updateOrderStatus(OrderStatus newStatus) async =>
      await taskManager.execute('DOC-uOS5-$newStatus', () async {
        final orderId = _currentOrderId;
        if (orderId == null) return;

        try {
          emit(state.toLoading());

          final res = await _orderRepository.update(
            orderId,
            UpdateOrder(status: newStatus),
          );

          emit(
            state.toSuccess(
              currentOrder: res.data,
              orderStatus: res.data.status,
              message: res.message,
            ),
          );

          if (newStatus == OrderStatus.COMPLETED ||
              newStatus == OrderStatus.CANCELLED_BY_USER ||
              newStatus == OrderStatus.CANCELLED_BY_DRIVER ||
              newStatus == OrderStatus.CANCELLED_BY_SYSTEM) {
            _stopLocationTracking();
            await teardownWebSocket();
          }
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverOrderCubit] - Error updating order status: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> markArrived() async {
    await updateOrderStatus(OrderStatus.ARRIVING);
  }

  Future<void> startTrip() async {
    await updateOrderStatus(OrderStatus.IN_TRIP);
  }

  Future<void> completeTrip() async {
    await updateOrderStatus(OrderStatus.COMPLETED);
  }

  Future<void> cancelOrder({String? reason}) async {
    final orderId = _currentOrderId;
    if (orderId == null) return;
    await rejectOrder(orderId, reason: reason);
  }

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

  Future<void>
  _updateLocation() async => await taskManager.execute('DOC-uL1', () async {
    final orderId = _currentOrderId;
    if (orderId == null) return;

    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        logger.w('[DriverOrderCubit] - Location permission denied');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final driverRes = await _driverRepository.getMine();

      // Update location on server
      await _driverRepository.updateLocation(
        driverId: driverRes.data.id,
        location: UpdateDriverLocationRequest(
          x: position.longitude,
          y: position.latitude,
        ),
      );

      logger.d(
        '[DriverOrderCubit] - Location updated: ${position.latitude}, ${position.longitude}',
      );
    } catch (e, st) {
      logger.e(
        '[DriverOrderCubit] - Error updating location: $e',
        error: e,
        stackTrace: st,
      );
    }
  });

  Future<void> _setupOrderWebSocket(String orderId) async {
    try {
      _currentOrderId = orderId;

      void handleMessage(Map<String, dynamic> json) {
        try {
          final envelope = OrderEnvelope.fromJson(json);
          logger.d('[DriverOrderCubit] - Order WebSocket Message: $envelope');

          // Handle order updates
          final detail = envelope.p.detail;
          final order = detail?.order;
          if (order != null) {
            emit(
              state.toSuccess(currentOrder: order, orderStatus: order.status),
            );
          }

          if (envelope.e == OrderEnvelopeEvent.CANCELED) {
            // Order was cancelled
            emit(state.clearOrder());
            teardownWebSocket();
          }

          if (envelope.e == OrderEnvelopeEvent.COMPLETED) {
            // Order completed
            _stopLocationTracking();
          }
        } catch (e, st) {
          logger.e(
            '[DriverOrderCubit] - Error handling WebSocket message: $e',
            error: e,
            stackTrace: st,
          );
        }
      }

      await _webSocketService.connect(
        orderId,
        '${UrlConstants.wsBaseUrl}/order/$orderId',
        onMessage: (msg) {
          final json = (msg as String).parseJson();
          if (json is Map<String, dynamic>) handleMessage(json);
        },
      );

      logger.i('[DriverOrderCubit] - Connected to order WebSocket: $orderId');
    } catch (e, st) {
      logger.e(
        '[DriverOrderCubit] - Error connecting to order WebSocket: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> teardownWebSocket() async {
    final orderId = _currentOrderId;
    if (orderId != null) {
      try {
        await _webSocketService.disconnect(orderId);
        logger.i(
          '[DriverOrderCubit] - Disconnected from order WebSocket: $orderId',
        );
      } catch (e, st) {
        logger.e(
          '[DriverOrderCubit] - Error disconnecting from order WebSocket: $e',
          error: e,
          stackTrace: st,
        );
      }
    }
  }
}
