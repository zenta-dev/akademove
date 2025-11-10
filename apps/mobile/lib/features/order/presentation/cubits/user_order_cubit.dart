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

  Future<void> estimate(Place pickup, Place dropoff) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      final res = await _orderRepository.estimate(
        EstimateOrderQuery(
          type: OrderType.ride,
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

  Future<void> placeOrder(
    Place pickup,
    Place dropoff,
    OrderType type,
    PaymentMethod method, {
    UserGender? gender,
  }) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      final res = await _orderRepository.placeOrder(
        PlaceOrder(
          type: type,
          pickupLocation: pickup.toCoordinate(),
          dropoffLocation: dropoff.toCoordinate(),
          gender: gender,
          payment: PlaceOrderPayment(
            method: method,
            provider: PaymentProvider.MIDTRANS,
          ),
        ),
      );

      _orderId = res.data.order.id;
      _paymentId = res.data.payment.id;
      _setupPaymentWebsocket(paymentId: res.data.payment.id);
      state.unAssignOperation(methodName);
      emit(state.toSuccess(placeOrderResult: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  void _setupPaymentWebsocket({required String paymentId}) {
    _paymentId = paymentId;
    void handleMessage(Map<String, dynamic> json) {
      final data = WSPaymentEnvelope.fromJson(json);

      if (data.type == WSEnvelopeType.paymentColonSuccess) {
        final placeOrderResult =
            state.placeOrderResult ?? dummyPlaceOrderResponse;
        emit(
          state.toSuccess(
            placeOrderResult: placeOrderResult.copyWith(
              transaction: data.payload.transaction,
              payment: data.payload.payment,
            ),
            wsPaymentEnvelope: data,
          ),
        );

        _webSocketService.disconnect(paymentId);
        _setupFindDriverWebsocket();
      }
      if (data.type == WSEnvelopeType.paymentColonFailed) {
        final placeOrderResult =
            state.placeOrderResult ?? dummyPlaceOrderResponse;
        emit(
          state.toSuccess(
            placeOrderResult: placeOrderResult.copyWith(
              transaction: data.payload.transaction,
              payment: data.payload.payment,
            ),
            wsPaymentEnvelope: data,
          ),
        );
        emit(state.toFailure(const UnknownError('Payment expired')));
      }
    }

    _webSocketService.connect(
      paymentId,
      '${UrlConstants.wsBaseUrl}/payment/$paymentId',
      onMessage: (msg) {
        final json = (msg as String).parseJson();
        if (json is Map<String, dynamic>) handleMessage(json);
      },
    );
  }

  void _setupFindDriverWebsocket() {
    const driverPool = 'driver-pool';
    void handleMessage(Map<String, dynamic> json) {
      final data = WSPlaceOrderEnvelope.fromJson(json);

      if (data.type == WSEnvelopeType.orderColonRequest ||
          data.type == WSEnvelopeType.orderColonMatching) {
        emit(
          state.toSuccess(
            placeOrderResult: data.payload,
            wsPlaceOrderEnvelope: data,
          ),
        );
      }
      if (data.type == WSEnvelopeType.orderColonAccepted) {
        emit(
          state.toSuccess(
            placeOrderResult: data.payload,
            wsPlaceOrderEnvelope: data,
          ),
        );
        _webSocketService.disconnect(driverPool);
        _setupLiveOrderWebsocket(orderId: data.payload.order.id);
      }
      if (data.type == WSEnvelopeType.orderColonCancelled) {
        emit(
          state.toSuccess(
            placeOrderResult: data.payload,
            wsPlaceOrderEnvelope: data,
          ),
        );
        emit(state.toFailure(const UnknownError('Payment expired')));
      }
    }

    _webSocketService.connect(
      driverPool,
      '${UrlConstants.wsBaseUrl}/$driverPool',
      onMessage: (msg) {
        final json = (msg as String).parseJson();
        if (json is Map<String, dynamic>) handleMessage(json);
      },
    );
  }

  void _setupLiveOrderWebsocket({required String orderId}) {
    _orderId = orderId;
    void handleMessage(Map<String, dynamic> json) {
      final data = WSOrderEnvelope.fromJson(json);
      if (data.type == WSEnvelopeType.driverColonLocationUpdate &&
          data.from == WSEnvelopeSender.client &&
          data.to == WSEnvelopeSender.client &&
          data.payload.driverUpdateLocation != null) {
        emit(
          state.toSuccess(
            driverCoordinate: data.payload.driverUpdateLocation,
            wsOrderEnvelope: data,
          ),
        );
      }
    }

    _webSocketService.connect(
      orderId,
      '${UrlConstants.wsBaseUrl}/order/$orderId',
      onMessage: (msg) {
        final json = (msg as String).parseJson();
        if (json is Map<String, dynamic>) handleMessage(json);
      },
    );
  }

  Future<void> teardownWebsocket() async {
    final futures = [_webSocketService.disconnect('driver-pool')];
    if (_orderId != null) {
      futures.add(_webSocketService.disconnect(_orderId ?? ''));
    }
    if (_paymentId != null) {
      futures.add(_webSocketService.disconnect(_paymentId ?? ''));
    }

    await Future.wait(futures);
  }
}
