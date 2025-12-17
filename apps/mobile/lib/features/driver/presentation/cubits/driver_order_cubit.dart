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
    required LocationService locationService,
    required KeyValueService keyValueService,
  }) : _orderRepository = orderRepository,
       _webSocketService = webSocketService,
       _driverRepository = driverRepository,
       _locationService = locationService,
       _keyValueService = keyValueService,
       super(const DriverOrderState());

  final OrderRepository _orderRepository;
  final WebSocketService _webSocketService;
  final DriverRepository _driverRepository;
  final LocationService _locationService;
  final KeyValueService _keyValueService;

  StreamSubscription<Coordinate>? _locationStreamSubscription;
  Coordinate? _lastLocation;
  String? _currentOrderId;
  String? _currentDriverId;

  /// Last known order version for tracking updates (used for debugging/logging)
  // ignore: unused_field
  String? _lastKnownVersion;

  Future<void> init(Order order) async {
    _currentOrderId = order.id;
    _currentDriverId = order.driverId;

    // Store active order ID for recovery
    await _keyValueService.set(KeyValueKeys.driverActiveOrderId, order.id);

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
    _lastKnownVersion = null;
    emit(const DriverOrderState());
  }

  @override
  Future<void> close() async {
    await teardownWebSocket();
    _stopLocationTracking();
    return super.close();
  }

  // ============================================================
  // Active Order Recovery
  // ============================================================

  /// Check if there's an active order for the current driver and recover the state
  /// This should be called when the app is reopened or after authentication
  /// Returns true if an active order was found and recovered
  Future<bool> recoverActiveOrder() async {
    try {
      return await taskManager.execute('DOC-rao', () async {
        logger.d('[DriverOrderCubit] Checking for active order to recover...');

        emit(
          state.copyWith(recoverOrderResult: const OperationResult.loading()),
        );

        final res = await _orderRepository.getActiveOrder();
        final activeOrder = res.data;

        if (activeOrder == null) {
          logger.d('[DriverOrderCubit] No active order found');
          // Clear any stored active order ID and stale state
          await clearActiveOrder();
          emit(
            state.copyWith(recoverOrderResult: const OperationResult.idle()),
          );
          return false;
        }

        final order = activeOrder.order;

        // Check if the returned order is in a terminal state
        if (_isTerminalStatus(order.status)) {
          logger.i(
            '[DriverOrderCubit] Recovered order ${order.id} is in '
            'terminal state (${order.status}), clearing active order',
          );
          await clearActiveOrder();
          emit(
            state.copyWith(recoverOrderResult: const OperationResult.idle()),
          );
          return false;
        }

        logger.i(
          '[DriverOrderCubit] Found active order: ${order.id} '
          'with status: ${order.status}',
        );

        // Store the active order ID for future reference
        await _keyValueService.set(KeyValueKeys.driverActiveOrderId, order.id);

        _currentOrderId = order.id;
        _currentDriverId = order.driverId;

        // Emit the recovered state
        emit(
          state.copyWith(
            recoverOrderResult: OperationResult.success(order),
            fetchOrderResult: OperationResult.success(order),
            currentOrder: order,
            orderStatus: order.status,
          ),
        );

        // Setup WebSocket and start location tracking
        await _setupOrderWebSocket(order.id);
        _startLocationTracking();

        return true;
      });
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverOrderCubit] - Error recovering active order: ${e.message}',
        error: e,
        stackTrace: st,
      );
      // Clear any stored active order ID on error
      await _keyValueService.remove(KeyValueKeys.driverActiveOrderId);
      emit(state.copyWith(recoverOrderResult: OperationResult.failed(e)));
      return false;
    }
  }

  /// Clear the active order state and stored ID
  Future<void> clearActiveOrder() async {
    await _keyValueService.remove(KeyValueKeys.driverActiveOrderId);
    await teardownWebSocket();
    _stopLocationTracking();
    _currentOrderId = null;
    _currentDriverId = null;
    _lastKnownVersion = null;
    emit(const DriverOrderState());
  }

  /// Check if order status is terminal (completed or cancelled)
  bool _isTerminalStatus(OrderStatus status) {
    return status == OrderStatus.COMPLETED ||
        status == OrderStatus.CANCELLED_BY_USER ||
        status == OrderStatus.CANCELLED_BY_DRIVER ||
        status == OrderStatus.CANCELLED_BY_MERCHANT ||
        status == OrderStatus.CANCELLED_BY_SYSTEM ||
        status == OrderStatus.NO_SHOW;
  }

  // ============================================================
  // Order Actions
  // ============================================================

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

          // Store active order ID for recovery
          await _keyValueService.set(KeyValueKeys.driverActiveOrderId, orderId);

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
            state.copyWith(rejectOrderResult: const OperationResult.loading()),
          );

          final res = await _orderRepository.update(
            orderId,
            const UpdateOrder(status: OrderStatus.CANCELLED_BY_DRIVER),
          );

          emit(
            state.copyWith(
              rejectOrderResult: OperationResult.success(res.data),
              currentOrder: res.data,
              orderStatus: res.data.status,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverOrderCubit] - Error rejecting order: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(rejectOrderResult: OperationResult.failed(e)));
        }
      });

  Future<void> markArrived() async =>
      await taskManager.execute('DOC-mA-arrived', () async {
        final orderId = _currentOrderId;
        if (orderId == null) return;

        try {
          emit(
            state.copyWith(markArrivedResult: const OperationResult.loading()),
          );

          final res = await _orderRepository.update(
            orderId,
            const UpdateOrder(status: OrderStatus.ARRIVING),
          );

          emit(
            state.copyWith(
              markArrivedResult: OperationResult.success(res.data),
              currentOrder: res.data,
              orderStatus: res.data.status,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverOrderCubit] - Error marking arrived: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(markArrivedResult: OperationResult.failed(e)));
        }
      });

  Future<void> startTrip() async => await taskManager.execute(
    'DOC-sT-start',
    () async {
      final orderId = _currentOrderId;
      if (orderId == null) return;

      try {
        emit(state.copyWith(startTripResult: const OperationResult.loading()));

        final res = await _orderRepository.update(
          orderId,
          const UpdateOrder(status: OrderStatus.IN_TRIP),
        );

        emit(
          state.copyWith(
            startTripResult: OperationResult.success(res.data),
            currentOrder: res.data,
            orderStatus: res.data.status,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[DriverOrderCubit] - Error starting trip: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(startTripResult: OperationResult.failed(e)));
      }
    },
  );

  /// Complete the trip by sending a WebSocket 'DONE' action.
  Future<void>
  completeTrip() async => await taskManager.execute('DOC-cT-done', () async {
    final orderId = _currentOrderId;
    final driverId = _currentDriverId;

    if (orderId == null || driverId == null) {
      logger.w(
        '[DriverOrderCubit] - Cannot complete trip: '
        'orderId=$orderId, driverId=$driverId',
      );
      emit(
        state.copyWith(
          completeTripResult: const OperationResult.failed(
            UnknownError('Order or driver ID is missing. Please try again.'),
          ),
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(completeTripResult: const OperationResult.loading()));

      // Check WebSocket connection first
      if (!_webSocketService.isConnected(orderId)) {
        logger.w(
          '[DriverOrderCubit] - WebSocket not connected for order: $orderId. '
          'Attempting to reconnect...',
        );
        // Try to reconnect WebSocket before proceeding
        await _setupOrderWebSocket(orderId);
        // Give it a moment to connect
        await Future<void>.delayed(const Duration(milliseconds: 500));

        if (!_webSocketService.isConnected(orderId)) {
          logger.e(
            '[DriverOrderCubit] - Failed to reconnect WebSocket for order: $orderId',
          );
          emit(
            state.copyWith(
              completeTripResult: const OperationResult.failed(
                UnknownError(
                  'Connection lost. Please check your internet and try again.',
                ),
              ),
            ),
          );
          return;
        }
      }

      // Get current location for the DONE payload
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        logger.w('[DriverOrderCubit] - Location permission denied');
        emit(
          state.copyWith(
            completeTripResult: const OperationResult.failed(
              UnknownError(
                'Location permission is required to complete the trip.',
              ),
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

      // Send DONE action via WebSocket FIRST (handles financial calculations)
      final envelope = OrderEnvelope(
        f: EnvelopeSender.c,
        t: EnvelopeSender.s,
        a: OrderEnvelopeAction.DRIVER_COMPLETE_ORDER,
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

      // Small delay to allow WebSocket handler to process
      await Future<void>.delayed(const Duration(milliseconds: 300));

      // Fetch the updated order to get the latest status and financial data
      final res = await _orderRepository.get(orderId);

      // Verify the order was actually completed
      if (res.data.status != OrderStatus.COMPLETED) {
        logger.w(
          '[DriverOrderCubit] - Order status is ${res.data.status} after completion attempt',
        );
        // Fallback: try to update via API if WebSocket didn't work
        final updateRes = await _orderRepository.update(
          orderId,
          const UpdateOrder(status: OrderStatus.COMPLETED),
        );
        emit(
          state.copyWith(
            completeTripResult: OperationResult.success(updateRes.data),
            currentOrder: updateRes.data,
            orderStatus: updateRes.data.status,
          ),
        );
      } else {
        // Update local state with result
        emit(
          state.copyWith(
            completeTripResult: OperationResult.success(res.data),
            currentOrder: res.data,
            orderStatus: res.data.status,
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
          completeTripResult: OperationResult.failed(
            e is BaseError ? e : UnknownError(e.toString()),
          ),
        ),
      );
    }
  });

  Future<void> cancelOrder({String? reason}) async =>
      await taskManager.execute('DOC-cO-cancel', () async {
        final orderId = _currentOrderId;
        if (orderId == null) return;

        try {
          emit(
            state.copyWith(cancelOrderResult: const OperationResult.loading()),
          );

          final res = await _orderRepository.update(
            orderId,
            const UpdateOrder(status: OrderStatus.CANCELLED_BY_DRIVER),
          );

          emit(
            state.copyWith(
              cancelOrderResult: OperationResult.success(res.data),
              currentOrder: res.data,
              orderStatus: res.data.status,
            ),
          );

          _stopLocationTracking();
          await clearActiveOrder();
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverOrderCubit] - Error canceling order: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(cancelOrderResult: OperationResult.failed(e)));
        }
      });

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
      emit(state.copyWith(uploadProofResult: const OperationResult.loading()));

      final res = await _orderRepository.uploadDeliveryProof(
        orderId,
        imagePath,
      );

      final currentOrder = state.currentOrder;
      emit(
        state.copyWith(
          uploadProofResult: currentOrder != null
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
      emit(state.copyWith(uploadProofResult: OperationResult.failed(e)));
    }
  });

  /// Upload delivery item photo (driver uploads photo of picked up item)
  /// This is used to document the item at pickup for verification purposes
  Future<void> uploadDeliveryItemPhoto(
    String imagePath,
  ) async => await taskManager.execute('DOC-uDIP-$imagePath', () async {
    final orderId = _currentOrderId;
    if (orderId == null) {
      logger.w(
        '[DriverOrderCubit] - No current order to upload item photo for',
      );
      return;
    }

    try {
      emit(
        state.copyWith(uploadItemPhotoResult: const OperationResult.loading()),
      );

      final res = await _orderRepository.uploadDeliveryItemPhoto(
        orderId,
        imagePath,
      );

      final currentOrder = state.currentOrder;
      emit(
        state.copyWith(
          uploadItemPhotoResult: currentOrder != null
              ? OperationResult.success(currentOrder)
              : const OperationResult.idle(),
          currentOrder: currentOrder,
          orderStatus: currentOrder?.status,
        ),
      );

      logger.i(
        '[DriverOrderCubit] - Delivery item photo uploaded successfully: '
        '${res.data}',
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverOrderCubit] - Error uploading delivery item photo: '
        '${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(uploadItemPhotoResult: OperationResult.failed(e)));
    }
  });

  // ============================================================
  // Location Tracking
  // ============================================================

  void _startLocationTracking() {
    _stopLocationTracking();

    final orderId = _currentOrderId;
    final driverId = _currentDriverId;
    if (orderId == null || driverId == null) {
      logger.w(
        '[DriverOrderCubit] - Cannot start location tracking: '
        'orderId=$orderId, driverId=$driverId',
      );
      return;
    }

    logger.i('[DriverOrderCubit] - Starting location stream tracking');

    _locationStreamSubscription = _locationService
        .getLocationStream(
          accuracy: LocationAccuracy.high,
          interval: const Duration(seconds: 3),
        )
        .listen(
          (coordinate) => _onLocationUpdate(coordinate),
          onError: (Object error, StackTrace st) {
            logger.e(
              '[DriverOrderCubit] - Location stream error',
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
    // Skip update if location hasn't changed significantly (deduplication to
    // prevent unnecessary rerenders and DB heating). Uses 3m threshold to
    // filter out GPS noise/jitter when driver is stationary.
    final last = _lastLocation;
    if (last != null &&
        distanceInMeters(last, coordinate) < kMinLocationUpdateDistanceMeters) {
      return;
    }

    await taskManager.execute('DOC-uL1', () async {
      final orderId = _currentOrderId;
      final driverId = _currentDriverId;
      if (orderId == null || driverId == null) return;

      try {
        // WebSocket-first approach: Try WebSocket, fallback to HTTP REST
        final envelope = OrderEnvelope(
          f: EnvelopeSender.c,
          t: EnvelopeSender.s,
          a: OrderEnvelopeAction.DRIVER_UPDATE_LOCATION,
          p: OrderEnvelopePayload(
            driverUpdateLocation: OrderEnvelopePayloadDriverUpdateLocation(
              driverId: driverId,
              x: coordinate.x,
              y: coordinate.y,
            ),
          ),
        );

        // Check if WebSocket is connected and healthy
        final isWsConnected = _webSocketService.isConnected(orderId);
        final isWsHealthy = _webSocketService.isConnectionHealthy(orderId);

        if (isWsConnected && isWsHealthy) {
          // Primary: Send via WebSocket (server will persist + broadcast)
          _webSocketService.send(orderId, jsonEncode(envelope.toJson()));
          _lastLocation = coordinate;

          logger.d(
            '[DriverOrderCubit] - Location updated via WebSocket: '
            'lat=${coordinate.y}, lng=${coordinate.x}',
          );
        } else {
          // Fallback: Use HTTP REST API when WebSocket is unavailable
          await _driverRepository.updateLocation(
            driverId: driverId,
            location: CoordinateWithMeta(
              x: coordinate.x,
              y: coordinate.y,
              isMockLocation: false,
            ),
          );
          _lastLocation = coordinate;

          logger.d(
            '[DriverOrderCubit] - Location updated via REST (WS fallback): '
            'lat=${coordinate.y}, lng=${coordinate.x}',
          );
        }
      } catch (e, st) {
        logger.e(
          '[DriverOrderCubit] - Error updating location: $e',
          error: e,
          stackTrace: st,
        );

        // If WebSocket send failed, try HTTP REST as fallback
        try {
          await _driverRepository.updateLocation(
            driverId: driverId,
            location: CoordinateWithMeta(
              x: coordinate.x,
              y: coordinate.y,
              isMockLocation: false,
            ),
          );
          _lastLocation = coordinate;

          logger.d(
            '[DriverOrderCubit] - Location updated via REST (error fallback): '
            'lat=${coordinate.y}, lng=${coordinate.x}',
          );
        } catch (restError, restSt) {
          logger.e(
            '[DriverOrderCubit] - REST fallback also failed: $restError',
            error: restError,
            stackTrace: restSt,
          );
        }
      }
    });
  }

  // ============================================================
  // WebSocket Real-time Updates
  // ============================================================

  /// Setup order WebSocket connection
  /// Server pushes all updates via WebSocket events
  Future<void> _setupOrderWebSocket(String orderId) async {
    try {
      _currentOrderId = orderId;

      // Initialize version from current order if available
      final currentOrder = state.currentOrder;
      if (currentOrder != null) {
        _lastKnownVersion = currentOrder.updatedAt.toIso8601String();
      }

      // Setup WebSocket status listener
      _webSocketService.setStatusListener(
        orderId,
        _handleWebSocketStatusChange,
      );

      // Message handler for WebSocket events (server-pushed)
      void handleMessage(Map<String, dynamic> json) {
        // Handle server-pushed events via OrderEnvelope
        try {
          // Check for ORDER_ERROR event first (before parsing enum)
          // This handles the case where the generated client doesn't have ORDER_ERROR yet
          final eventStr = json['e'] as String?;
          if (eventStr == 'ORDER_ERROR') {
            final payload = json['p'] as Map<String, dynamic>?;
            final error = payload?['error'] as Map<String, dynamic>?;
            final errorMessage =
                error?['message'] as String? ?? 'An unknown error occurred';
            final errorCode = error?['code'] as String? ?? 'UNKNOWN_ERROR';

            logger.e(
              '[DriverOrderCubit] - Order error received: $errorCode - $errorMessage',
            );

            // Emit error state for completion if the error is related to completion
            if (errorCode == 'COMPLETION_FAILED') {
              emit(
                state.copyWith(
                  completeTripResult: OperationResult.failed(
                    UnknownError(errorMessage),
                  ),
                ),
              );
            }
            return;
          }

          final envelope = OrderEnvelope.fromJson(json);
          _handleOrderEnvelopeEvent(envelope);
        } catch (e, st) {
          logger.e(
            '[DriverOrderCubit] Failed to parse OrderEnvelope',
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

  /// Handle order envelope events from WebSocket (server-pushed)
  /// All order updates are pushed by the server
  void _handleOrderEnvelopeEvent(OrderEnvelope envelope) {
    logger.d('[DriverOrderCubit] - Order WebSocket Message: $envelope');

    // Update version tracking for any event with order data
    final detail = envelope.p.detail;
    final order = detail?.order;
    if (order != null) {
      _lastKnownVersion = order.updatedAt.toIso8601String();

      emit(
        state.copyWith(
          fetchOrderResult: OperationResult.success(order),
          currentOrder: order,
          orderStatus: order.status,
        ),
      );
    }

    if (envelope.e == OrderEnvelopeEvent.ORDER_CANCELLED) {
      // Order was cancelled
      logger.i('[DriverOrderCubit] - Order cancelled');
      clearActiveOrder();
    }

    if (envelope.e == OrderEnvelopeEvent.ORDER_COMPLETED) {
      // Order completed - update state and cleanup
      _stopLocationTracking();
      final completedOrder = detail?.order;
      if (completedOrder != null) {
        emit(
          state.copyWith(
            completeTripResult: OperationResult.success(completedOrder),
            currentOrder: completedOrder,
            orderStatus: completedOrder.status,
          ),
        );
      }
      logger.i('[DriverOrderCubit] - Order completed confirmation received');
      // NOTE: Don't clear active order immediately - let the screen handle
      // navigation to review screen first. The screen will call clearActiveOrder()
      // after the driver submits the review or navigates away.
    }

    // Handle NEW_DATA event - server response with current order state
    if (envelope.e == OrderEnvelopeEvent.NEW_DATA) {
      _handleNewDataEvent(envelope);
    }

    // Handle NO_DATA event - server indicates no changes since lastKnownVersion
    if (envelope.e == OrderEnvelopeEvent.NO_DATA) {
      logger.d(
        '[DriverOrderCubit] NO_DATA received - order state is up to date',
      );
    }
  }

  /// Handle WebSocket status changes
  void _handleWebSocketStatusChange(WebSocketConnectionStatus status) {
    logger.d('[DriverOrderCubit] WebSocket status changed: $status');

    switch (status) {
      case WebSocketConnectionStatus.connected:
        logger.i('[DriverOrderCubit] WebSocket connected');
        // Request initial data when connected (replaces polling)
        final orderId = _currentOrderId;
        if (orderId != null) {
          _requestInitialData(orderId);
        }
      case WebSocketConnectionStatus.reconnecting:
        logger.d('[DriverOrderCubit] WebSocket reconnecting...');
      case WebSocketConnectionStatus.failed:
      case WebSocketConnectionStatus.disconnected:
        logger.w('[DriverOrderCubit] WebSocket failed/disconnected');
      case WebSocketConnectionStatus.connecting:
        // Do nothing
        break;
    }
  }

  /// Request initial order data from server via WebSocket
  /// Called when WebSocket connects to sync current order state
  void _requestInitialData(String orderId) {
    try {
      final envelope = OrderEnvelope(
        f: EnvelopeSender.c,
        t: EnvelopeSender.s,
        a: OrderEnvelopeAction.CHECK_NEW_DATA,
        p: OrderEnvelopePayload(
          syncRequest: OrderEnvelopePayloadSyncRequest(
            orderId: orderId,
            lastKnownVersion: _lastKnownVersion,
          ),
        ),
      );

      _webSocketService.send(orderId, jsonEncode(envelope.toJson()));
      logger.d(
        '[DriverOrderCubit] Sent CHECK_NEW_DATA request for order: $orderId',
      );
    } catch (e, st) {
      logger.e(
        '[DriverOrderCubit] Failed to send CHECK_NEW_DATA request',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Handle NEW_DATA event from server with current order state
  void _handleNewDataEvent(OrderEnvelope envelope) {
    final detail = envelope.p.detail;
    if (detail == null) {
      logger.w('[DriverOrderCubit] NEW_DATA event has no detail');
      return;
    }

    final order = detail.order;

    // Update version tracking
    _lastKnownVersion = order.updatedAt.toIso8601String();

    // Update state with current order data from server
    emit(
      state.copyWith(
        fetchOrderResult: OperationResult.success(order),
        currentOrder: order,
        orderStatus: order.status,
      ),
    );

    logger.i(
      '[DriverOrderCubit] Received NEW_DATA: order ${order.id}, '
      'status: ${order.status}',
    );
  }

  Future<void> teardownWebSocket() async {
    final orderId = _currentOrderId;
    if (orderId != null) {
      try {
        _webSocketService.removeStatusListener(orderId);
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
