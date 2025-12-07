import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/repositories/_export.dart';
import 'package:akademove/features/driver/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class DriverScheduleCubit extends BaseCubit<DriverScheduleState> {
  DriverScheduleCubit({required DriverRepository driverRepository})
    : _driverRepository = driverRepository,
      super(DriverScheduleState());

  final DriverRepository _driverRepository;
  Driver? driver;

  Future<Driver> ensureDriverLoaded() async {
    if (driver != null) return driver!;
    final res = await _driverRepository.getMine();
    driver = res.data;
    return driver!;
  }

  Future<void> getSchedules() async =>
      await taskManager.execute('DSC-lS1', () async {
        try {
          emit(state.toLoading());

          final driver = await ensureDriverLoaded();
          final res = await _driverRepository.listSchedules(driver.id);

          emit(state.toSuccess(schedules: res.data, message: res.message));
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverScheduleCubit] - Error loading schedule: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> getSchedule({required String scheduleId}) async =>
      await taskManager.execute('DSC-gS2-$scheduleId', () async {
        try {
          emit(state.toLoading());
          final driver = await ensureDriverLoaded();
          final res = await _driverRepository.getSchedule(
            driverId: driver.id,
            scheduleId: scheduleId,
          );
          emit(
            state.toSuccess(selectedSchedule: res.data, message: res.message),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverScheduleCubit] - Error loading schedule: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> createSchedule({
    required DriverScheduleCreateRequest request,
  }) async => await taskManager.execute('DSC-cS3', () async {
    try {
      emit(state.toLoading());
      final driver = await ensureDriverLoaded();
      final res = await _driverRepository.createSchedule(
        driverId: driver.id,
        request: request.copyWith(driverId: driver.id),
      );
      emit(state.toSuccess(selectedSchedule: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverScheduleCubit] - Error creating schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  });

  Future<void> updateSchedule({
    required String scheduleId,
    required DriverScheduleUpdateRequest request,
  }) async => await taskManager.execute('DSC-uS4-$scheduleId', () async {
    try {
      emit(state.toLoading());
      final driver = await ensureDriverLoaded();
      final res = await _driverRepository.updateSchedule(
        driverId: driver.id,
        scheduleId: scheduleId,
        request: request,
      );
      emit(state.toSuccess(selectedSchedule: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverScheduleCubit] - Error updating schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  });

  Future<void> removeSchedule({required String scheduleId}) async =>
      await taskManager.execute('DSC-rS4-$scheduleId', () async {
        try {
          emit(state.toLoading());

          final driver = await ensureDriverLoaded();
          await _driverRepository.removeSchedule(
            driverId: driver.id,
            scheduleId: scheduleId,
          );
          emit(
            state.toSuccess(
              message: 'Schedule removed successfully',
              schedules: state.schedules
                  .where((s) => s.id != scheduleId)
                  .toList(),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverScheduleCubit] - Error removing schedule: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  void reset() {
    emit(DriverScheduleState());
  }
}
