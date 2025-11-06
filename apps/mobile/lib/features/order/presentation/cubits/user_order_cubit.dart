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

  String? _orderId;

  Future<void> init() async {
    reset();
  }

  void reset() {
    _orderId = null;
    emit(UserOrderState());
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

  void _setupMatchingWebsocket(Order order) {
    const key = 'driver-pool';
    _webSocketService.connect(key, '${Constants.wsBaseUrl}/$key');

    _webSocketService.stream(key)?.listen((msg) {
      final parse = (msg as String).parseJson();
      if (parse is Map<String, dynamic>) {
        final data = WSPlaceOrderEnvelope.fromJson(parse);
        if (data.type == WSEnvelopeType.orderColonMatching &&
            data.from == WSEnvelopeSender.server &&
            data.to == WSEnvelopeSender.client) {
          emit(state.toSuccess(placeOrderResult: data.payload));
        }
      }
    });

    _webSocketService.send(
      key,
      WSPlaceOrderEnvelope(
        type: WSEnvelopeType.orderColonRequest,
        from: WSEnvelopeSender.client,
        to: WSEnvelopeSender.server,
        payload: order,
      ).toJson().toString(),
    );
  }

  Future<void> placeOrder(
    Place pickup,
    Place dropoff,
    OrderType type, {
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
        ),
      );

      _orderId = res.data.id;
      emit(state.toSuccess(placeOrderResult: res.data));
      _setupMatchingWebsocket(res.data);
      state.unAssignOperation(methodName);
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }
}
