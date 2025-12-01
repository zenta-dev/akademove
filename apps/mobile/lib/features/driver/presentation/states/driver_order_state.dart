import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'driver_order_state.mapper.dart';

@MappableClass()
class DriverOrderState with DriverOrderStateMappable {
  const DriverOrderState({
    this.currentOrder,
    this.customer,
    this.orderStatus,
    this.isLoading = false,
    this.error,
    this.message,
    this.ongoingOperations = const {},
  });

  final Order? currentOrder;
  final User? customer;
  final OrderStatus? orderStatus;
  final bool isLoading;
  final BaseError? error;
  final String? message;
  final Set<String> ongoingOperations;

  bool get isSuccess => error == null && !isLoading;
  bool get isFailure => error != null;

  bool checkAndAssignOperation(String operationName) {
    if (ongoingOperations.contains(operationName)) return true;
    return false;
  }

  void unAssignOperation(String operationName) {
    ongoingOperations.remove(operationName);
  }

  DriverOrderState toLoading() {
    return copyWith(isLoading: true, error: null, message: null);
  }

  DriverOrderState toSuccess({
    Order? currentOrder,
    User? customer,
    OrderStatus? orderStatus,
    String? message,
  }) {
    return copyWith(
      currentOrder: currentOrder ?? this.currentOrder,
      customer: customer ?? this.customer,
      orderStatus: orderStatus ?? this.orderStatus,
      isLoading: false,
      error: null,
      message: message,
    );
  }

  DriverOrderState toFailure(BaseError error) {
    return copyWith(isLoading: false, error: error);
  }

  DriverOrderState clearOrder() {
    return copyWith(currentOrder: null, customer: null, orderStatus: null);
  }
}
