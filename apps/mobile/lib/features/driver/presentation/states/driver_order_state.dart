part of '_export.dart';

class DriverOrderState extends Equatable {
  const DriverOrderState({
    this.fetchOrderResult = const OperationResult.idle(),
    this.acceptOrderResult = const OperationResult.idle(),
    this.updateStatusResult = const OperationResult.idle(),
    this.currentOrder,
    this.customer,
    this.orderStatus,
  });

  final OperationResult<Order> fetchOrderResult;
  final OperationResult<Order> acceptOrderResult;
  final OperationResult<Order> updateStatusResult;

  final Order? currentOrder;
  final User? customer;
  final OrderStatus? orderStatus;

  bool get isLoading =>
      fetchOrderResult.isLoading ||
      acceptOrderResult.isLoading ||
      updateStatusResult.isLoading;

  bool get isFailure =>
      fetchOrderResult.isFailure ||
      acceptOrderResult.isFailure ||
      updateStatusResult.isFailure;

  bool get isSuccess =>
      fetchOrderResult.isSuccess ||
      acceptOrderResult.isSuccess ||
      updateStatusResult.isSuccess;

  BaseError? get error =>
      fetchOrderResult.error ??
      acceptOrderResult.error ??
      updateStatusResult.error;

  String? get message {
    if (acceptOrderResult.isSuccess) return 'Order accepted';
    if (updateStatusResult.isSuccess) return 'Status updated';
    return null;
  }

  @override
  List<Object?> get props => [
    fetchOrderResult,
    acceptOrderResult,
    updateStatusResult,
    currentOrder,
    customer,
    orderStatus,
  ];

  @override
  bool get stringify => true;

  DriverOrderState copyWith({
    OperationResult<Order>? fetchOrderResult,
    OperationResult<Order>? acceptOrderResult,
    OperationResult<Order>? updateStatusResult,
    Order? currentOrder,
    User? customer,
    OrderStatus? orderStatus,
  }) {
    return DriverOrderState(
      fetchOrderResult: fetchOrderResult ?? this.fetchOrderResult,
      acceptOrderResult: acceptOrderResult ?? this.acceptOrderResult,
      updateStatusResult: updateStatusResult ?? this.updateStatusResult,
      currentOrder: currentOrder ?? this.currentOrder,
      customer: customer ?? this.customer,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}
