import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class DriverProfileCubit extends BaseCubit<DriverProfileState> {
  DriverProfileCubit({required DriverRepository driverRepository})
    : _driverRepository = driverRepository,
      super(const DriverProfileState());

  final DriverRepository _driverRepository;

  Future<void> loadProfile() async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      final res = await _driverRepository.getMine();

      state.unAssignOperation(methodName);
      emit(state.toSuccess(myDriver: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error loading profile: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<void> updateProfile({
    num? studentId,
    String? licensePlate,
    MultipartFile? studentCard,
    MultipartFile? driverLicense,
    MultipartFile? vehicleCertificate,
    DriverUpdateRequestBank? bank,
  }) async {
    final driver = state.myDriver;
    if (driver == null) return;

    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      final res = await _driverRepository.update(
        driverId: driver.id,
        studentId: studentId,
        licensePlate: licensePlate,
        studentCard: studentCard,
        driverLicense: driverLicense,
        vehicleCertificate: vehicleCertificate,
        bank: bank,
      );

      state.unAssignOperation(methodName);
      emit(state.toSuccess(myDriver: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error updating profile: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<List<DriverSchedule>> loadSchedules() async {
    final driver = state.myDriver;
    if (driver == null) return [];

    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return [];

      final res = await _driverRepository.listSchedules(driver.id);

      state.unAssignOperation(methodName);
      return res.data;
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error loading schedules: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
      return [];
    }
  }

  Future<void> createSchedule({
    required String name,
    required DayOfWeek dayOfWeek,
    required Time startTime,
    required Time endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  }) async {
    final driver = state.myDriver;
    if (driver == null) return;

    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      await _driverRepository.createSchedule(
        driverId: driver.id,
        request: DriverScheduleCreateRequest(
          name: name,
          driverId: driver.id,
          dayOfWeek: dayOfWeek,
          startTime: startTime,
          endTime: endTime,
          isRecurring: isRecurring ?? true,
          specificDate: specificDate,
          isActive: isActive ?? true,
        ),
      );

      state.unAssignOperation(methodName);
      emit(state.toSuccess(message: 'Schedule created successfully'));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error creating schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<void> updateSchedule({
    required String scheduleId,
    String? name,
    DayOfWeek? dayOfWeek,
    Time? startTime,
    Time? endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  }) async {
    final driver = state.myDriver;
    if (driver == null) return;

    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      await _driverRepository.updateSchedule(
        driverId: driver.id,
        scheduleId: scheduleId,
        request: DriverScheduleUpdateRequest(
          name: name,
          dayOfWeek: dayOfWeek,
          startTime: startTime,
          endTime: endTime,
          isRecurring: isRecurring,
          specificDate: specificDate,
          isActive: isActive,
        ),
      );

      state.unAssignOperation(methodName);
      emit(state.toSuccess(message: 'Schedule updated successfully'));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error updating schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    final driver = state.myDriver;
    if (driver == null) return;

    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());

      await _driverRepository.removeSchedule(
        driverId: driver.id,
        scheduleId: scheduleId,
      );

      state.unAssignOperation(methodName);
      emit(state.toSuccess(message: 'Schedule deleted successfully'));
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error deleting schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }
}
