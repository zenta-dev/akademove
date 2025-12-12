import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/services.dart';

class MerchantOrderCubit extends BaseCubit<MerchantOrderState> {
  MerchantOrderCubit({
    required OrderRepository orderRepository,
    required MerchantOrderRepository merchantOrderRepository,
    required WebSocketService webSocketService,
    required NotificationService notificationService,
  }) : _orderRepository = orderRepository,
       _merchantOrderRepository = merchantOrderRepository,
       _webSocketService = webSocketService,
       _notificationService = notificationService,
       super(const MerchantOrderState());

  final OrderRepository _orderRepository;
  final MerchantOrderRepository _merchantOrderRepository;
  final WebSocketService _webSocketService;
  final NotificationService _notificationService;

  String? _orderId;
  String? _merchantId;

  /// WebSocket key for merchant-level order notifications
  static const _merchantWsKeyPrefix = 'merchant-orders';

  String _getMerchantWsKey(String merchantId) =>
      '$_merchantWsKeyPrefix-$merchantId';

  void reset() => emit(const MerchantOrderState());

  /// Clear the incoming order from state (used after dialog is shown/dismissed)
  void clearIncomingOrder() {
    emit(state.copyWith(clearIncomingOrder: true));
  }

  @override
  Future<void> close() {
    unsubscribeFromOrder();
    unsubscribeFromMerchantOrders();
    return super.close();
  }

