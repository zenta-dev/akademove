// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    this.pickupLocation,
    this.dropoffLocation,
    // this.isPolling = false,
  });

  final OperationResult<EstimateOrderResult> estimateOrder;
  final OperationResult<List<Order>> orderHistories;
  final OperationResult<Order> selectedOrder;

  final OperationResult<Order> currentOrder;
  final OperationResult<Payment> currentPayment;
  final OperationResult<Transaction> currentTransaction;
  final OperationResult<Driver?> currentAssignedDriver;

  final OperationResult<List<Order>> scheduledOrders;

  final OperationResult<Order> selectedScheduledOrder;

  final Place? pickupLocation;
  final Place? dropoffLocation;

  /// Whether polling is currently active for order updates
  // final bool isPolling;

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
    ?pickupLocation,
    ?dropoffLocation,
    // isPolling,
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
    Place? pickupLocation,
    Place? dropoffLocation,
    // bool? isPolling,
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
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      // isPolling: isPolling ?? this.isPolling,
    );
  }

  @override
  bool get stringify => true;
}
