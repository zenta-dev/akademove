part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserOrderState extends BaseState2 with UserOrderStateMappable {
  UserOrderState({
    this.estimateOrder,
    this.orderHistories,
    this.selectedOrder,

    this.currentOrder,
    this.currentPayment,
    this.currentTransaction,
    this.currentAssignedDriver,

    super.state,
    super.message,
    super.error,
  });

  final EstimateOrderResult? estimateOrder;
  final List<Order>? orderHistories;
  final Order? selectedOrder;

  final Order? currentOrder;
  final Payment? currentPayment;
  final Transaction? currentTransaction;
  final Driver? currentAssignedDriver;

  @override
  UserOrderState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  UserOrderState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserOrderState toSuccess({
    EstimateOrderResult? estimateOrder,
    Order? currentOrder,
    Payment? currentPayment,
    Transaction? currentTransaction,
    Driver? currentAssignedDriver,
    List<Order>? orderHistories,
    Order? selectedOrder,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    estimateOrder: estimateOrder ?? this.estimateOrder,
    currentOrder: currentOrder ?? this.currentOrder,
    currentPayment: currentPayment ?? this.currentPayment,
    currentTransaction: currentTransaction ?? this.currentTransaction,
    currentAssignedDriver: currentAssignedDriver ?? this.currentAssignedDriver,
    orderHistories: orderHistories ?? this.orderHistories,
    selectedOrder: selectedOrder ?? this.selectedOrder,
    message: message,
    error: null,
  );

  @override
  UserOrderState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
