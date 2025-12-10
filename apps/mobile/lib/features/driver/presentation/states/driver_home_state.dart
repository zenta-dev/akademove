part of '_export.dart';

class DriverHomeState extends Equatable {
  const DriverHomeState({
    this.initResult = const OperationResult.idle(),
    this.toggleOnlineResult = const OperationResult.idle(),
    this.myDriver,
    this.isOnline = false,
    this.todayEarnings = 0,
    this.todayTrips = 0,
    this.currentOrder,
    this.incomingOrder,
  });

  final OperationResult<Driver> initResult;
  final OperationResult<Driver> toggleOnlineResult;

  final Driver? myDriver;
  final bool isOnline;
  final num todayEarnings;
  final int todayTrips;
  final Order? currentOrder;
  final Order? incomingOrder;

  @override
  List<Object?> get props => [
    initResult,
    toggleOnlineResult,
    myDriver,
    isOnline,
    todayEarnings,
    todayTrips,
    currentOrder,
    incomingOrder,
  ];

  @override
  bool get stringify => true;

  DriverHomeState copyWith({
    OperationResult<Driver>? initResult,
    OperationResult<Driver>? toggleOnlineResult,
    Driver? myDriver,
    bool? isOnline,
    num? todayEarnings,
    int? todayTrips,
    Order? currentOrder,
    Order? incomingOrder,
  }) {
    return DriverHomeState(
      initResult: initResult ?? this.initResult,
      toggleOnlineResult: toggleOnlineResult ?? this.toggleOnlineResult,
      myDriver: myDriver ?? this.myDriver,
      isOnline: isOnline ?? this.isOnline,
      todayEarnings: todayEarnings ?? this.todayEarnings,
      todayTrips: todayTrips ?? this.todayTrips,
      currentOrder: currentOrder ?? this.currentOrder,
      incomingOrder: incomingOrder ?? this.incomingOrder,
    );
  }
}
