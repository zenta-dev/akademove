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

  /// WebSocket sync service for CHECK_NEW_DATA pattern (replaces Timer polling)
  WebSocketSyncService<Map<String, Object?>>? _wsSyncService;

  /// Last known order version for WebSocket sync
  String? _lastKnownVersion;

  /// Timer for polling active order updates (fallback only)
  Timer? _pollingTimer;

  /// WebSocket sync interval in seconds
  static const int _wsSyncIntervalSeconds = 3;

  /// Max NO_DATA count before HTTP fallback
  static const int _maxNoDataCount = 5;

  /// Default polling interval in seconds (fallback)
  static const int _defaultPollingIntervalSeconds = 5;

  /// Whether we're using polling as a fallback due to WebSocket issues
  bool _isPollingFallback = false;

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
    await _setupOrderWebSocketWithSync(order.id);
    _startLocationTracking();
  }

  void reset() {
    _stopLocationTracking();
    _stopPolling();
    _wsSyncService?.stop();
    _wsSyncService = null;
    _currentOrderId = null;
    _currentDriverId = null;
    _lastKnownVersion = null;
    _isPollingFallback = false;
    emit(const DriverOrderState());
  }

  @override
  Future<void> close() async {
    await teardownWebSocket();
    _stopLocationTracking();
    _stopPolling();
    _wsSyncService?.dispose();
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

        // Setup WebSocket with sync and start location tracking
        await _setupOrderWebSocketWithSync(order.id);
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
    _stopPolling();
    _wsSyncService?.stop();
    _wsSyncService = null;
    await teardownWebSocket();
    _stopLocationTracking();
    _currentOrderId = null;
    _currentDriverId = null;
    _lastKnownVersion = null;
    _isPollingFallback = false;
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

          await _setupOrderWebSocketWithSync(orderId);
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
      return;
    }

    try {
      emit(state.copyWith(completeTripResult: const OperationResult.loading()));

      // Get current location for the DONE payload
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        logger.w('[DriverOrderCubit] - Location permission denied');
        emit(
          state.copyWith(
            completeTripResult: OperationResult.failed(
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

      // Update status via API first
      final res = await _orderRepository.update(
        orderId,
        const UpdateOrder(status: OrderStatus.COMPLETED),
      );

      // Send DONE action via WebSocket
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

      // Update local state with result
      emit(
        state.copyWith(
          completeTripResult: OperationResult.success(res.data),
          currentOrder: res.data,
          orderStatus: res.data.status,
        ),
      );

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
    // Skip update if location hasn't changed (deduplication to prevent DB heating)
    final last = _lastLocation;
    if (last != null && last.x == coordinate.x && last.y == coordinate.y) {
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
          a: OrderEnvelopeAction.UPDATE_LOCATION,
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
  // WebSocket with Sync Service
  // ============================================================

  /// Setup order WebSocket with WebSocket-based sync (CHECK_NEW_DATA pattern)
  /// Uses HTTP fallback after 5 consecutive NO_DATA responses
  Future<void> _setupOrderWebSocketWithSync(String orderId) async {
    try {
      _currentOrderId = orderId;

      // Setup WebSocket status listener for automatic fallback
      _webSocketService.setStatusListener(
        orderId,
        _handleWebSocketStatusChange,
      );

      // Create WebSocket sync service for CHECK_NEW_DATA pattern
      _wsSyncService = WebSocketSyncService<Map<String, Object?>>(
        webSocketService: _webSocketService,
        connectionKey: orderId,
        config: WebSocketSyncConfig(
          syncIntervalSeconds: _wsSyncIntervalSeconds,
          maxNoDataCount: _maxNoDataCount,
        ),
        buildCheckNewDataMessage: () => {
          'a': 'CHECK_NEW_DATA',
          'f': 'c',
          't': 's',
          'p': {
            'syncRequest': {
              'orderId': orderId,
              'lastKnownVersion': _lastKnownVersion,
            },
          },
        },
        isNewDataEvent: (data) => data['e'] == 'NEW_DATA',
        isNoDataEvent: (data) => data['e'] == 'NO_DATA',
        parseNewData: (data) => data,
        onNewData: _handleNewDataFromSync,
        onHttpFallback: _pollActiveOrder,
        onVersionUpdate: (version) => _lastKnownVersion = version,
      );

      // Custom message handler that handles both sync events and regular events
      void handleMessage(Map<String, dynamic> json) {
        final eventType = json['e'] as String?;

        // Handle NEW_DATA and NO_DATA via sync service (skip normal parsing)
        if (eventType == 'NEW_DATA' || eventType == 'NO_DATA') {
          return;
        }

        // Handle all other events via normal OrderEnvelope parsing
        try {
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

      // Start WebSocket sync after connection is established
      _wsSyncService?.start();

      // Initialize version from current order if available
      final currentOrder = state.currentOrder;
      if (currentOrder != null) {
        _lastKnownVersion = currentOrder.updatedAt.toIso8601String();
        _wsSyncService?.setLastKnownVersion(_lastKnownVersion);
      }

      logger.i('[DriverOrderCubit] - Connected to order WebSocket: $orderId');
    } catch (e, st) {
      logger.e(
        '[DriverOrderCubit] - Error connecting to order WebSocket: $e',
        error: e,
        stackTrace: st,
      );
      // Fallback to HTTP polling on WebSocket failure
      _startPollingFallback();
    }
  }

  /// Handle NEW_DATA event from WebSocket sync service
  void _handleNewDataFromSync(Map<String, Object?> data) {
    try {
      final payload = data['p'] as Map<String, Object?>?;
      final detail = payload?['detail'] as Map<String, Object?>?;

      if (detail == null) {
        logger.d('[DriverOrderCubit] NEW_DATA received but no detail');
        return;
      }

      // Parse order from detail
      final orderJson = detail['order'] as Map<String, dynamic>?;

      if (orderJson == null) {
        logger.d('[DriverOrderCubit] NEW_DATA has no order in detail');
        return;
      }

      final order = Order.fromJson(orderJson);

      // Check if we actually have new data
      final currentOrder = state.currentOrder;
      final hasChanges =
          currentOrder == null ||
          currentOrder.id != order.id ||
          currentOrder.status != order.status ||
          currentOrder.updatedAt != order.updatedAt;

      if (hasChanges) {
        logger.d(
          '[DriverOrderCubit] NEW_DATA sync: Order updated - '
          'status: ${order.status}',
        );

        emit(
          state.copyWith(
            fetchOrderResult: OperationResult.success(order),
            currentOrder: order,
            orderStatus: order.status,
          ),
        );

        // Update version for next sync
        _lastKnownVersion = order.updatedAt.toIso8601String();
        _wsSyncService?.setLastKnownVersion(_lastKnownVersion);

        // Check if order is in terminal state
        if (_isTerminalStatus(order.status)) {
          logger.i(
            '[DriverOrderCubit] Sync: Order in terminal state (${order.status}), '
            'clearing active order',
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!isClosed) {
              clearActiveOrder();
            }
          });
        }
      }
    } catch (e, st) {
      logger.e(
        '[DriverOrderCubit] Failed to handle NEW_DATA',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Handle order envelope events from WebSocket
  void _handleOrderEnvelopeEvent(OrderEnvelope envelope) {
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

      // Update version for sync
      _lastKnownVersion = order.updatedAt.toIso8601String();
      _wsSyncService?.setLastKnownVersion(_lastKnownVersion);
    }

    if (envelope.e == OrderEnvelopeEvent.CANCELED) {
      // Order was cancelled
      logger.i('[DriverOrderCubit] - Order cancelled');
      clearActiveOrder();
    }

    if (envelope.e == OrderEnvelopeEvent.COMPLETED) {
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
      // Clear active order after completion
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!isClosed) {
          clearActiveOrder();
        }
      });
    }
  }

  /// Handle WebSocket status changes for automatic fallback
  void _handleWebSocketStatusChange(WebSocketConnectionStatus status) {
    logger.d('[DriverOrderCubit] WebSocket status changed: $status');

    switch (status) {
      case WebSocketConnectionStatus.connected:
        // WebSocket reconnected, restart sync and stop polling fallback
        if (_isPollingFallback) {
          logger.i(
            '[DriverOrderCubit] WebSocket connected, stopping HTTP fallback',
          );
          _stopPolling();
          _isPollingFallback = false;
          _wsSyncService?.resetNoDataCounter();
          _wsSyncService?.start();
        }
      case WebSocketConnectionStatus.reconnecting:
        logger.d(
          '[DriverOrderCubit] WebSocket reconnecting, sync will fallback if needed',
        );
      case WebSocketConnectionStatus.failed:
      case WebSocketConnectionStatus.disconnected:
        if (!_isPollingFallback && _currentOrderId != null) {
          logger.i(
            '[DriverOrderCubit] WebSocket failed/disconnected, '
            'starting HTTP fallback',
          );
          _startPollingFallback();
        }
      case WebSocketConnectionStatus.connecting:
        // Do nothing
        break;
    }
  }

  // ============================================================
  // HTTP Polling Fallback
  // ============================================================

  /// Start polling as fallback when WebSocket is unhealthy
  void _startPollingFallback() {
    if (_isPollingFallback) return;

    _isPollingFallback = true;
    _startPolling(intervalSeconds: _defaultPollingIntervalSeconds);
  }

  /// Start polling for active order updates (fallback mechanism)
  void _startPolling({int intervalSeconds = _defaultPollingIntervalSeconds}) {
    if (state.isPolling) {
      logger.d('[DriverOrderCubit] Polling already active, skipping start');
      return;
    }

    logger.i(
      '[DriverOrderCubit] Starting polling with ${intervalSeconds}s interval',
    );
    emit(state.copyWith(isPolling: true));

    _pollingTimer = Timer.periodic(
      Duration(seconds: intervalSeconds),
      (_) => _pollActiveOrder(),
    );

    // Also fetch immediately on start
    _pollActiveOrder();
  }

  /// Stop polling for active order updates
  void _stopPolling() {
    if (!state.isPolling && _pollingTimer == null) {
      return;
    }

    logger.i('[DriverOrderCubit] Stopping polling');
    _pollingTimer?.cancel();
    _pollingTimer = null;
    emit(state.copyWith(isPolling: false));
  }

  /// Internal method to poll the active order
  Future<void> _pollActiveOrder() async {
    try {
      final res = await _orderRepository.getActiveOrder();
      final activeOrder = res.data;

      if (activeOrder == null) {
        // No active order, stop polling and clear state
        logger.d('[DriverOrderCubit] Poll: No active order found');
        await clearActiveOrder();
        return;
      }

      final order = activeOrder.order;
      final currentOrder = state.currentOrder;

      // Check if order status changed or if we have new data
      final hasChanges =
          currentOrder == null ||
          currentOrder.id != order.id ||
          currentOrder.status != order.status ||
          currentOrder.updatedAt != order.updatedAt;

      if (hasChanges) {
        logger.d(
          '[DriverOrderCubit] Poll: Order updated - status: ${order.status}',
        );

        emit(
          state.copyWith(
            fetchOrderResult: OperationResult.success(order),
            currentOrder: order,
            orderStatus: order.status,
          ),
        );

        // Update version for sync
        _lastKnownVersion = order.updatedAt.toIso8601String();
        _wsSyncService?.setLastKnownVersion(_lastKnownVersion);
      }

      // Check if order is in terminal state
      if (_isTerminalStatus(order.status)) {
        logger.i(
          '[DriverOrderCubit] Poll: Order in terminal state (${order.status}), '
          'clearing active order',
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!isClosed) {
            clearActiveOrder();
          }
        });
      }
    } catch (e, st) {
      logger.e('[DriverOrderCubit] Poll error: $e', error: e, stackTrace: st);
    }
  }

  Future<void> teardownWebSocket() async {
    final orderId = _currentOrderId;
    _wsSyncService?.stop();
    _wsSyncService = null;
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
