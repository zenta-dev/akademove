part of '_export.dart';

class DriverState extends Equatable {
  const DriverState({
    this.initResult = const OperationResult.idle(),
    this.toggleOnlineResult = const OperationResult.idle(),
    this.refreshProfileResult = const OperationResult.idle(),
    this.refreshStatsResult = const OperationResult.idle(),
    this.driver,
    this.activeOrder,
    this.todayEarnings,
    this.todayTrips,
  });

  final OperationResult<Driver> initResult;
  final OperationResult<Driver> toggleOnlineResult;
  final OperationResult<Driver> refreshProfileResult;
  final OperationResult<bool> refreshStatsResult;

  final Driver? driver;
  final Order? activeOrder;
  final num? todayEarnings;
  final int? todayTrips;

  bool get isLoading =>
      initResult.isLoading ||
      toggleOnlineResult.isLoading ||
      refreshProfileResult.isLoading ||
      refreshStatsResult.isLoading;

  bool get isFailure =>
      initResult.isFailure ||
      toggleOnlineResult.isFailure ||
      refreshProfileResult.isFailure ||
      refreshStatsResult.isFailure;

  BaseError? get error =>
      initResult.error ??
      toggleOnlineResult.error ??
      refreshProfileResult.error ??
      refreshStatsResult.error;

  @override
  List<Object?> get props => [
    initResult,
    toggleOnlineResult,
    refreshProfileResult,
    refreshStatsResult,
    driver,
    activeOrder,
    todayEarnings,
    todayTrips,
  ];

  DriverState copyWith({
    OperationResult<Driver>? initResult,
    OperationResult<Driver>? toggleOnlineResult,
    OperationResult<Driver>? refreshProfileResult,
    OperationResult<bool>? refreshStatsResult,
    Driver? driver,
    Order? activeOrder,
    num? todayEarnings,
    int? todayTrips,
  }) {
    return DriverState(
      initResult: initResult ?? this.initResult,
      toggleOnlineResult: toggleOnlineResult ?? this.toggleOnlineResult,
      refreshProfileResult: refreshProfileResult ?? this.refreshProfileResult,
      refreshStatsResult: refreshStatsResult ?? this.refreshStatsResult,
      driver: driver ?? this.driver,
      activeOrder: activeOrder ?? this.activeOrder,
      todayEarnings: todayEarnings ?? this.todayEarnings,
      todayTrips: todayTrips ?? this.todayTrips,
    );
  }

  @override
  bool get stringify => true;
}
