part of '_export.dart';

class DriverScheduleState extends Equatable {
  const DriverScheduleState({
    this.fetchSchedulesResult = const OperationResult.idle(),
    this.createScheduleResult = const OperationResult.idle(),
    this.updateScheduleResult = const OperationResult.idle(),
    this.deleteScheduleResult = const OperationResult.idle(),
    this.schedules = const [],
    this.selectedSchedule,
  });

  final OperationResult<List<DriverSchedule>> fetchSchedulesResult;
  final OperationResult<DriverSchedule> createScheduleResult;
  final OperationResult<DriverSchedule> updateScheduleResult;
  final OperationResult<bool> deleteScheduleResult;

  final List<DriverSchedule> schedules;
  final DriverSchedule? selectedSchedule;

  bool get isLoading =>
      fetchSchedulesResult.isLoading ||
      createScheduleResult.isLoading ||
      updateScheduleResult.isLoading ||
      deleteScheduleResult.isLoading;

  bool get isFailure =>
      fetchSchedulesResult.isFailure ||
      createScheduleResult.isFailure ||
      updateScheduleResult.isFailure ||
      deleteScheduleResult.isFailure;

  BaseError? get error =>
      fetchSchedulesResult.error ??
      createScheduleResult.error ??
      updateScheduleResult.error ??
      deleteScheduleResult.error;

  @override
  List<Object?> get props => [
    fetchSchedulesResult,
    createScheduleResult,
    updateScheduleResult,
    deleteScheduleResult,
    schedules,
    selectedSchedule,
  ];

  @override
  bool get stringify => true;

  DriverScheduleState copyWith({
    OperationResult<List<DriverSchedule>>? fetchSchedulesResult,
    OperationResult<DriverSchedule>? createScheduleResult,
    OperationResult<DriverSchedule>? updateScheduleResult,
    OperationResult<bool>? deleteScheduleResult,
    List<DriverSchedule>? schedules,
    DriverSchedule? selectedSchedule,
  }) {
    return DriverScheduleState(
      fetchSchedulesResult: fetchSchedulesResult ?? this.fetchSchedulesResult,
      createScheduleResult: createScheduleResult ?? this.createScheduleResult,
      updateScheduleResult: updateScheduleResult ?? this.updateScheduleResult,
      deleteScheduleResult: deleteScheduleResult ?? this.deleteScheduleResult,
      schedules: schedules ?? this.schedules,
      selectedSchedule: selectedSchedule ?? this.selectedSchedule,
    );
  }
}
