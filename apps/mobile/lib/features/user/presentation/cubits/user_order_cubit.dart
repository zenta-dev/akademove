import 'dart:async';

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

  /// Timer for polling active order updates
  Timer? _pollingTimer;

  /// Default polling interval in seconds
  static const int _defaultPollingIntervalSeconds = 5;

  Future<void> init() async {
    reset();
  }

  void reset() {
    emit(const UserOrderState());
  }

  @override
  Future<void> close() async {
    stopPolling();
    await teardownWebsocket();
    return super.close();
  }

  void setLocation({Place? pickup, Place? dropoff}) {
    emit(state.copyWith(pickupLocation: pickup, dropoffLocation: dropoff));
  }

  /// Check if there's an active order for the current user and recover the state
  /// This should be called when the app is reopened or after authentication
  /// Returns true if an active order was found and recovered
  // Future<bool> recoverActiveOrder() async {
  //   try {
  //     return await taskManager.execute('UOC-rao', () async {
  //       logger.d('[UserOrderCubit] Checking for active order to recover...');

  //       final res = await _orderRepository.getActiveOrder();
  //       final activeOrder = res.data;

  //       if (activeOrder == null) {
  //         logger.d('[UserOrderCubit] No active order found');
  //         // Clear any stored active order ID
  //         await _keyValueService.remove(KeyValueKeys.activeOrderId);
  //         return false;
  //       }

  //       logger.i(
  //         '[UserOrderCubit] Found active order: ${activeOrder.order.id} '
  //         'with status: ${activeOrder.order.status}',
  //       );

  //       // Store the active order ID for future reference
  //       await _keyValueService.set(
  //         KeyValueKeys.activeOrderId,
  //         activeOrder.order.id,
  //       );

  //       _orderId = activeOrder.order.id;

  //       // Emit the recovered state
  //       emit(
  //         state.copyWith(
  //           currentOrder: OperationResult.success(activeOrder.order),
  //           currentPayment: activeOrder.payment != null
  //               ? OperationResult.success(activeOrder.payment!)
  //               : const OperationResult.idle(),
  //           currentTransaction: activeOrder.transaction != null
  //               ? OperationResult.success(activeOrder.transaction!)
  //               : const OperationResult.idle(),
  //           currentAssignedDriver: activeOrder.driver != null
  //               ? OperationResult.success(activeOrder.driver)
  //               : const OperationResult.idle(),
  //         ),
  //       );

  //       // Setup appropriate WebSocket connections based on order status
  //       final status = activeOrder.order.status;
  //       final orderType = activeOrder.order.type;
  //       final paymentStatus = activeOrder.payment?.status;

  //       // if (status == OrderStatus.REQUESTED) {
  //       //   // For FOOD orders with successful payment, connect to order WebSocket
  //       //   // to receive merchant updates (ACCEPTED, PREPARING, READY)
  //       //   if (orderType == OrderType.FOOD &&
  //       //       paymentStatus == TransactionStatus.SUCCESS) {
  //       //     await _setupLiveOrderWebsocket(orderId: activeOrder.order.id);
  //       //   } else if (activeOrder.payment != null) {
  //       //     // Order is waiting for payment, setup payment WebSocket
  //       //     _paymentId = activeOrder.payment!.id;
  //       //   }
  //       // } else if (status == OrderStatus.MATCHING) {
  //       //   // Order is waiting for driver, setup driver pool WebSocket
  //       //   // await _setupFindDriverWebsocket();
  //       // } else if ([
  //       //   OrderStatus.ACCEPTED,
  //       //   OrderStatus.PREPARING,
  //       //   OrderStatus.READY_FOR_PICKUP,
  //       //   OrderStatus.ARRIVING,
  //       //   OrderStatus.IN_TRIP,
  //       // ].contains(status)) {
  //       //   // Order has a driver, setup live order WebSocket
  //       // }

  //       final pid = activeOrder.payment?.id;
  //       if (pid != null) await _setupPaymentWebsocket(paymentId: pid);
  //       startPolling();
  //       await _setupLiveOrderWebsocket(orderId: activeOrder.order.id);

  //       return true;
  //     });
  //   } on BaseError catch (e, st) {
  //     logger.e(
  //       '[UserOrderCubit] - Error recovering active order: ${e.message}',
  //       error: e,
  //       stackTrace: st,
  //     );
  //     // Clear any stored active order ID on error
  //     await _keyValueService.remove(KeyValueKeys.activeOrderId);
  //     return false;
  //   }
  // }

  /// Check if user has an active order without full recovery
  /// Returns the active order ID if found, null otherwise
  // Future<String?> checkActiveOrderId() async {
  //   try {
  //     final res = await _orderRepository.getActiveOrder();
  //     return res.data?.order.id;
  //   } catch (e) {
  //     logger.e('[UserOrderCubit] - Error checking active order: $e');
  //     return null;
  //   }
  // }

  // /// Clear the active order state and stored ID
  // Future<void> clearActiveOrder() async {
  //   await _keyValueService.remove(KeyValueKeys.activeOrderId);
  //   await teardownWebsocket();
  //   _orderId = null;
  //   _paymentId = null;
  //   emit(
  //     state.copyWith(
  //       currentOrder: const OperationResult.idle(),
  //       currentPayment: const OperationResult.idle(),
  //       currentTransaction: const OperationResult.idle(),
  //       currentAssignedDriver: const OperationResult.idle(),
  //     ),
  //   );
  // }

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
          emit(
            state.copyWith(
              currentPayment: OperationResult.success(data.p.payment),
              currentTransaction: OperationResult.success(data.p.transaction),
            ),
          );

          await _webSocketService.disconnect(paymentId);

          // For FOOD orders, connect to order WebSocket to receive merchant updates
          // For RIDE/DELIVERY orders, connect to driver pool for driver matching
          final currentOrder = state.currentOrder.value;
          final orderId = _orderId;
          if (currentOrder?.type == OrderType.FOOD && orderId != null) {
            await _setupLiveOrderWebsocket(orderId: orderId);
          } else {
            // await _setupFindDriverWebsocket();
          }
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

  // Future<void> _setupFindDriverWebsocket() async {
  //   try {
  //     const driverPool = 'driver-pool';
  //     Future<void> handleMessage(Map<String, dynamic> json) async {
  //       final data = OrderEnvelope.fromJson(json);
  //       logger.d('Driver Pool WebSocket Message: $data');

  //       if (data.e == OrderEnvelopeEvent.MATCHING &&
  //           state.currentOrder.value?.id == data.p.detail?.order.id) {
  //         final detail = data.p.detail;
  //         final payment = detail?.payment;
  //         final transaction = detail?.transaction;
  //         if (detail != null && payment != null && transaction != null) {
  //           emit(
  //             state.copyWith(
  //               currentOrder: OperationResult.success(detail.order),
  //               currentPayment: OperationResult.success(payment),
  //               currentTransaction: OperationResult.success(transaction),
  //             ),
  //           );
  //         }
  //       }

  //       if (data.e == OrderEnvelopeEvent.CANCELED) {
  //         final detail = data.p.detail;
  //         final payment = detail?.payment;
  //         final transaction = detail?.transaction;
  //         if (detail != null && payment != null && transaction != null) {
  //           emit(
  //             state.copyWith(
  //               currentOrder: OperationResult.success(detail.order),
  //               currentPayment: OperationResult.success(payment),
  //               currentTransaction: OperationResult.success(transaction),
  //             ),
  //           );
  //         }
  //         emit(
  //           state.copyWith(
  //             currentOrder: OperationResult.failed(
  //               UnknownError(data.p.cancelReason ?? 'Order cancelled'),
  //             ),
  //           ),
  //         );
  //       }

  //       if (data.e == OrderEnvelopeEvent.DRIVER_ACCEPTED) {
  //         final detail = data.p.detail;
  //         final payment = detail?.payment;
  //         final transaction = detail?.transaction;
  //         if (detail != null && payment != null && transaction != null) {
  //           emit(
  //             state.copyWith(
  //               currentOrder: OperationResult.success(detail.order),
  //               currentPayment: OperationResult.success(payment),
  //               currentTransaction: OperationResult.success(transaction),
  //               currentAssignedDriver: OperationResult.success(
  //                 data.p.driverAssigned,
  //               ),
  //             ),
  //           );
  //         }

  //         await _webSocketService.disconnect(driverPool);
  //         final orderId = _orderId;
  //         if (orderId != null) {
  //           await _setupLiveOrderWebsocket(orderId: orderId);
  //         }
  //       }
  //     }

  //     await _webSocketService.connect(
  //       driverPool,
  //       '${UrlConstants.wsBaseUrl}/$driverPool',
  //       onMessage: (msg) async {
  //         final json = (msg as String).parseJson();
  //         if (json is Map<String, dynamic>) await handleMessage(json);
  //       },
  //     );
  //   } catch (e, st) {
  //     logger.e(
  //       '[UserOrderCubit] - Driver Pool WebSocket error: $e',
  //       error: e,
  //       stackTrace: st,
  //     );
  //     emit(
  //       state.copyWith(
  //         currentAssignedDriver: OperationResult.failed(
  //           const UnknownError('Failed to connect to driver service'),
  //         ),
  //       ),
  //     );
  //   }
  // }

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

        // Handle generic order status change events from REST API updates
        // This catches status changes made via REST API (e.g., driver updating status)
        if (data.e == OrderEnvelopeEvent.ORDER_STATUS_CHANGED) {
          final detail = data.p.detail;
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
        if (data.e == OrderEnvelopeEvent.COMPLETED) {
          final detail = data.p.detail;
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
            logger.i('[UserOrderCubit] Order completed: ${detail.order.id}');
          }
        }

        // Handle order cancellation events
        if (data.e == OrderEnvelopeEvent.CANCELED) {
          final detail = data.p.detail;
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
        if (data.e == OrderEnvelopeEvent.NO_SHOW) {
          final detail = data.p.detail;
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
              state.copyWith(
                currentAssignedDriver: const OperationResult.idle(),
              ),
            );
            logger.i(
              '[UserOrderCubit] Driver cancelled, rematching: ${retryInfo.orderId}',
            );
          }
        }

        // Handle merchant accepted event (FOOD orders)
        if (data.e == OrderEnvelopeEvent.MERCHANT_ACCEPTED) {
          final detail = data.p.detail;
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
          final detail = data.p.detail;
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
          final detail = data.p.detail;
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
          final detail = data.p.detail;
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

  // ==================== Polling ====================

  /// Start polling for active order updates
  /// This is a fallback mechanism for devices that don't support WebSocket
  /// [intervalSeconds] - The interval between each poll (default: 5 seconds)
  void startPolling({int intervalSeconds = _defaultPollingIntervalSeconds}) {
    if (state.isPolling) {
      logger.d('[UserOrderCubit] Polling already active, skipping start');
      return;
    }

    logger.i(
      '[UserOrderCubit] Starting polling with ${intervalSeconds}s interval',
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
  void stopPolling() {
    if (!state.isPolling && _pollingTimer == null) {
      return;
    }

    logger.i('[UserOrderCubit] Stopping polling');
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
        logger.d('[UserOrderCubit] Poll: No active order found');
        stopPolling();
        // await clearActiveOrder();
        return;
      }

      final order = activeOrder.order;
      final currentOrder = state.currentOrder.value;

      // Check if order status changed or if we have new data
      final hasChanges =
          currentOrder == null ||
          currentOrder.id != order.id ||
          currentOrder.status != order.status ||
          _hasDriverLocationChanged(
            state.currentAssignedDriver.value,
            activeOrder.driver,
          );

      if (hasChanges) {
        logger.d(
          '[UserOrderCubit] Poll: Order updated - '
          'status: ${order.status}, driver: ${activeOrder.driver?.userId}',
        );

        emit(
          state.copyWith(
            currentOrder: OperationResult.success(order),
            currentPayment: activeOrder.payment != null
                ? OperationResult.success(activeOrder.payment!)
                : state.currentPayment,
            currentTransaction: activeOrder.transaction != null
                ? OperationResult.success(activeOrder.transaction!)
                : state.currentTransaction,
            currentAssignedDriver: activeOrder.driver != null
                ? OperationResult.success(activeOrder.driver)
                : state.currentAssignedDriver,
          ),
        );
      }

      // Check if order is in terminal state, stop polling
      if (_isTerminalStatus(order.status)) {
        logger.i(
          '[UserOrderCubit] Poll: Order in terminal state (${order.status}), '
          'stopping polling',
        );
        stopPolling();
      }
    } catch (e, st) {
      logger.e('[UserOrderCubit] Poll error: $e', error: e, stackTrace: st);
      // Don't stop polling on error, let it retry
    }
  }

  /// Check if driver location has changed
  bool _hasDriverLocationChanged(Driver? current, Driver? incoming) {
    if (current == null && incoming == null) return false;
    if (current == null || incoming == null) return true;

    final currentLoc = current.currentLocation;
    final incomingLoc = incoming.currentLocation;

    if (currentLoc == null && incomingLoc == null) return false;
    if (currentLoc == null || incomingLoc == null) return true;

    return currentLoc.x != incomingLoc.x || currentLoc.y != incomingLoc.y;
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
