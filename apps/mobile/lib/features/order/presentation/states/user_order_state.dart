part of '_export.dart';

class UserOrderState extends Equatable {
  const UserOrderState({
    this.estimateOrder = const OperationResult.idle(),
    this.orderHistories = const OperationResult.idle(),
    this.selectedOrder = const OperationResult.idle(),
    this.currentOrder = const OperationResult.idle(),
    this.currentPayment = const OperationResult.idle(),
    this.currentTransaction = const OperationResult.idle(),
    this.currentAssignedDriver = const OperationResult.idle(),
    this.scheduledOrders = const OperationResult.idle(),
    this.selectedScheduledOrder = const OperationResult.idle(),
  });

  final OperationResult<EstimateOrderResult> estimateOrder;
  final OperationResult<List<Order>> orderHistories;
  final OperationResult<Order> selectedOrder;

  final OperationResult<Order> currentOrder;
  final OperationResult<Payment> currentPayment;
  final OperationResult<Transaction> currentTransaction;
  final OperationResult<Driver?> currentAssignedDriver;

  /// List of scheduled orders for the user
  final OperationResult<List<Order>> scheduledOrders;

  /// Currently selected scheduled order for viewing/editing
  final OperationResult<Order> selectedScheduledOrder;

  // Convenience getters mainly for scheduled orders as that was the error context
  bool get isLoading =>
      scheduledOrders.isLoading; // Add others if needed contextually
  bool get isFailure => scheduledOrders.isFailure;
  BaseError? get error => scheduledOrders.error;

  @override
  List<Object> get props => [
    estimateOrder,
    orderHistories,
    selectedOrder,
    currentOrder,
    currentPayment,
    currentTransaction,
    currentAssignedDriver,
    scheduledOrders,
    selectedScheduledOrder,
  ];

  UserOrderState copyWith({
    OperationResult<EstimateOrderResult>? estimateOrder,
    OperationResult<List<Order>>? orderHistories,
    OperationResult<Order>? selectedOrder,
    OperationResult<Order>? currentOrder,
    OperationResult<Payment>? currentPayment,
    OperationResult<Transaction>? currentTransaction,
    OperationResult<Driver?>? currentAssignedDriver,
    OperationResult<List<Order>>? scheduledOrders,
    OperationResult<Order>? selectedScheduledOrder,
  }) {
    return UserOrderState(
      estimateOrder: estimateOrder ?? this.estimateOrder,
      orderHistories: orderHistories ?? this.orderHistories,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      currentOrder: currentOrder ?? this.currentOrder,
      currentPayment: currentPayment ?? this.currentPayment,
      currentTransaction: currentTransaction ?? this.currentTransaction,
      currentAssignedDriver:
          currentAssignedDriver ?? this.currentAssignedDriver,
      scheduledOrders: scheduledOrders ?? this.scheduledOrders,
      selectedScheduledOrder:
          selectedScheduledOrder ?? this.selectedScheduledOrder,
    );
  }

  @override
  bool get stringify => true;
}
