import 'dart:async';
import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserOrderCubit extends BaseCubit<UserOrderState> {
  UserOrderCubit({
    required OrderRepository orderRepository,
    required WebSocketService webSocketService,
    required KeyValueService keyValueService,
  }) : _orderRepository = orderRepository,
       _webSocketService = webSocketService,
       _keyValueService = keyValueService,
       super(const UserOrderState());

  final OrderRepository _orderRepository;
  final WebSocketService _webSocketService;
  final KeyValueService _keyValueService;

  String? _paymentId;
  String? _orderId;

  /// Last known order version for tracking updates (used for debugging/logging)
  // ignore: unused_field
  String? _lastKnownVersion;

  Future<void> init() async {
    reset();
  }

  void reset() {
    emit(const UserOrderState());
  }

  @override
  Future<void> close() async {
    await teardownWebsocket();
    return super.close();
  }

  void setLocation({Place? pickup, Place? dropoff}) {
    emit(state.copyWith(pickupLocation: pickup, dropoffLocation: dropoff));
  }

  /// Check if there's an active order for the current user and recover the state
  /// This should be called when the app is reopened or after authentication
  /// Returns true if an active order was found and recovered
  Future<bool> recoverActiveOrder() async {
    try {
      return await taskManager.execute('UOC-rao', () async {
        logger.d('[UserOrderCubit] Checking for active order to recover...');

        final res = await _orderRepository.getActiveOrder();
        final activeOrder = res.data;

        if (activeOrder == null) {
          logger.d('[UserOrderCubit] No active order found');
          // Clear any stored active order ID and stale state
          await clearActiveOrder();
          return false;
        }

        // Check if the returned order is in a terminal state
        // This shouldn't happen normally, but handle it defensively
        if (_isTerminalStatus(activeOrder.order.status)) {
          logger.i(
            '[UserOrderCubit] Recovered order ${activeOrder.order.id} is in '
            'terminal state (${activeOrder.order.status}), clearing active order',
          );
          await clearActiveOrder();
          return false;
        }

        logger.i(
          '[UserOrderCubit] Found active order: ${activeOrder.order.id} '
          'with status: ${activeOrder.order.status}',
        );

        // Store the active order ID for future reference
        await _keyValueService.set(
          KeyValueKeys.activeOrderId,
          activeOrder.order.id,
        );

        _orderId = activeOrder.order.id;

        // Emit the recovered state
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(activeOrder.order),
            currentPayment: activeOrder.payment != null
                ? OperationResult.success(activeOrder.payment!)
                : const OperationResult.idle(),
            currentTransaction: activeOrder.transaction != null
                ? OperationResult.success(activeOrder.transaction!)
                : const OperationResult.idle(),
            currentAssignedDriver: activeOrder.driver != null
                ? OperationResult.success(activeOrder.driver)
                : const OperationResult.idle(),
          ),
        );

        // Setup WebSocket based on order status
        final pid = activeOrder.payment?.id;
        if (pid != null) await _setupPaymentWebsocket(paymentId: pid);

        // Setup live order WebSocket
        await _setupLiveOrderWebsocket(orderId: activeOrder.order.id);

        return true;
      });
    } on BaseError catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Error recovering active order: ${e.message}',
        error: e,
        stackTrace: st,
      );
      // Clear any stored active order ID on error
      await _keyValueService.remove(KeyValueKeys.activeOrderId);
      return false;
    }
  }

  /// Check if user has an active order without full recovery
  /// Returns the active order ID if found, null otherwise
  Future<String?> checkActiveOrderId() async {
    try {
      final res = await _orderRepository.getActiveOrder();
      return res.data?.order.id;
    } catch (e) {
      logger.e('[UserOrderCubit] - Error checking active order: $e');
      return null;
    }
  }

  /// Clear the active order state and stored ID
  Future<void> clearActiveOrder() async {
    await _keyValueService.remove(KeyValueKeys.activeOrderId);
    await teardownWebsocket();
    _orderId = null;
    _paymentId = null;
    emit(
      state.copyWith(
        currentOrder: const OperationResult.idle(),
        currentPayment: const OperationResult.idle(),
        currentTransaction: const OperationResult.idle(),
        currentAssignedDriver: const OperationResult.idle(),
      ),
    );
  }

  Future<void> list() async => await taskManager.execute('UOC-l1', () async {
    try {
      emit(state.copyWith(orderHistories: const OperationResult.loading()));

      final res = await _orderRepository.list(
        const ListOrderQuery(statuses: OrderStatus.values),
      );

      emit(
        state.copyWith(
          orderHistories: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(orderHistories: OperationResult.failed(e)));
    }
  });

  Future<void> maybeGet(String? id) async =>
      await taskManager.execute('UOC-mG1-$id', () async {
        if (id == null) return;

        try {
          emit(state.copyWith(selectedOrder: const OperationResult.loading()));

          final localList = state.orderHistories.value;
          final local = localList?.cast<Order?>().firstWhere(
            (v) => v?.id == id,
            orElse: () => null,
          );

          if (local != null) {
            emit(state.copyWith(selectedOrder: OperationResult.success(local)));
            return;
          }

          // Fetch from API
          final res = await _orderRepository.get(id);

          emit(
            state.copyWith(
              selectedOrder: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserOrderCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(selectedOrder: OperationResult.failed(e)));
        }
      });

  Future<void> estimate({
    required EstimateOrder req,
    required Place pickup,
    required Place dropoff,
  }) async => await taskManager.execute(
    'UOC-e1-${pickup.hashCode}-${dropoff.hashCode}',
    () async {
      try {
        emit(
          state.copyWith(
            estimateOrder: const OperationResult.loading(),
            pickupLocation: pickup,
            dropoffLocation: dropoff,
          ),
        );

        final res = await _orderRepository.estimate(req);

        emit(
          state.copyWith(
            estimateOrder: OperationResult.success(
              EstimateOrderResult(
                summary: res.data,
                pickup: pickup,
                dropoff: dropoff,
              ),
            ),
            pickupLocation: pickup,
            dropoffLocation: dropoff,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserOrderCubit] - Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(estimateOrder: OperationResult.failed(e)));
      }
    },
  );

  Future<PlaceOrderResponse?> placeOrder(
    Place pickup,
    Place dropoff,
    OrderType type,
    PaymentMethod method, {
    UserGender? gender,
    BankProvider? bankProvider,
    String? couponCode,
  }) async => await taskManager.execute('UOC-pO', () async {
    try {
      emit(
        state.copyWith(
          currentOrder: const OperationResult.loading(),
          currentPayment: const OperationResult.loading(),
          currentTransaction: const OperationResult.loading(),
          pickupLocation: pickup,
          dropoffLocation: dropoff,
        ),
      );

      final res = await _orderRepository.placeOrder(
        PlaceOrder(
          dropoffLocation: dropoff.toCoordinate(),
          pickupLocation: pickup.toCoordinate(),
          type: type,
          gender: gender,
          couponCode: couponCode,
          payment: PlaceOrderPayment(
            provider: PaymentProvider.MIDTRANS,
            method: method,
            bankProvider: bankProvider,
          ),
        ),
      );

      _orderId = res.data.order.id;
      _paymentId = res.data.payment.id;

      // For wallet payments that succeed immediately, skip payment WebSocket
      // and directly set up the order WebSocket for real-time updates.
      // For other payment methods (QRIS, BANK_TRANSFER), we need to wait for
      // payment confirmation via payment WebSocket before setting up order WebSocket.
      final isWalletPaymentSuccess =
          res.data.payment.method == PaymentMethod.wallet &&
          res.data.payment.status == TransactionStatus.SUCCESS;

      if (isWalletPaymentSuccess) {
        // Wallet payment is instant - set up order WebSocket directly
        await _setupLiveOrderWebsocket(orderId: res.data.order.id);
      } else {
        // Non-wallet payments need to wait for payment confirmation
        await _setupPaymentWebsocket(paymentId: res.data.payment.id);
      }

      emit(
        state.copyWith(
          currentOrder: OperationResult.success(res.data.order),
          currentPayment: OperationResult.success(res.data.payment),
          currentTransaction: OperationResult.success(res.data.transaction),
          pickupLocation: pickup,
          dropoffLocation: dropoff,
        ),
      );
      return res.data;
    } catch (e, st) {
      logger.e('[UserOrderCubit] - Error: $e', error: e, stackTrace: st);
      emit(
        state.copyWith(
          currentOrder: OperationResult.failed(
            e is BaseError ? e : UnknownError(e.toString()),
          ),
          currentPayment: OperationResult.failed(
            e is BaseError ? e : UnknownError(e.toString()),
          ),
          currentTransaction: OperationResult.failed(
            e is BaseError ? e : UnknownError(e.toString()),
          ),
        ),
      );
      return null;
    }
  });

  Future<void> _setupPaymentWebsocket({required String paymentId}) async {
    try {
      _paymentId = paymentId;
      Future<void> handleMessage(Map<String, dynamic> json) async {
        final data = PaymentEnvelope.fromJson(json);
        logger.d('Payment WebSocket Message: $data');

        if (data.e == PaymentEnvelopeEvent.PAYMENT_SUCCESS) {
          final payment = data.p.payment;
          final transaction = data.p.transaction;
          emit(
            state.copyWith(
              currentPayment: payment != null
                  ? OperationResult.success(payment)
                  : state.currentPayment,
              currentTransaction: transaction != null
                  ? OperationResult.success(transaction)
                  : state.currentTransaction,
            ),
          );

          await _webSocketService.disconnect(paymentId);

          // Connect to order WebSocket for real-time updates
          final orderId = _orderId;
          if (orderId != null) {
            await _setupLiveOrderWebsocket(orderId: orderId);
          }
        }

        if (data.e == PaymentEnvelopeEvent.PAYMENT_FAILED) {
          final payment = data.p.payment;
          final transaction = data.p.transaction;
          emit(
            state.copyWith(
              currentPayment: payment != null
                  ? OperationResult.success(payment)
                  : state.currentPayment,
              currentTransaction: transaction != null
                  ? OperationResult.success(transaction)
                  : state.currentTransaction,
            ),
          );
          emit(
            state.copyWith(
              currentPayment: OperationResult.failed(
                const UnknownError('Payment expired'),
              ),
            ),
          );
        }
      }

      await _webSocketService.connect(
        paymentId,
        '${UrlConstants.wsBaseUrl}/payment/$paymentId',
        onMessage: (msg) async {
          final json = (msg as String).parseJson();
          if (json is Map<String, dynamic>) await handleMessage(json);
        },
      );
    } catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Payment WebSocket error: $e',
        error: e,
        stackTrace: st,
      );
      emit(
        state.copyWith(
          currentPayment: OperationResult.failed(
            const UnknownError('Failed to connect to payment service'),
          ),
        ),
      );
    }
  }

  // ============================================================
  // WebSocket Real-time Updates
  // ============================================================

  /// Setup live order WebSocket connection
  /// Server pushes all updates via WebSocket events
  Future<void> _setupLiveOrderWebsocket({required String orderId}) async {
    try {
      _orderId = orderId;

      // Initialize version from current order if available
      final currentOrder = state.currentOrder.value;
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
          final data = OrderEnvelope.fromJson(json);
          _handleOrderEnvelopeEvent(data);
        } catch (e, st) {
          logger.e(
            '[UserOrderCubit] Failed to parse OrderEnvelope',
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

      logger.i('[UserOrderCubit] WebSocket connected for order: $orderId');
    } catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Live Order WebSocket error: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Handle OrderEnvelope events from WebSocket (server-pushed)
  /// All order updates are pushed by the server
  void _handleOrderEnvelopeEvent(OrderEnvelope data) {
    logger.d('Live Order WebSocket Message: $data');

    // Update version tracking for any event with order data
    final detail = data.p.detail;
    if (detail != null) {
      _lastKnownVersion = detail.order.updatedAt.toIso8601String();
    }

    if (data.e == OrderEnvelopeEvent.DRIVER_LOCATION_UPDATE) {
      final x = data.p.driverUpdateLocation?.x;
      final y = data.p.driverUpdateLocation?.y;
      final existingDriver = state.currentAssignedDriver.value;
      // Only update location if we have a valid assigned driver
      // Avoid using dummy driver as it has invalid userId
      if (x != null && y != null && existingDriver != null) {
        final updatedDriver = existingDriver.copyWith(
          currentLocation: Coordinate(x: x, y: y),
        );
        emit(
          state.copyWith(
            currentAssignedDriver: OperationResult.success(updatedDriver),
          ),
        );
      }
    }

    // Handle driver accepted event - driver has accepted the order
    // This provides instant UI update when a driver accepts
    if (data.e == OrderEnvelopeEvent.DRIVER_ACCEPTED) {
      final driverAssigned = data.p.driverAssigned;

      if (detail != null) {
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
            currentAssignedDriver: driverAssigned != null
                ? OperationResult.success(driverAssigned)
                : state.currentAssignedDriver,
          ),
        );
        logger.i(
          '[UserOrderCubit] Driver accepted order: ${detail.order.id}, '
          'driver: ${driverAssigned?.id}',
        );
      }
    }

    // Handle generic order status change events from REST API updates
    // This catches status changes made via REST API (e.g., driver updating status)
    if (data.e == OrderEnvelopeEvent.ORDER_STATUS_CHANGED) {
      if (detail != null) {
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
          ),
        );
        logger.i(
          '[UserOrderCubit] Order status changed: ${detail.order.id}, '
          'new status: ${detail.order.status}',
        );
      }
    }

    // Handle order completion - update order status to COMPLETED
    // and clear active order state
    if (data.e == OrderEnvelopeEvent.ORDER_COMPLETED) {
      if (detail != null) {
        // Emit completed order state so UI can react to completion
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
          ),
        );
        logger.i('[UserOrderCubit] Order completed: ${detail.order.id}');
      }
    }

    // Handle order cancellation events
    if (data.e == OrderEnvelopeEvent.ORDER_CANCELLED) {
      if (detail != null) {
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
          ),
        );
        logger.i(
          '[UserOrderCubit] Order cancelled: ${detail.order.id}, '
          'reason: ${data.p.cancelReason}',
        );
      }
    }

    // Handle no-show event (driver reported user not present)
    if (data.e == OrderEnvelopeEvent.ORDER_NO_SHOW) {
      if (detail != null) {
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
          ),
        );
        logger.i(
          '[UserOrderCubit] No-show reported for order: ${detail.order.id}',
        );
      }
    }

    // Handle driver cancelled and rematching event
    if (data.e == OrderEnvelopeEvent.DRIVER_CANCELLED_REMATCHING) {
      final retryInfo = data.p.retryInfo;
      if (retryInfo != null) {
        // Clear current driver and update order to MATCHING status
        emit(
          state.copyWith(currentAssignedDriver: const OperationResult.idle()),
        );
        logger.i(
          '[UserOrderCubit] Driver cancelled, rematching: ${retryInfo.orderId}',
        );
      }
    }

    // Handle merchant accepted event (FOOD orders)
    if (data.e == OrderEnvelopeEvent.MERCHANT_ACCEPTED) {
      if (detail != null) {
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
          ),
        );
        logger.i(
          '[UserOrderCubit] Merchant accepted order: ${detail.order.id}',
        );
      }
    }

    // Handle merchant preparing event (FOOD orders)
    if (data.e == OrderEnvelopeEvent.MERCHANT_PREPARING) {
      if (detail != null) {
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
          ),
        );
        logger.i(
          '[UserOrderCubit] Merchant preparing order: ${detail.order.id}',
        );
      }
    }

    // Handle merchant ready event (FOOD orders - triggers driver matching)
    if (data.e == OrderEnvelopeEvent.MERCHANT_READY) {
      if (detail != null) {
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
          ),
        );
        logger.i(
          '[UserOrderCubit] Merchant ready, driver matching started: ${detail.order.id}',
        );
      }
    }

    // Handle merchant rejected event (FOOD orders)
    if (data.e == OrderEnvelopeEvent.MERCHANT_REJECTED) {
      if (detail != null) {
        emit(
          state.copyWith(
            currentOrder: OperationResult.success(detail.order),
            currentPayment: detail.payment != null
                ? OperationResult.success(detail.payment!)
                : state.currentPayment,
            currentTransaction: detail.transaction != null
                ? OperationResult.success(detail.transaction!)
                : state.currentTransaction,
          ),
        );
        logger.i(
          '[UserOrderCubit] Merchant rejected order: ${detail.order.id}, '
          'reason: ${data.p.cancelReason}',
        );
      }
    }

    // Handle NEW_DATA event - server response with current order state
    if (data.e == OrderEnvelopeEvent.NEW_DATA) {
      _handleNewDataEvent(data);
    }

    // Handle NO_DATA event - server indicates no changes since lastKnownVersion
    if (data.e == OrderEnvelopeEvent.NO_DATA) {
      logger.d('[UserOrderCubit] NO_DATA received - order state is up to date');
    }
  }

  /// Handle WebSocket connection status changes
  void _handleWebSocketStatusChange(WebSocketConnectionStatus status) {
    final orderId = _orderId;
    if (orderId == null) return;

    logger.d('[UserOrderCubit] WebSocket status changed: $status');

    switch (status) {
      case WebSocketConnectionStatus.connected:
        logger.i('[UserOrderCubit] WebSocket connected');
        // Request initial data when connected (replaces polling)
        _requestInitialData(orderId);
      case WebSocketConnectionStatus.reconnecting:
      case WebSocketConnectionStatus.connecting:
        logger.d('[UserOrderCubit] WebSocket reconnecting...');
      case WebSocketConnectionStatus.failed:
      case WebSocketConnectionStatus.disconnected:
        logger.w('[UserOrderCubit] WebSocket failed/disconnected');
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
        '[UserOrderCubit] Sent CHECK_NEW_DATA request for order: $orderId',
      );
    } catch (e, st) {
      logger.e(
        '[UserOrderCubit] Failed to send CHECK_NEW_DATA request',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Handle NEW_DATA event from server with current order state
  void _handleNewDataEvent(OrderEnvelope data) {
    final detail = data.p.detail;
    if (detail == null) {
      logger.w('[UserOrderCubit] NEW_DATA event has no detail');
      return;
    }

    // Update version tracking
    _lastKnownVersion = detail.order.updatedAt.toIso8601String();

    // Update state with current order data from server
    emit(
      state.copyWith(
        currentOrder: OperationResult.success(detail.order),
        currentPayment: detail.payment != null
            ? OperationResult.success(detail.payment!)
            : state.currentPayment,
        currentTransaction: detail.transaction != null
            ? OperationResult.success(detail.transaction!)
            : state.currentTransaction,
        currentAssignedDriver: data.p.driverAssigned != null
            ? OperationResult.success(data.p.driverAssigned)
            : state.currentAssignedDriver,
      ),
    );

    logger.i(
      '[UserOrderCubit] Received NEW_DATA: order ${detail.order.id}, '
      'status: ${detail.order.status}',
    );
  }

  Future<void> teardownWebsocket() async {
    _lastKnownVersion = null;

    final futures = [_webSocketService.disconnect('driver-pool')];
    final orderId = _orderId;
    if (orderId != null) {
      _webSocketService.removeStatusListener(orderId);
      futures.add(_webSocketService.disconnect(orderId));
    }
    final paymentId = _paymentId;
    if (paymentId != null) {
      futures.add(_webSocketService.disconnect(paymentId));
    }

    await Future.wait(futures);
  }

  /// Check if order status is terminal (completed, cancelled, etc.)
  bool _isTerminalStatus(OrderStatus status) {
    return [
      OrderStatus.COMPLETED,
      OrderStatus.CANCELLED_BY_USER,
      OrderStatus.CANCELLED_BY_DRIVER,
      OrderStatus.CANCELLED_BY_SYSTEM,
    ].contains(status);
  }

  /// Fetch active order once without starting continuous polling
  /// Useful for manual refresh or initial load
  Future<void> fetchActiveOrder() async {
    try {
      logger.d('[UserOrderCubit] Fetching active order...');

      final res = await _orderRepository.getActiveOrder();
      final activeOrder = res.data;

      if (activeOrder == null) {
        logger.d('[UserOrderCubit] No active order found');
        // Clear any stale active order state if server says no active order
        if (state.currentOrder.value != null) {
          logger.i('[UserOrderCubit] Clearing stale active order state');
          await clearActiveOrder();
        }
        return;
      }

      // Check if the returned order is in a terminal state
      // This shouldn't happen normally, but handle it defensively
      if (_isTerminalStatus(activeOrder.order.status)) {
        logger.i(
          '[UserOrderCubit] Fetched order ${activeOrder.order.id} is in '
          'terminal state (${activeOrder.order.status}), clearing active order',
        );
        await clearActiveOrder();
        return;
      }

      logger.i(
        '[UserOrderCubit] Found active order: ${activeOrder.order.id} '
        'with status: ${activeOrder.order.status}',
      );

      _orderId = activeOrder.order.id;

      emit(
        state.copyWith(
          currentOrder: OperationResult.success(activeOrder.order),
          currentPayment: activeOrder.payment != null
              ? OperationResult.success(activeOrder.payment!)
              : const OperationResult.idle(),
          currentTransaction: activeOrder.transaction != null
              ? OperationResult.success(activeOrder.transaction!)
              : const OperationResult.idle(),
          currentAssignedDriver: activeOrder.driver != null
              ? OperationResult.success(activeOrder.driver)
              : const OperationResult.idle(),
        ),
      );
    } catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Error fetching active order: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  // ==================== Scheduled Orders ====================

  /// List all scheduled orders for the current user
  Future<void> listScheduledOrders() async => await taskManager.execute(
    'UOC-lso',
    () async {
      try {
        emit(state.copyWith(scheduledOrders: const OperationResult.loading()));

        final res = await _orderRepository.listScheduledOrders(
          const ListOrderQuery(statuses: [OrderStatus.SCHEDULED]),
        );

        emit(
          state.copyWith(
            scheduledOrders: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserOrderCubit] - Error listing scheduled orders: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(scheduledOrders: OperationResult.failed(e)));
      }
    },
  );

  /// Place a new scheduled order
  Future<PlaceScheduledOrderResponse?> placeScheduledOrder(
    Place pickup,
    Place dropoff,
    OrderType type,
    PaymentMethod method,
    DateTime scheduledAt, {
    UserGender? gender,
    BankProvider? bankProvider,
    String? couponCode,
  }) async => await taskManager.execute('UOC-pso', () async {
    try {
      emit(
        state.copyWith(
          currentOrder: const OperationResult.loading(),
          currentPayment: const OperationResult.loading(),
          currentTransaction: const OperationResult.loading(),
        ),
      );

      final res = await _orderRepository.placeScheduledOrder(
        PlaceScheduledOrder(
          dropoffLocation: dropoff.toCoordinate(),
          pickupLocation: pickup.toCoordinate(),
          type: type,
          scheduledAt: scheduledAt,
          gender: gender,
          couponCode: couponCode,
          payment: PlaceOrderPayment(
            provider: PaymentProvider.MIDTRANS,
            method: method,
            bankProvider: bankProvider,
          ),
        ),
      );

      _orderId = res.data.order.id;
      _paymentId = res.data.payment.id;
      await _setupPaymentWebsocket(paymentId: res.data.payment.id);

      emit(
        state.copyWith(
          currentOrder: OperationResult.success(res.data.order),
          currentPayment: OperationResult.success(res.data.payment),
          currentTransaction: OperationResult.success(res.data.transaction),
        ),
      );

      return res.data;
    } on BaseError catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Error placing scheduled order: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(
        state.copyWith(
          currentOrder: OperationResult.failed(e),
          currentPayment: OperationResult.failed(e),
          currentTransaction: OperationResult.failed(e),
        ),
      );
      return null;
    }
  });

  /// Update (reschedule) an existing scheduled order
  Future<Order?> updateScheduledOrder(
    String orderId,
    DateTime newScheduledAt,
  ) async => await taskManager.execute('UOC-uso-$orderId', () async {
    try {
      emit(
        state.copyWith(selectedScheduledOrder: const OperationResult.loading()),
      );

      final res = await _orderRepository.updateScheduledOrder(
        orderId,
        UpdateScheduledOrder(scheduledAt: newScheduledAt),
      );

      // Update the scheduled orders list with the updated order
      final currentList = state.scheduledOrders.value;
      final updatedList = currentList?.map((order) {
        if (order.id == orderId) {
          return res.data;
        }
        return order;
      }).toList();

      emit(
        state.copyWith(
          scheduledOrders: updatedList != null
              ? OperationResult.success(updatedList, message: res.message)
              : state.scheduledOrders,
          selectedScheduledOrder: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );

      return res.data;
    } on BaseError catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Error updating scheduled order: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(selectedScheduledOrder: OperationResult.failed(e)));
      return null;
    }
  });

  /// Cancel a scheduled order
  Future<Order?> cancelScheduledOrder(
    String orderId, {
    String? reason,
  }) async => await taskManager.execute('UOC-cso-$orderId', () async {
    try {
      emit(
        state.copyWith(selectedScheduledOrder: const OperationResult.loading()),
      );

      final res = await _orderRepository.cancelScheduledOrder(
        orderId,
        reason: reason,
      );

      // Remove cancelled order from the scheduled orders list
      final currentList = state.scheduledOrders.value;
      final updatedList = currentList
          ?.where((order) => order.id != orderId)
          .toList();

      emit(
        state.copyWith(
          scheduledOrders: updatedList != null
              ? OperationResult.success(updatedList, message: res.message)
              : state.scheduledOrders,
          selectedScheduledOrder: const OperationResult.idle(),
        ),
      );

      return res.data;
    } on BaseError catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Error cancelling scheduled order: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(selectedScheduledOrder: OperationResult.failed(e)));
      return null;
    }
  });

  /// Select a scheduled order for viewing/editing
  void selectScheduledOrder(Order? order) {
    if (order != null) {
      emit(
        state.copyWith(selectedScheduledOrder: OperationResult.success(order)),
      );
    } else {
      emit(
        state.copyWith(selectedScheduledOrder: const OperationResult.idle()),
      );
    }
  }

  /// Clear the selected scheduled order
  void clearSelectedScheduledOrder() {
    emit(state.copyWith(selectedScheduledOrder: const OperationResult.idle()));
  }

  /// Cancel an active order (non-scheduled)
  /// POST /api/orders/{id}/cancel
  Future<Order?> cancelOrder(String orderId, {String? reason}) async =>
      await taskManager.execute('UOC-co-$orderId', () async {
        try {
          emit(state.copyWith(selectedOrder: const OperationResult.loading()));

          final res = await _orderRepository.cancelOrder(
            orderId,
            reason: reason,
          );

          // Update the order histories list with the cancelled order
          final currentList = state.orderHistories.value;
          final updatedList = currentList?.map((order) {
            if (order.id == orderId) {
              return res.data;
            }
            return order;
          }).toList();

          emit(
            state.copyWith(
              orderHistories: updatedList != null
                  ? OperationResult.success(updatedList, message: res.message)
                  : state.orderHistories,
              selectedOrder: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );

          return res.data;
        } on BaseError catch (e, st) {
          logger.e(
            '[UserOrderCubit] - Error cancelling order: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(selectedOrder: OperationResult.failed(e)));
          return null;
        }
      });
}
