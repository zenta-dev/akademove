import 'dart:convert';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';

class MerchantOrderCubit extends BaseCubit<MerchantOrderState> {
  MerchantOrderCubit({
    required OrderRepository orderRepository,
    required MerchantOrderRepository merchantOrderRepository,
    WebSocketService? webSocketService,
  }) : _orderRepository = orderRepository,
       _merchantOrderRepository = merchantOrderRepository,
       _webSocketService = webSocketService ?? sl<WebSocketService>(),
       super(const MerchantOrderState());

  final OrderRepository _orderRepository;
  final MerchantOrderRepository _merchantOrderRepository;
  final WebSocketService _webSocketService;

  static const String _wsKey = 'merchant_order';

  Future<void> init() async {}

  /// Subscribe to order WebSocket for real-time updates
  Future<void> subscribeToOrder(String orderId) async {
    try {
      logger.i(
        '[MerchantOrderCubit] - Subscribing to order WebSocket: $orderId',
      );

      await _webSocketService.connect(
        _wsKey,
        '${UrlConstants.wsBaseUrl}/order/$orderId',
        onMessage: (dynamic msg) {
          try {
            final json = jsonDecode(msg.toString()) as Map<String, dynamic>;
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
    final updatedOrder = envelope.p.detail?.order;
    if (updatedOrder == null) {
      logger.w('[MerchantOrderCubit] - No order data in envelope');
      return;
    }

    // Update the order in list and selected
    final updatedList = state.list.map((order) {
      if (order.id == updatedOrder.id) {
        return updatedOrder;
      }
      return order;
    }).toList();

    // Update selected if it's the same order
    final updatedSelected = state.selected?.id == updatedOrder.id
        ? updatedOrder
        : state.selected;

    emit(
      state.toSuccess(
        list: updatedList,
        selected: updatedSelected,
        message: _getEventMessage(envelope.e),
      ),
    );
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

  /// Unsubscribe from order WebSocket
  Future<void> unsubscribeFromOrder() async {
    try {
      logger.i('[MerchantOrderCubit] - Unsubscribing from order WebSocket');
      await _webSocketService.disconnect(_wsKey);
    } catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Failed to unsubscribe from order WebSocket',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> close() {
    unsubscribeFromOrder();
    return super.close();
  }

  Future<void> getMine({required List<OrderStatus> statuses}) async {
    try {
      emit(state.toLoading());

      final res = await _orderRepository.list(
        ListOrderQuery(statuses: statuses),
      );

      final mergedList = {
        for (final item in state.list) item.id: item,
        for (final item in res.data) item.id: item,
      }.values.toList();

      emit(state.toSuccess(list: mergedList, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Accept an order
  /// Updates order status from REQUESTED/MATCHING to ACCEPTED
  Future<void> acceptOrder({
    required String merchantId,
    required String orderId,
  }) async {
    try {
      emit(state.toLoading());

      final res = await _merchantOrderRepository.acceptOrder(
        merchantId: merchantId,
        orderId: orderId,
      );

      // Update the order in the list
      final updatedList = state.list.map((order) {
        if (order.id == orderId) {
          return res.data;
        }
        return order;
      }).toList();

      emit(
        state.toSuccess(
          list: updatedList,
          selected: res.data,
          message: res.message,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Accept order error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Reject an order
  /// Updates order status to CANCELLED_BY_MERCHANT and processes refund
  Future<void> rejectOrder({
    required String merchantId,
    required String orderId,
    required String reason,
    String? note,
  }) async {
    try {
      emit(state.toLoading());

      final res = await _merchantOrderRepository.rejectOrder(
        merchantId: merchantId,
        orderId: orderId,
        reason: reason,
        note: note,
      );

      // Remove the rejected order from the list
      final updatedList = state.list
          .where((order) => order.id != orderId)
          .toList();

      emit(
        state.toSuccess(
          list: updatedList,
          selected: res.data,
          message: res.message,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Reject order error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Mark order as preparing
  /// Updates order status from ACCEPTED to PREPARING
  Future<void> markPreparing({
    required String merchantId,
    required String orderId,
  }) async {
    try {
      emit(state.toLoading());

      final res = await _merchantOrderRepository.markPreparing(
        merchantId: merchantId,
        orderId: orderId,
      );

      // Update the order in the list
      final updatedList = state.list.map((order) {
        if (order.id == orderId) {
          return res.data;
        }
        return order;
      }).toList();

      emit(
        state.toSuccess(
          list: updatedList,
          selected: res.data,
          message: res.message,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Mark preparing error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Mark order as ready for pickup
  /// Updates order status from PREPARING to READY_FOR_PICKUP
  Future<void> markReady({
    required String merchantId,
    required String orderId,
  }) async {
    try {
      emit(state.toLoading());

      final res = await _merchantOrderRepository.markReady(
        merchantId: merchantId,
        orderId: orderId,
      );

      // Update the order in the list
      final updatedList = state.list.map((order) {
        if (order.id == orderId) {
          return res.data;
        }
        return order;
      }).toList();

      emit(
        state.toSuccess(
          list: updatedList,
          selected: res.data,
          message: res.message,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Mark ready error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  void reset() => emit(const MerchantOrderState());
}
