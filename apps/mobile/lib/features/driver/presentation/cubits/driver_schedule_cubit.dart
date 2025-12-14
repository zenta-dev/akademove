import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/repositories/_export.dart';
import 'package:akademove/features/driver/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

/// Cubit for managing driver schedules (class times that disable order acceptance).
///
/// This cubit requires a driverId to be set via [setDriverId] before calling
/// any schedule methods. The driverId should come from [DriverProfileCubit].
class DriverScheduleCubit extends BaseCubit<DriverScheduleState> {
  DriverScheduleCubit({required DriverRepository driverRepository})
    : _driverRepository = driverRepository,
      super(const DriverScheduleState());

  final DriverRepository _driverRepository;
  String? _driverId;

  /// Set the driver ID. Call this before using any schedule methods.
  /// The driverId should come from DriverProfileCubit.driver.id.
  void setDriverId(String? driverId) {
    _driverId = driverId;
  }

  /// Get current driver ID.
  String? get driverId => _driverId;

  Future<void> getSchedules() async => await taskManager.execute(
    'DSC-lS1',
    () async {
      final driverId = _driverId;
      if (driverId == null) {
        logger.w(
          '[DriverScheduleCubit] - getSchedules called without driverId',
        );
        return;
      }

      try {
        emit(
          state.copyWith(fetchSchedulesResult: const OperationResult.loading()),
        );

        final res = await _driverRepository.listSchedules(driverId);

        emit(
          state.copyWith(
            fetchSchedulesResult: OperationResult.success(res.data),
            schedules: res.data,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[DriverScheduleCubit] - Error loading schedules: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(fetchSchedulesResult: OperationResult.failed(e)));
      }
    },
  );

  Future<void> getSchedule({
    required String scheduleId,
  }) async => await taskManager.execute('DSC-gS2-$scheduleId', () async {
    final driverId = _driverId;
    if (driverId == null) {
      logger.w('[DriverScheduleCubit] - getSchedule called without driverId');
      return;
    }

    try {
      emit(
        state.copyWith(fetchSchedulesResult: const OperationResult.loading()),
      );

      final res = await _driverRepository.getSchedule(
        driverId: driverId,
        scheduleId: scheduleId,
      );
      emit(state.copyWith(selectedSchedule: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverScheduleCubit] - Error loading schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(fetchSchedulesResult: OperationResult.failed(e)));
    }
  });

  Future<void> createSchedule({
    required DriverScheduleCreateRequest request,
  }) async => await taskManager.execute('DSC-cS3', () async {
    final driverId = _driverId;
    if (driverId == null) {
      logger.w(
        '[DriverScheduleCubit] - createSchedule called without driverId',
      );
      return;
    }

    try {
      emit(
        state.copyWith(createScheduleResult: const OperationResult.loading()),
      );

      final res = await _driverRepository.createSchedule(
        driverId: driverId,
        request: request.copyWith(driverId: driverId),
      );
      emit(
        state.copyWith(
          createScheduleResult: OperationResult.success(res.data),
          selectedSchedule: res.data,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverScheduleCubit] - Error creating schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(createScheduleResult: OperationResult.failed(e)));
    }
  });

  Future<void> updateSchedule({
    required String scheduleId,
    required DriverScheduleUpdateRequest request,
  }) async => await taskManager.execute('DSC-uS4-$scheduleId', () async {
    final driverId = _driverId;
    if (driverId == null) {
      logger.w(
        '[DriverScheduleCubit] - updateSchedule called without driverId',
      );
      return;
    }

    try {
      emit(
        state.copyWith(updateScheduleResult: const OperationResult.loading()),
      );

      final res = await _driverRepository.updateSchedule(
        driverId: driverId,
        scheduleId: scheduleId,
        request: request,
      );
      emit(
        state.copyWith(
          updateScheduleResult: OperationResult.success(res.data),
          selectedSchedule: res.data,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverScheduleCubit] - Error updating schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(updateScheduleResult: OperationResult.failed(e)));
    }
  });

  Future<void> removeSchedule({required String scheduleId}) async =>
      await taskManager.execute('DSC-rS4-$scheduleId', () async {
        final driverId = _driverId;
        if (driverId == null) {
          logger.w(
            '[DriverScheduleCubit] - removeSchedule called without driverId',
          );
          return;
        }

        try {
          emit(
            state.copyWith(
              deleteScheduleResult: const OperationResult.loading(),
            ),
          );

          await _driverRepository.removeSchedule(
            driverId: driverId,
            scheduleId: scheduleId,
          );

          final schedules = state.fetchSchedulesResult.value ?? [];
          final excluded = schedules.where((s) => s.id != scheduleId).toList();
          emit(
            state.copyWith(
              deleteScheduleResult: OperationResult.success(true),
              fetchSchedulesResult: OperationResult.success(excluded),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverScheduleCubit] - Error removing schedule: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(deleteScheduleResult: OperationResult.failed(e)));
        }
      });

  void reset() {
    _driverId = null;
    emit(const DriverScheduleState());
  }
}
