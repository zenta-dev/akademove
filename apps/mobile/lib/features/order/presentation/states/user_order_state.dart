part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserOrderState extends BaseState2 with UserOrderStateMappable {
  UserOrderState({
    this.estimateOrder,
    this.placeOrderResult,
    super.state,
    super.message,
    super.error,
  });

  final EstimateOrderResult? estimateOrder;
  final PlaceOrderResponse? placeOrderResult;

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
    String? message,
  }) => copyWith(
    state: CubitState.success,
    estimateOrder: estimateOrder ?? this.estimateOrder,
    placeOrderResult: placeOrderResult ?? this.placeOrderResult,
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
