part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverState extends BaseState2 with DriverStateMappable {
  DriverState({
    super.state,
    super.message,
    super.error,
    this.driver,
    this.activeOrder,
    this.todayEarnings,
    this.todayTrips,
  });

  final Driver? driver;
  final Order? activeOrder;
  final num? todayEarnings;
  final int? todayTrips;

  @override
  DriverState toInitial() => DriverState();

  @override
  DriverState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverState toSuccess({
    String? message,
    Driver? driver,
    bool? isOnline,
    Order? activeOrder,
    num? todayEarnings,
    int? todayTrips,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    driver: driver ?? this.driver,
    activeOrder: activeOrder ?? this.activeOrder,
    todayEarnings: todayEarnings ?? this.todayEarnings,
    todayTrips: todayTrips ?? this.todayTrips,
  );

  @override
  DriverState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
