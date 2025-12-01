import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'driver_home_state.mapper.dart';

@MappableClass()
class DriverHomeState with DriverHomeStateMappable {
  const DriverHomeState({
    this.myDriver,
    this.isOnline = false,
    this.todayEarnings = 0,
    this.todayTrips = 0,
    this.currentOrder,
    this.incomingOrder,
    this.isLoading = false,
    this.error,
    this.message,
    this.ongoingOperations = const {},
  });

  final Driver? myDriver;
  final bool isOnline;
  final num todayEarnings;
  final int todayTrips;
  final Order? currentOrder;
  final Order? incomingOrder;
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

  DriverHomeState toLoading() {
    return copyWith(isLoading: true, error: null, message: null);
  }

  DriverHomeState toSuccess({
    Driver? myDriver,
    bool? isOnline,
    num? todayEarnings,
    int? todayTrips,
    Order? currentOrder,
    Order? incomingOrder,
    String? message,
  }) {
    return copyWith(
      myDriver: myDriver ?? this.myDriver,
      isOnline: isOnline ?? this.isOnline,
      todayEarnings: todayEarnings ?? this.todayEarnings,
      todayTrips: todayTrips ?? this.todayTrips,
      currentOrder: currentOrder,
      incomingOrder: incomingOrder,
      isLoading: false,
      error: null,
      message: message,
    );
  }

  DriverHomeState toFailure(BaseError error) {
    return copyWith(isLoading: false, error: error);
  }

  DriverHomeState clearIncomingOrder() {
    return copyWith(incomingOrder: null);
  }

  DriverHomeState clearCurrentOrder() {
    return copyWith(currentOrder: null);
  }
}
