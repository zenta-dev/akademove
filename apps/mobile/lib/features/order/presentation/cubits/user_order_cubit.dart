import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserOrderCubit extends BaseCubit<UserOrderState> {
  UserOrderCubit({
    required OrderRepository orderRepository,
    required WebSocketService webSocketService,
  }) : _orderRepository = orderRepository,
       _webSocketService = webSocketService,
       super(UserOrderState());

  final OrderRepository _orderRepository;
  final WebSocketService _webSocketService;

  String? _paymentId;
  String? _orderId;

  Future<void> init() async {
    reset();
  }

  void reset() {
    emit(UserOrderState());
  }

  @override
  Future<void> close() async {
    await teardownWebsocket();
    return super.close();
  }

  Future<void> list() async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      final res = await _orderRepository.list(
        const ListOrderQuery(statuses: OrderStatus.values),
      );

      state.unAssignOperation(methodName);
      emit(state.toSuccess(orderHistories: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<void> maybeGet(String? id) async {
    if (id == null) return;

    final methodName = getMethodName();
    if (state.checkAndAssignOperation(methodName)) return;

    try {
      emit(state.toLoading());

      final local = state.orderHistories?.cast<Order?>().firstWhere(
        (v) => v?.id == id,
        orElse: () => null,
      );

      if (local != null) {
        state.unAssignOperation(methodName);
        emit(state.toSuccess(selectedOrder: local));
        return;
      }

      // Fetch from API
      final res = await _orderRepository.get(id);

      state.unAssignOperation(methodName);
      emit(state.toSuccess(selectedOrder: res.data, message: res.message));
    } on BaseError catch (e, st) {
      state.unAssignOperation(methodName);
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<void> estimate(Place pickup, Place dropoff) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      final res = await _orderRepository.estimate(
        EstimateOrderQuery(
          type: OrderType.RIDE,
          pickupLocation: pickup.toCoordinate(),
          dropoffLocation: dropoff.toCoordinate(),
        ),
      );

      state.unAssignOperation(methodName);
      emit(
        state.toSuccess(
          estimateOrder: EstimateOrderResult(
            summary: res.data,
            pickup: pickup,
            dropoff: dropoff,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<PlaceOrderResponse?> placeOrder(
    Place pickup,
    Place dropoff,
    OrderType type,
    PaymentMethod method, {
    UserGender? gender,
    BankProvider? bankProvider,
  }) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return null;
      emit(state.toLoading());

      final res = await _orderRepository.placeOrder(
        PlaceOrder(
          type: type,
          pickupLocation: pickup.toCoordinate(),
          dropoffLocation: dropoff.toCoordinate(),
          gender: gender,
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
      state.unAssignOperation(methodName);
      emit(
        state.toSuccess(
          currentOrder: res.data.order,
          currentPayment: res.data.payment,
          currentTransaction: res.data.transaction,
        ),
      );
      return res.data;
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
      return null;
    }
  }

  Future<void> _setupPaymentWebsocket({required String paymentId}) async {
    try {
      _paymentId = paymentId;
      Future<void> handleMessage(Map<String, dynamic> json) async {
        final data = PaymentEnvelope.fromJson(json);
        logger.d('Payment WebSocket Message: $data');

        if (data.e == PaymentEnvelopeEvent.PAYMENT_SUCCESS) {
          emit(
            state.toSuccess(
              currentPayment: data.p.payment,
              currentTransaction: data.p.transaction,
            ),
          );

          await _webSocketService.disconnect(paymentId);
          await _setupFindDriverWebsocket();
        }

        if (data.e == PaymentEnvelopeEvent.PAYMENT_FAILED) {
          emit(
            state.toSuccess(
              currentPayment: data.p.payment,
              currentTransaction: data.p.transaction,
            ),
          );
          emit(state.toFailure(const UnknownError('Payment expired')));
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
        state.toFailure(
          const UnknownError('Failed to connect to payment service'),
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
            state.currentOrder?.id == data.p.detail?.order.id) {
          emit(
            state.toSuccess(
              currentOrder: data.p.detail?.order,
              currentPayment: data.p.detail?.payment,
              currentTransaction: data.p.detail?.transaction,
            ),
          );
        }

        if (data.e == OrderEnvelopeEvent.CANCELED) {
          emit(
            state.toSuccess(
              currentOrder: data.p.detail?.order,
              currentPayment: data.p.detail?.payment,
              currentTransaction: data.p.detail?.transaction,
            ),
          );
          emit(
            state.toFailure(
              UnknownError(data.p.cancelReason ?? 'Order cancelled'),
            ),
          );
        }

        if (data.e == OrderEnvelopeEvent.DRIVER_ACCEPTED) {
          emit(
            state.toSuccess(
              currentOrder: data.p.detail?.order,
              currentPayment: data.p.detail?.payment,
              currentTransaction: data.p.detail?.transaction,
              currentAssignedDriver: data.p.driverAssigned,
            ),
          );

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
        state.toFailure(
          const UnknownError('Failed to connect to driver service'),
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
          var driver = state.currentAssignedDriver ?? dummyDriver;
          if (x != null && y != null) {
            driver = driver.copyWith(
              currentLocation: Coordinate(x: x, y: y),
            );
            emit(state.toSuccess(currentAssignedDriver: driver));
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
}
