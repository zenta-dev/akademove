part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverScheduleState extends BaseState2 with DriverScheduleStateMappable {
  DriverScheduleState({
    super.state,
    super.message,
    super.error,
    this.schedules = const [],
    this.selectedSchedule,
  });

  final List<DriverSchedule> schedules;
  final DriverSchedule? selectedSchedule;

  @override
  DriverScheduleState toInitial() => DriverScheduleState();

  @override
  DriverScheduleState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverScheduleState toSuccess({
    String? message,
    List<DriverSchedule>? schedules,
    DriverSchedule? selectedSchedule,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    schedules: schedules ?? this.schedules,
    selectedSchedule: selectedSchedule ?? this.selectedSchedule,
  );

  @override
  DriverScheduleState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
