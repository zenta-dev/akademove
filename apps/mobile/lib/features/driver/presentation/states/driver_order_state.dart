part of '_export.dart';

class DriverOrderState extends Equatable {
  const DriverOrderState({
    this.fetchOrderResult = const OperationResult.idle(),
    this.acceptOrderResult = const OperationResult.idle(),
    this.rejectOrderResult = const OperationResult.idle(),
    this.markArrivedResult = const OperationResult.idle(),
    this.startTripResult = const OperationResult.idle(),
    this.completeTripResult = const OperationResult.idle(),
    this.cancelOrderResult = const OperationResult.idle(),
    this.uploadProofResult = const OperationResult.idle(),
    this.uploadItemPhotoResult = const OperationResult.idle(),
    this.recoverOrderResult = const OperationResult.idle(),
    this.currentOrder,
    this.customer,
    this.orderStatus,
    this.isPolling = false,
  });

  final OperationResult<Order> fetchOrderResult;
  final OperationResult<Order> acceptOrderResult;
  final OperationResult<Order> rejectOrderResult;
  final OperationResult<Order> markArrivedResult;
  final OperationResult<Order> startTripResult;
  final OperationResult<Order> completeTripResult;
  final OperationResult<Order> cancelOrderResult;
  final OperationResult<Order> uploadProofResult;
  final OperationResult<Order> uploadItemPhotoResult;
  final OperationResult<Order> recoverOrderResult;

  final Order? currentOrder;
  final User? customer;
  final OrderStatus? orderStatus;
  final bool isPolling;

  /// Check if there's an active order being worked on
  bool get hasActiveOrder =>
      currentOrder != null && orderStatus?.isActive == true;

  @override
  List<Object?> get props => [
    fetchOrderResult,
    acceptOrderResult,
    rejectOrderResult,
    markArrivedResult,
    startTripResult,
    completeTripResult,
    cancelOrderResult,
    uploadProofResult,
    uploadItemPhotoResult,
    recoverOrderResult,
    currentOrder,
    customer,
    orderStatus,
    isPolling,
  ];

  @override
  bool get stringify => true;

  DriverOrderState copyWith({
    OperationResult<Order>? fetchOrderResult,
    OperationResult<Order>? acceptOrderResult,
    OperationResult<Order>? rejectOrderResult,
    OperationResult<Order>? markArrivedResult,
    OperationResult<Order>? startTripResult,
    OperationResult<Order>? completeTripResult,
    OperationResult<Order>? cancelOrderResult,
    OperationResult<Order>? uploadProofResult,
    OperationResult<Order>? uploadItemPhotoResult,
    OperationResult<Order>? recoverOrderResult,
    Order? currentOrder,
    User? customer,
    OrderStatus? orderStatus,
    bool? isPolling,
  }) {
    return DriverOrderState(
      fetchOrderResult: fetchOrderResult ?? this.fetchOrderResult,
      acceptOrderResult: acceptOrderResult ?? this.acceptOrderResult,
      rejectOrderResult: rejectOrderResult ?? this.rejectOrderResult,
      markArrivedResult: markArrivedResult ?? this.markArrivedResult,
      startTripResult: startTripResult ?? this.startTripResult,
      completeTripResult: completeTripResult ?? this.completeTripResult,
      cancelOrderResult: cancelOrderResult ?? this.cancelOrderResult,
      uploadProofResult: uploadProofResult ?? this.uploadProofResult,
      uploadItemPhotoResult:
          uploadItemPhotoResult ?? this.uploadItemPhotoResult,
      recoverOrderResult: recoverOrderResult ?? this.recoverOrderResult,
      currentOrder: currentOrder ?? this.currentOrder,
      customer: customer ?? this.customer,
      orderStatus: orderStatus ?? this.orderStatus,
      isPolling: isPolling ?? this.isPolling,
    );
  }
}
