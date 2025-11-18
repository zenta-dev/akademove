part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserOrderState extends BaseState2 with UserOrderStateMappable {
  UserOrderState({
    this.estimateOrder,
    this.placeOrderResult,
    this.driverCoordinate,
    this.orderHistories,
    this.selectedOrder,
    this.wsPaymentEnvelope,
    this.wsPlaceOrderEnvelope,
    this.wsOrderEnvelope,
    super.state,
    super.message,
    super.error,
  });

  final EstimateOrderResult? estimateOrder;
  final PlaceOrderResponse? placeOrderResult;
  final Coordinate? driverCoordinate;
  final List<Order>? orderHistories;
  final Order? selectedOrder;

  final WSPaymentEnvelope? wsPaymentEnvelope;
  final WSPlaceOrderEnvelope? wsPlaceOrderEnvelope;
  final WSOrderEnvelope? wsOrderEnvelope;

  @override
  UserOrderState toInitial() => copyWith(
    state: CubitState.initial,
    message: null,
    error: null,
  );

  @override
  UserOrderState toLoading() => copyWith(
    state: CubitState.loading,
    message: null,
    error: null,
  );

  @override
  UserOrderState toSuccess({
    EstimateOrderResult? estimateOrder,
    PlaceOrderResponse? placeOrderResult,
    Coordinate? driverCoordinate,
    WSPaymentEnvelope? wsPaymentEnvelope,
    WSPlaceOrderEnvelope? wsPlaceOrderEnvelope,
    WSOrderEnvelope? wsOrderEnvelope,
    List<Order>? orderHistories,
    Order? selectedOrder,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    estimateOrder: estimateOrder ?? this.estimateOrder,
    placeOrderResult: placeOrderResult ?? this.placeOrderResult,
    driverCoordinate: driverCoordinate ?? this.driverCoordinate,
    wsPaymentEnvelope: wsPaymentEnvelope ?? this.wsPaymentEnvelope,
    wsPlaceOrderEnvelope: wsPlaceOrderEnvelope ?? this.wsPlaceOrderEnvelope,
    wsOrderEnvelope: wsOrderEnvelope ?? this.wsOrderEnvelope,
    orderHistories: orderHistories ?? this.orderHistories,
    selectedOrder: selectedOrder ?? this.selectedOrder,
    message: message,
    error: null,
  );

  @override
  UserOrderState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message,
  );
}
