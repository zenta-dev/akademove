import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserOrderCubit extends BaseCubit<UserOrderState> {
  UserOrderCubit({
    required OrderRepository orderRepository,
    required WebSocketService webSocketService,
  }) : _orderRepository = orderRepository,
       _webSocketService = webSocketService,
       super(const UserOrderState());

  final OrderRepository _orderRepository;
  final WebSocketService _webSocketService;

  String? _paymentId;
  String? _orderId;

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
    required OrderEstimateRequest req,
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
      await _setupPaymentWebsocket(paymentId: res.data.payment.id);
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
    } on BaseError catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Error: ${e.message}',
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

  Future<void> _setupPaymentWebsocket({required String paymentId}) async {
    try {
      _paymentId = paymentId;
      Future<void> handleMessage(Map<String, dynamic> json) async {
        final data = PaymentEnvelope.fromJson(json);
        logger.d('Payment WebSocket Message: $data');

        if (data.e == PaymentEnvelopeEvent.PAYMENT_SUCCESS) {
          emit(
            state.copyWith(
              currentPayment: OperationResult.success(data.p.payment),
              currentTransaction: OperationResult.success(data.p.transaction),
            ),
          );

          await _webSocketService.disconnect(paymentId);
          await _setupFindDriverWebsocket();
        }

        if (data.e == PaymentEnvelopeEvent.PAYMENT_FAILED) {
          emit(
            state.copyWith(
              currentPayment: OperationResult.success(data.p.payment),
              currentTransaction: OperationResult.success(data.p.transaction),
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

  Future<void> _setupFindDriverWebsocket() async {
    try {
      const driverPool = 'driver-pool';
      Future<void> handleMessage(Map<String, dynamic> json) async {
        final data = OrderEnvelope.fromJson(json);
        logger.d('Driver Pool WebSocket Message: $data');

        if (data.e == OrderEnvelopeEvent.MATCHING &&
            state.currentOrder.value?.id == data.p.detail?.order.id) {
          final detail = data.p.detail;
          final payment = detail?.payment;
          final transaction = detail?.transaction;
          if (detail != null && payment != null && transaction != null) {
            emit(
              state.copyWith(
                currentOrder: OperationResult.success(detail.order),
                currentPayment: OperationResult.success(payment),
                currentTransaction: OperationResult.success(transaction),
              ),
            );
          }
        }

        if (data.e == OrderEnvelopeEvent.CANCELED) {
          final detail = data.p.detail;
          final payment = detail?.payment;
          final transaction = detail?.transaction;
          if (detail != null && payment != null && transaction != null) {
            emit(
              state.copyWith(
                currentOrder: OperationResult.success(detail.order),
                currentPayment: OperationResult.success(payment),
                currentTransaction: OperationResult.success(transaction),
              ),
            );
          }
          emit(
            state.copyWith(
              currentOrder: OperationResult.failed(
                UnknownError(data.p.cancelReason ?? 'Order cancelled'),
              ),
            ),
          );
        }

        if (data.e == OrderEnvelopeEvent.DRIVER_ACCEPTED) {
          final detail = data.p.detail;
          final payment = detail?.payment;
          final transaction = detail?.transaction;
          if (detail != null && payment != null && transaction != null) {
            emit(
              state.copyWith(
                currentOrder: OperationResult.success(detail.order),
                currentPayment: OperationResult.success(payment),
                currentTransaction: OperationResult.success(transaction),
                currentAssignedDriver: OperationResult.success(
                  data.p.driverAssigned,
                ),
              ),
            );
          }

          await _webSocketService.disconnect(driverPool);
          final orderId = _orderId;
          if (orderId != null) {
            await _setupLiveOrderWebsocket(orderId: orderId);
          }
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
    } catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Driver Pool WebSocket error: $e',
        error: e,
        stackTrace: st,
      );
      emit(
        state.copyWith(
          currentAssignedDriver: OperationResult.failed(
            const UnknownError('Failed to connect to driver service'),
          ),
        ),
      );
    }
  }

  Future<void> _setupLiveOrderWebsocket({required String orderId}) async {
    try {
      _orderId = orderId;
      void handleMessage(Map<String, dynamic> json) {
        final data = OrderEnvelope.fromJson(json);
        logger.d('Live Order WebSocket Message: $data');

        if (data.e == OrderEnvelopeEvent.DRIVER_LOCATION_UPDATE) {
          final x = data.p.driverUpdateLocation?.x;
          final y = data.p.driverUpdateLocation?.y;
          var driver = state.currentAssignedDriver.value ?? dummyDriver;
          if (x != null && y != null) {
            driver = driver.copyWith(
              currentLocation: Coordinate(x: x, y: y),
            );
            emit(
              state.copyWith(
                currentAssignedDriver: OperationResult.success(driver),
              ),
            );
          }
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
    } catch (e, st) {
      logger.e(
        '[UserOrderCubit] - Live Order WebSocket error: $e',
        error: e,
        stackTrace: st,
      );
      // Don't emit failure here as it would disrupt the active trip
      // Just log the error and let the app continue
    }
  }

  Future<void> teardownWebsocket() async {
    final futures = [_webSocketService.disconnect('driver-pool')];
    final orderId = _orderId;
    if (orderId != null) {
      futures.add(_webSocketService.disconnect(orderId));
    }
    final paymentId = _paymentId;
    if (paymentId != null) {
      futures.add(_webSocketService.disconnect(paymentId));
    }

    await Future.wait(futures);
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
}
