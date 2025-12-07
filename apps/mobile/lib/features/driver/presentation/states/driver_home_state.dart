part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverHomeState extends BaseState2 with DriverHomeStateMappable {
  DriverHomeState({
    super.state,
    super.message,
    super.error,
    this.myDriver,
    this.isOnline = false,
    this.todayEarnings = 0,
    this.todayTrips = 0,
    this.currentOrder,
    this.incomingOrder,
  });

  final Driver? myDriver;
  final bool isOnline;
  final num todayEarnings;
  final int todayTrips;
  final Order? currentOrder;
  final Order? incomingOrder;

  @override
  DriverHomeState toInitial() => DriverHomeState();

  @override
  DriverHomeState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverHomeState toSuccess({
    String? message,
    Driver? myDriver,
    bool? isOnline,
    num? todayEarnings,
    int? todayTrips,
    Order? currentOrder,
    Order? incomingOrder,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    myDriver: myDriver ?? this.myDriver,
    isOnline: isOnline ?? this.isOnline,
    todayEarnings: todayEarnings ?? this.todayEarnings,
    todayTrips: todayTrips ?? this.todayTrips,
    currentOrder: currentOrder ?? this.currentOrder,
    incomingOrder: incomingOrder ?? this.incomingOrder,
  );

  @override
  DriverHomeState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
