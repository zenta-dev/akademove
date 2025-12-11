import 'dart:async';
import 'dart:convert';

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
  String? _currentDriverId;

  Future<void> init(Order order) async {
    _currentOrderId = order.id;
    _currentDriverId = order.driverId;
    emit(
      state.copyWith(
        fetchOrderResult: OperationResult.success(order),
        currentOrder: order,
        orderStatus: order.status,
      ),
    );
    await _setupOrderWebSocket(order.id);
    _startLocationTracking();
  }

  void reset() {
    _stopLocationTracking();
    _currentOrderId = null;
    _currentDriverId = null;
    emit(const DriverOrderState());
  }

  @override
  Future<void> close() async {
    await teardownWebSocket();
    _stopLocationTracking();
    return super.close();
  }

  Future<void> acceptOrder(String orderId, String driverId) async =>
      await taskManager.execute('DOC-aO1-$orderId', () async {
        try {
          emit(
            state.copyWith(acceptOrderResult: const OperationResult.loading()),
          );

          final res = await _orderRepository.update(
            orderId,
            UpdateOrder(status: OrderStatus.ACCEPTED, driverId: driverId),
          );

          _currentOrderId = orderId;
          _currentDriverId = driverId;

          emit(
            state.copyWith(
              acceptOrderResult: OperationResult.success(res.data),
              currentOrder: res.data,
              orderStatus: res.data.status,
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
          emit(state.copyWith(acceptOrderResult: OperationResult.failed(e)));
        }
      });

  Future<void> rejectOrder(String orderId, {String? reason}) async =>
      await taskManager.execute('DOC-rO2-$orderId', () async {
        try {
          emit(
            state.copyWith(updateStatusResult: const OperationResult.loading()),
          );

          await _orderRepository.update(
            orderId,
            const UpdateOrder(
              status: OrderStatus.CANCELLED_BY_DRIVER,
              // Note: Backend should handle reject reason
            ),
          );

          emit(const DriverOrderState());
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverOrderCubit] - Error rejecting order: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(updateStatusResult: OperationResult.failed(e)));
        }
      });

  Future<void> updateOrderStatus(OrderStatus newStatus) async =>
      await taskManager.execute('DOC-uOS5-$newStatus', () async {
        final orderId = _currentOrderId;
        if (orderId == null) return;

        try {
          emit(
            state.copyWith(updateStatusResult: const OperationResult.loading()),
          );

          final res = await _orderRepository.update(
            orderId,
            UpdateOrder(status: newStatus),
          );

          emit(
            state.copyWith(
              updateStatusResult: OperationResult.success(res.data),
              currentOrder: res.data,
              orderStatus: res.data.status,
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
          emit(state.copyWith(updateStatusResult: OperationResult.failed(e)));
        }
      });

  Future<void> markArrived() async {
    await updateOrderStatus(OrderStatus.ARRIVING);
  }

  Future<void> startTrip() async {
    await updateOrderStatus(OrderStatus.IN_TRIP);
  }

  /// Complete the trip by sending a WebSocket 'DONE' action.
  /// This triggers server-side commission calculation, driver wallet credit,
  /// and broadcasts COMPLETED event to user for real-time UI update.
  Future<void>
  completeTrip() async => await taskManager.execute('DOC-cT-done', () async {
    final orderId = _currentOrderId;
    final driverId = _currentDriverId;

    if (orderId == null || driverId == null) {
      logger.w(
        '[DriverOrderCubit] - Cannot complete trip: '
        'orderId=$orderId, driverId=$driverId',
      );
      return;
    }

    try {
      emit(state.copyWith(updateStatusResult: const OperationResult.loading()));

      // Get current location for the DONE payload
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        logger.w('[DriverOrderCubit] - Location permission denied');
        emit(
          state.copyWith(
            updateStatusResult: OperationResult.failed(
              const UnknownError('Location permission required'),
            ),
          ),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Send DONE action via WebSocket to trigger server-side:
      // - Commission calculation
      // - Driver wallet credit
      // - COMPLETED broadcast to user
      final envelope = OrderEnvelope(
        f: EnvelopeSender.c,
        t: EnvelopeSender.s,
        a: OrderEnvelopeAction.DONE,
        p: OrderEnvelopePayload(
          done: OrderEnvelopePayloadDone(
            by: OrderEnvelopePayloadDoneByEnum.DRIVER,
            orderId: orderId,
            driverId: driverId,
            driverCurrentLocation: Coordinate(
              x: position.longitude,
              y: position.latitude,
            ),
          ),
        ),
      );

      _webSocketService.send(orderId, jsonEncode(envelope.toJson()));

      logger.i(
        '[DriverOrderCubit] - Sent DONE action via WebSocket for order: $orderId',
      );

      // Update local state optimistically
      // The actual confirmation comes via WebSocket COMPLETED event
      final currentOrder = state.currentOrder;
      if (currentOrder != null) {
        emit(
          state.copyWith(
            updateStatusResult: OperationResult.success(
              currentOrder.copyWith(status: OrderStatus.COMPLETED),
            ),
            currentOrder: currentOrder.copyWith(status: OrderStatus.COMPLETED),
            orderStatus: OrderStatus.COMPLETED,
          ),
        );
      }

      _stopLocationTracking();
      // Don't teardown WebSocket immediately - wait for COMPLETED confirmation
    } catch (e, st) {
      logger.e(
        '[DriverOrderCubit] - Error completing trip: $e',
        error: e,
        stackTrace: st,
      );
      emit(
        state.copyWith(
          updateStatusResult: OperationResult.failed(
            e is BaseError ? e : UnknownError(e.toString()),
          ),
        ),
      );
    }
  });

  Future<void> cancelOrder({String? reason}) async {
    final orderId = _currentOrderId;
    if (orderId == null) return;
    await rejectOrder(orderId, reason: reason);
  }

  /// Upload delivery proof photo (for high-value orders > 100k IDR)
  Future<void> uploadDeliveryProof(
    String imagePath,
  ) async => await taskManager.execute('DOC-uDP-$imagePath', () async {
    final orderId = _currentOrderId;
    if (orderId == null) {
      logger.w('[DriverOrderCubit] - No current order to upload proof for');
      return;
    }

    try {
      emit(state.copyWith(updateStatusResult: const OperationResult.loading()));

      final res = await _orderRepository.uploadDeliveryProof(
        orderId,
        imagePath,
      );

      // res.data is the uploaded proof URL (String), not an Order
      // Keep the current order state and just update with success message
      final currentOrder = state.currentOrder;
      emit(
        state.copyWith(
          updateStatusResult: currentOrder != null
              ? OperationResult.success(currentOrder)
              : const OperationResult.idle(),
          currentOrder: currentOrder,
          orderStatus: currentOrder?.status,
        ),
      );

      logger.i(
        '[DriverOrderCubit] - Delivery proof uploaded successfully: ${res.data}',
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverOrderCubit] - Error uploading delivery proof: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(updateStatusResult: OperationResult.failed(e)));
    }
  });

  void _startLocationTracking() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (
      _,
    ) async {
      await safeAsync(() => _updateLocation());
    });
    _updateLocation();
  }

  void _stopLocationTracking() {
    _locationUpdateTimer?.cancel();
  }

  Future<void>
  _updateLocation() async => await taskManager.execute('DOC-uL1', () async {
    final orderId = _currentOrderId;
    final driverId = _currentDriverId;
    if (orderId == null || driverId == null) return;

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

      // Send location update via WebSocket to broadcast to user in real-time
      final envelope = OrderEnvelope(
        f: EnvelopeSender.c,
        t: EnvelopeSender.s,
        a: OrderEnvelopeAction.UPDATE_LOCATION,
        p: OrderEnvelopePayload(
          driverUpdateLocation: OrderEnvelopePayloadDriverUpdateLocation(
            driverId: driverId,
            x: position.longitude,
            y: position.latitude,
          ),
        ),
      );
      _webSocketService.send(orderId, jsonEncode(envelope.toJson()));

      // Also update location on server via REST API for persistence and fraud detection
      await _driverRepository.updateLocation(
        driverId: driverId,
        location: CoordinateWithMeta(
          x: position.longitude,
          y: position.latitude,
          isMockLocation: position.isMocked,
        ),
      );

      logger.d(
        '[DriverOrderCubit] - Location updated (WS + REST): ${position.latitude}, ${position.longitude}, isMock: ${position.isMocked}',
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
              state.copyWith(
                fetchOrderResult: OperationResult.success(order),
                currentOrder: order,
                orderStatus: order.status,
              ),
            );
          }

          if (envelope.e == OrderEnvelopeEvent.CANCELED) {
            // Order was cancelled
            emit(const DriverOrderState());
            teardownWebSocket();
          }

          if (envelope.e == OrderEnvelopeEvent.COMPLETED) {
            // Order completed - update state and cleanup
            _stopLocationTracking();
            final completedOrder = detail?.order;
            if (completedOrder != null) {
              emit(
                state.copyWith(
                  updateStatusResult: OperationResult.success(completedOrder),
                  currentOrder: completedOrder,
                  orderStatus: completedOrder.status,
                ),
              );
            }
            logger.i(
              '[DriverOrderCubit] - Order completed confirmation received',
            );
            // Teardown WebSocket after completion is confirmed
            teardownWebSocket();
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
