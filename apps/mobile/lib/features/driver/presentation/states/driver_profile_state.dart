part of '_export.dart';

/// State for [DriverProfileCubit].
///
/// This cubit owns the [Driver] object as the single source of truth
/// for driver profile data within the driver role. It also manages
/// today's stats (earnings and trips).
class DriverProfileState extends Equatable {
  const DriverProfileState({
    this.driver,
    this.initResult = const OperationResult.idle(),
    this.fetchProfileResult = const OperationResult.idle(),
    this.updateProfileResult = const OperationResult.idle(),
    this.updatePasswordResult = const OperationResult.idle(),
    this.toggleOnlineResult = const OperationResult.idle(),
    this.refreshStatsResult = const OperationResult.idle(),
    this.todayEarnings,
    this.todayTrips,
  });

  /// The current driver profile. This is the single source of truth.
  final Driver? driver;

  /// Operation result for initial load (profile + stats).
  final OperationResult<Driver> initResult;

  /// Operation result for fetching profile.
  final OperationResult<Driver> fetchProfileResult;

  /// Operation result for updating profile.
  final OperationResult<Driver> updateProfileResult;

  /// Operation result for updating password.
  final OperationResult<bool> updatePasswordResult;

  /// Operation result for toggling online status.
  final OperationResult<Driver> toggleOnlineResult;

  /// Operation result for refreshing stats.
  final OperationResult<bool> refreshStatsResult;

  /// Today's earnings (after platform commission deduction).
  final num? todayEarnings;

  /// Today's completed trip count.
  final int? todayTrips;

  /// Convenience getter for driver's online status.
  bool get isOnline => driver?.isOnline ?? false;

  @override
  List<Object?> get props => [
    driver,
    initResult,
    fetchProfileResult,
    updateProfileResult,
    updatePasswordResult,
    toggleOnlineResult,
    refreshStatsResult,
    todayEarnings,
    todayTrips,
  ];

  @override
  bool get stringify => true;

  DriverProfileState copyWith({
    Driver? driver,
    OperationResult<Driver>? initResult,
    OperationResult<Driver>? fetchProfileResult,
    OperationResult<Driver>? updateProfileResult,
    OperationResult<bool>? updatePasswordResult,
    OperationResult<Driver>? toggleOnlineResult,
    OperationResult<bool>? refreshStatsResult,
    num? todayEarnings,
    int? todayTrips,
  }) {
    return DriverProfileState(
      driver: driver ?? this.driver,
      initResult: initResult ?? this.initResult,
      fetchProfileResult: fetchProfileResult ?? this.fetchProfileResult,
      updateProfileResult: updateProfileResult ?? this.updateProfileResult,
      updatePasswordResult: updatePasswordResult ?? this.updatePasswordResult,
      toggleOnlineResult: toggleOnlineResult ?? this.toggleOnlineResult,
      refreshStatsResult: refreshStatsResult ?? this.refreshStatsResult,
      todayEarnings: todayEarnings ?? this.todayEarnings,
      todayTrips: todayTrips ?? this.todayTrips,
    );
  }
}