  /// Subscribe to merchant-level WebSocket for real-time incoming order notifications
  ///
  /// This connects to `/ws/merchant/{merchantId}/orders` and receives events like:
  /// - NEW_ORDER: When a new food order is placed for this merchant
  /// - ORDER_CANCELLED: When an order is cancelled
  /// - DRIVER_ASSIGNED: When a driver is assigned to pick up the order
  /// - ORDER_COMPLETED: When an order is completed
  /// - ORDER_STATUS_CHANGED: When order status changes
  Future<void> subscribeToMerchantOrders(String merchantId) async {
    _merchantId = merchantId;
    final wsKey = _getMerchantWsKey(merchantId);

    try {
      logger.i(
        '[MerchantOrderCubit] - Subscribing to merchant WebSocket: $merchantId',
      );

      await _webSocketService.connect(
        wsKey,
        '${UrlConstants.wsBaseUrl}/merchant/$merchantId/orders',
        onMessage: (Object? msg) {
          try {
            if (msg == null) return;
            final json = jsonDecode(msg.toString()) as Map<String, Object?>;
            final envelope = MerchantEnvelope.fromJson(json);
            _handleMerchantUpdate(envelope);
          } catch (e, st) {
            logger.e(
              '[MerchantOrderCubit] - Failed to parse merchant WebSocket message',
              error: e,
              stackTrace: st,
            );
          }
        },
        autoReconnect: true,
      );

      emit(state.copyWith(isMerchantWsConnected: true));
    } catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Failed to subscribe to merchant WebSocket',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(isMerchantWsConnected: false));
    }
  }

  /// Handle incoming merchant WebSocket updates
  void _handleMerchantUpdate(MerchantEnvelope envelope) {
    logger.d(
      '[MerchantOrderCubit] - Received merchant WebSocket update: ${envelope.e}',
    );

    switch (envelope.e) {
      case MerchantEnvelopeEvent.NEW_ORDER:
        _handleNewOrderEvent(envelope.p);
      case MerchantEnvelopeEvent.ORDER_CANCELLED:
        _handleOrderCancelledEvent(envelope.p);
      case MerchantEnvelopeEvent.DRIVER_ASSIGNED:
        _handleDriverAssignedEvent(envelope.p);
      case MerchantEnvelopeEvent.ORDER_COMPLETED:
        _handleOrderCompletedEvent(envelope.p);
      case MerchantEnvelopeEvent.ORDER_STATUS_CHANGED:
        _handleOrderStatusChangedEvent(envelope.p);
      case null:
        logger.w('[MerchantOrderCubit] - Received envelope with null event');
    }
  }

  /// Handle NEW_ORDER event - add new order to list and notify merchant
  void _handleNewOrderEvent(MerchantEnvelopePayload payload) {
    final newOrder = payload.order;
    if (newOrder == null) {
      logger.w('[MerchantOrderCubit] - NEW_ORDER event missing order data');
      return;
    }

    logger.i(
      '[MerchantOrderCubit] - New order received: ${newOrder.id} '
      '(items: ${payload.itemCount}, total: ${payload.totalAmount})',
    );

    // Check if order already exists in the list
    final existingOrders = state.orders.value ?? [];
    final orderExists = existingOrders.any((o) => o.id == newOrder.id);

    if (!orderExists) {
      // Add new order to the beginning of the list
      final updatedList = [newOrder, ...existingOrders];
      emit(
        state.copyWith(
          orders: OperationResult.success(
            updatedList,
            message: 'New order received!',
          ),
          // Set incoming order to trigger dialog
          incomingOrder: newOrder,
        ),
      );

      // Notify merchant with haptic feedback and local notification
      _notifyNewOrder(newOrder);
    }
  }

  /// Handle ORDER_CANCELLED event - remove or update order in list
  void _handleOrderCancelledEvent(MerchantEnvelopePayload payload) {
    final orderId = payload.orderId;
    final cancelledOrder = payload.order;

    if (orderId == null && cancelledOrder == null) {
      logger.w(
        '[MerchantOrderCubit] - ORDER_CANCELLED event missing order data',
      );
      return;
    }

    final targetOrderId = orderId ?? cancelledOrder?.id;
    logger.i(
      '[MerchantOrderCubit] - Order cancelled: $targetOrderId '
      '(reason: ${payload.cancelReason})',
    );

    final existingOrders = state.orders.value ?? [];

    // Check if the cancelled order is the current incoming order
    final isIncomingOrder = state.incomingOrder?.id == targetOrderId;

    if (cancelledOrder != null) {
      // Update the order with cancelled status
      final updatedList = existingOrders.map((o) {
        if (o.id == cancelledOrder.id) {
          return cancelledOrder;
        }
        return o;
      }).toList();

      emit(
        state.copyWith(
          orders: OperationResult.success(
            updatedList,
            message: 'Order was cancelled',
          ),
          order: state.order.value?.id == cancelledOrder.id
              ? OperationResult.success(
                  cancelledOrder,
                  message: 'Order was cancelled',
                )
              : state.order,
          // Clear incoming order if it was cancelled
          clearIncomingOrder: isIncomingOrder,
        ),
      );
    } else if (targetOrderId != null) {
      // Just remove the order from active orders list
      final updatedList = existingOrders
          .where((o) => o.id != targetOrderId)
          .toList();

      emit(
        state.copyWith(
          orders: OperationResult.success(
            updatedList,
            message: 'Order was cancelled',
          ),
          // Clear incoming order if it was cancelled
          clearIncomingOrder: isIncomingOrder,
        ),
      );
    }
  }

  /// Handle DRIVER_ASSIGNED event - update order with driver info
  void _handleDriverAssignedEvent(MerchantEnvelopePayload payload) {
    final updatedOrder = payload.order;
    final orderId = payload.orderId;

    logger.i(
      '[MerchantOrderCubit] - Driver assigned to order: '
      '${orderId ?? updatedOrder?.id} (driver: ${payload.driverName})',
    );

    if (updatedOrder != null) {
      _updateOrderInList(updatedOrder, message: 'Driver assigned');
    }
  }

  /// Handle ORDER_COMPLETED event - update order status
  void _handleOrderCompletedEvent(MerchantEnvelopePayload payload) {
    final completedOrder = payload.order;
    final orderId = payload.orderId;

    logger.i(
      '[MerchantOrderCubit] - Order completed: ${orderId ?? completedOrder?.id}',
    );

    if (completedOrder != null) {
      _updateOrderInList(completedOrder, message: 'Order completed');
    }
  }

  /// Handle ORDER_STATUS_CHANGED event - update order status
  void _handleOrderStatusChangedEvent(MerchantEnvelopePayload payload) {
    final updatedOrder = payload.order;
    final orderId = payload.orderId;

    logger.i(
      '[MerchantOrderCubit] - Order status changed: '
      '${orderId ?? updatedOrder?.id} -> ${payload.newStatus}',
    );

    if (updatedOrder != null) {
      _updateOrderInList(updatedOrder);
    }
  }

  /// Helper to update an order in the orders list
  void _updateOrderInList(Order updatedOrder, {String? message}) {
    final existingOrders = state.orders.value ?? [];
    final orderExists = existingOrders.any((o) => o.id == updatedOrder.id);

    final updatedList = orderExists
        ? existingOrders.map((o) {
            if (o.id == updatedOrder.id) {
              return updatedOrder;
            }
            return o;
          }).toList()
        : [updatedOrder, ...existingOrders];

    emit(
      state.copyWith(
        orders: OperationResult.success(updatedList, message: message),
        order: state.order.value?.id == updatedOrder.id
            ? OperationResult.success(updatedOrder, message: message)
            : state.order,
      ),
    );
  }

  /// Unsubscribe from merchant-level WebSocket
  Future<void> unsubscribeFromMerchantOrders() async {
    final merchantId = _merchantId;
    if (merchantId == null) return;

    try {
      logger.i('[MerchantOrderCubit] - Unsubscribing from merchant WebSocket');
      final wsKey = _getMerchantWsKey(merchantId);
      await _webSocketService.disconnect(wsKey);
      _merchantId = null;
      emit(state.copyWith(isMerchantWsConnected: false));
    } catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Failed to unsubscribe from merchant WebSocket',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> subscribeToOrder(String orderId) async {
    _orderId = orderId;
    try {
      logger.i(
        '[MerchantOrderCubit] - Subscribing to order WebSocket: $orderId',
      );

      await _webSocketService.connect(
        orderId,
        '${UrlConstants.wsBaseUrl}/order/$orderId',
        onMessage: (Object? msg) {
          try {
            if (msg == null) return;
            final json = jsonDecode(msg.toString()) as Map<String, Object?>;
            final envelope = OrderEnvelope.fromJson(json);
            _handleOrderUpdate(envelope);
          } catch (e, st) {
            logger.e(
              '[MerchantOrderCubit] - Failed to parse WebSocket message',
              error: e,
              stackTrace: st,
            );
          }
        },
        autoReconnect: true,
      );
    } catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Failed to subscribe to order WebSocket',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Handle incoming WebSocket order updates
  void _handleOrderUpdate(OrderEnvelope envelope) {
    logger.d('[MerchantOrderCubit] - Received WebSocket update: ${envelope.e}');

    // Extract updated order from envelope payload
    final detail = envelope.p.detail;
    final updatedOrder = detail?.order;
    if (updatedOrder == null) {
      logger.w('[MerchantOrderCubit] - No order data in envelope');
      return;
    }

    // Check if this is a new order (REQUESTED or MATCHING status and not in our list)
    final existingOrders = state.orders.data?.value;
    final isNewOrder =
        (updatedOrder.status == OrderStatus.REQUESTED ||
            updatedOrder.status == OrderStatus.MATCHING) &&
        (existingOrders == null ||
            !existingOrders.any((order) => order.id == updatedOrder.id));

    // Trigger notification and vibration for new orders
    if (isNewOrder) {
      _notifyNewOrder(updatedOrder);
    }

    // Update the order in list and selected
    final updatedList = (state.orders.value ?? []).map((order) {
      if (order.id == updatedOrder.id) {
        return updatedOrder;
      }
      return order;
    }).toList();

    // Add new order to list if not present
    final finalList = isNewOrder ? [updatedOrder, ...updatedList] : updatedList;

    // Update selected if it's the same order
    final updatedSelected = state.order.value?.id == updatedOrder.id
        ? updatedOrder
        : state.order.value;

    final msg = _getEventMessage(envelope.e);

    emit(
      state.copyWith(
        orders: OperationResult.success(finalList, message: msg),
        order: updatedSelected != null
            ? OperationResult.success(updatedSelected, message: msg)
            : state.order,
      ),
    );
  }

  Future<void> _notifyNewOrder(Order order) async {
    try {
      // Vibrate device
      await HapticFeedback.heavyImpact();

      // Show local notification with sound
      final orderType = order.type.name.toLowerCase();
      await _notificationService.show(
        title: 'New ${orderType.toUpperCase()} Order!',
        body: 'Order #${order.id.substring(0, 8)} - Tap to view details',
        data: {'orderId': order.id, 'type': orderType},
      );

      logger.i(
        '[MerchantOrderCubit] - Notified merchant of new order: ${order.id}',
      );
    } catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Failed to notify new order',
        error: e,
        stackTrace: st,
      );
    }
  }

  String? _getEventMessage(OrderEnvelopeEvent? event) {
    switch (event) {
      case OrderEnvelopeEvent.DRIVER_ACCEPTED:
        return 'Driver has accepted the order';
      case OrderEnvelopeEvent.DRIVER_LOCATION_UPDATE:
        return null; // Don't show toast for location updates
      case OrderEnvelopeEvent.COMPLETED:
        return 'Order has been completed';
      case OrderEnvelopeEvent.CANCELED:
        return 'Order has been cancelled';
      default:
        return null;
    }
  }

  Future<void> unsubscribeFromOrder() async {
    try {
      logger.i('[MerchantOrderCubit] - Unsubscribing from order WebSocket');
      if (_orderId != null) await _webSocketService.disconnect(_orderId ?? '');
    } catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Failed to unsubscribe from order WebSocket',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> getMine({required List<OrderStatus> statuses}) async =>
      await taskManager.execute("MOC2-gM1-${statuses.join(',')}", () async {
        try {
          emit(state.copyWith(orders: OperationResult.loading()));

          final res = await _orderRepository.list(
            ListOrderQuery(statuses: statuses),
          );

          final mergedList = {
            for (final item in state.orders.value ?? <Order>[]) item.id: item,
            for (final item in res.data) item.id: item,
          }.values.toList();

          emit(
            state.copyWith(
              orders: OperationResult.success(mergedList, message: res.message),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantOrderCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(orders: OperationResult.failed(e)));
        }
      });

  Future<void> acceptOrder({
    required String merchantId,
    required String orderId,
  }) async => await taskManager.execute("MOC2-aO1-$orderId", () async {
    try {
      emit(state.copyWith(order: const OperationResult.loading()));

      final res = await _merchantOrderRepository.acceptOrder(
        merchantId: merchantId,
        orderId: orderId,
      );

      // Update the order in the list
      final updatedList = (state.orders.value ?? []).map((order) {
        if (order.id == orderId) {
          return res.data;
        }
        return order;
      }).toList();

      emit(
        state.copyWith(
          orders: OperationResult.success(updatedList, message: res.message),
          order: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Accept order error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(order: OperationResult.failed(e)));
    }
  });

  Future<void> rejectOrder({
    required String merchantId,
    required String orderId,
    required String reason,
    String? note,
  }) async => await taskManager.execute("MOC2-rO1-$orderId", () async {
    try {
      emit(state.copyWith(order: const OperationResult.loading()));

      final res = await _merchantOrderRepository.rejectOrder(
        merchantId: merchantId,
        orderId: orderId,
        reason: reason,
        note: note,
      );

      // Remove the rejected order from the list
      final updatedList = (state.orders.value ?? [])
          .where((order) => order.id != orderId)
          .toList();

      emit(
        state.copyWith(
          orders: OperationResult.success(updatedList, message: res.message),
          order: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Reject order error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(order: OperationResult.failed(e)));
    }
  });

  Future<void> markPreparing({
    required String merchantId,
    required String orderId,
  }) async => await taskManager.execute("MOC2-mP1-$orderId", () async {
    try {
      emit(state.copyWith(order: const OperationResult.loading()));

      final res = await _merchantOrderRepository.markPreparing(
        merchantId: merchantId,
        orderId: orderId,
      );

      // Update the order in the list
      final updatedList = (state.orders.value ?? []).map((order) {
        if (order.id == orderId) {
          return res.data;
        }
        return order;
      }).toList();

      emit(
        state.copyWith(
          orders: OperationResult.success(updatedList, message: res.message),
          order: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Mark preparing error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(order: OperationResult.failed(e)));
    }
  });

  Future<void> markReady({
    required String merchantId,
    required String orderId,
  }) async => await taskManager.execute("MOC2-mR1-$orderId", () async {
    try {
      emit(state.copyWith(order: const OperationResult.loading()));

      final res = await _merchantOrderRepository.markReady(
        merchantId: merchantId,
        orderId: orderId,
      );

      // Update the order in the list
      final updatedList = (state.orders.value ?? []).map((order) {
        if (order.id == orderId) {
          return res.data;
        }
        return order;
      }).toList();

      emit(
        state.copyWith(
          orders: OperationResult.success(updatedList, message: res.message),
          order: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Mark ready error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(order: OperationResult.failed(e)));
    }
  });
}
