import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class DriverUpdateProfileRequest {
  const DriverUpdateProfileRequest({
    this.name,
    this.email,
    this.photoPath,
    this.phone,
    this.studentId,
    this.licensePlate,
    this.studentCardPath,
    this.driverLicensePath,
    this.vehicleCertificatePath,
    this.bank,
  });

  final String? name;
  final String? email;
  final String? photoPath;
  final Phone? phone;
  final num? studentId;
  final String? licensePlate;
  final String? studentCardPath;
  final String? driverLicensePath;
  final String? vehicleCertificatePath;
  final Bank? bank;
}

class DriverProfileCubit extends BaseCubit<DriverProfileState> {
  DriverProfileCubit({required DriverRepository driverRepository})
    : _driverRepository = driverRepository,
      super(const DriverProfileState());

  final DriverRepository _driverRepository;

  Future<void> loadProfile() async =>
      await taskManager.execute('DPC-lP1', () async {
        try {
          emit(
            state.copyWith(fetchProfileResult: const OperationResult.loading()),
          );

          final res = await _driverRepository.getMine();

          emit(
            state.copyWith(
              fetchProfileResult: OperationResult.success(res.data),
              myDriver: res.data,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverProfileCubit] - Error loading profile: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(fetchProfileResult: OperationResult.failed(e)));
        }
      });

  Future<void> updateDriverProfile({
    num? studentId,
    String? licensePlate,
    MultipartFile? studentCard,
    MultipartFile? driverLicense,
    MultipartFile? vehicleCertificate,
    Bank? bank,
  }) async => await taskManager.execute(
    'DPC-uP2-${state.myDriver?.id}',
    () async {
      final driver = state.myDriver;
      if (driver == null) return;

      try {
        emit(
          state.copyWith(updateProfileResult: const OperationResult.loading()),
        );

        final res = await _driverRepository.update(
          driverId: driver.id,
          studentId: studentId,
          licensePlate: licensePlate,
          studentCard: studentCard,
          driverLicense: driverLicense,
          vehicleCertificate: vehicleCertificate,
          bank: bank,
        );

        emit(
          state.copyWith(
            updateProfileResult: OperationResult.success(res.data),
            myDriver: res.data,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[DriverProfileCubit] - Error updating profile: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(updateProfileResult: OperationResult.failed(e)));
      }
    },
  );

  Future<List<DriverSchedule>> loadSchedules() async =>
      await taskManager.execute('DPC-lS1', () async {
        final driver = state.myDriver;
        if (driver == null) return [];

        try {
          final res = await _driverRepository.listSchedules(driver.id);

          return res.data;
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverProfileCubit] - Error loading schedules: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(fetchProfileResult: OperationResult.failed(e)));
          return [];
        }
      });

  Future<void> createSchedule({
    required String name,
    required DayOfWeek dayOfWeek,
    required Time startTime,
    required Time endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  }) async => await taskManager.execute('DPC-cS2-$name', () async {
    final driver = state.myDriver;
    if (driver == null) return;

    try {
      emit(
        state.copyWith(updateProfileResult: const OperationResult.loading()),
      );

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

      emit(
        state.copyWith(updateProfileResult: OperationResult.success(driver)),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error creating schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(updateProfileResult: OperationResult.failed(e)));
    }
  });

  Future<void> updateSchedule({
    required String scheduleId,
    String? name,
    DayOfWeek? dayOfWeek,
    Time? startTime,
    Time? endTime,
    bool? isRecurring,
    DateTime? specificDate,
    bool? isActive,
  }) async => await taskManager.execute('DPC-uS3-$scheduleId', () async {
    final driver = state.myDriver;
    if (driver == null) return;

    try {
      emit(
        state.copyWith(updateProfileResult: const OperationResult.loading()),
      );

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

      emit(
        state.copyWith(updateProfileResult: OperationResult.success(driver)),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error updating schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(updateProfileResult: OperationResult.failed(e)));
    }
  });

  Future<void> deleteSchedule(
    String scheduleId,
  ) async => await taskManager.execute('DPC-dS4-$scheduleId', () async {
    final driver = state.myDriver;
    if (driver == null) return;

    try {
      emit(
        state.copyWith(updateProfileResult: const OperationResult.loading()),
      );

      await _driverRepository.removeSchedule(
        driverId: driver.id,
        scheduleId: scheduleId,
      );

      emit(
        state.copyWith(updateProfileResult: OperationResult.success(driver)),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - Error deleting schedule: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(updateProfileResult: OperationResult.failed(e)));
    }
  });

  Future<void> updateProfile(DriverUpdateProfileRequest req) async =>
      await taskManager.execute('DPC-uP5-${state.myDriver?.id}', () async {
        final driver = state.myDriver;
        if (driver == null) return;

        try {
          emit(
            state.copyWith(
              updateProfileResult: const OperationResult.loading(),
            ),
          );

          final photoPath = req.photoPath;
          final photo = photoPath != null
              ? await MultipartFile.fromFile(photoPath)
              : null;

          final studentCardPath = req.studentCardPath;
          final studentCard = studentCardPath != null
              ? await MultipartFile.fromFile(studentCardPath)
              : null;

          final driverLicensePath = req.driverLicensePath;
          final driverLicense = driverLicensePath != null
              ? await MultipartFile.fromFile(driverLicensePath)
              : null;

          final vehicleCertificatePath = req.vehicleCertificatePath;
          final vehicleCertificate = vehicleCertificatePath != null
              ? await MultipartFile.fromFile(vehicleCertificatePath)
              : null;

          final res = await _driverRepository.update(
            driverId: driver.id,
            studentId: req.studentId,
            licensePlate: req.licensePlate,
            studentCard: studentCard ?? photo,
            driverLicense: driverLicense,
            vehicleCertificate: vehicleCertificate,
            bank: req.bank,
          );

          emit(
            state.copyWith(
              updateProfileResult: OperationResult.success(res.data),
              myDriver: res.data,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverProfileCubit] - Error updating profile: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(updateProfileResult: OperationResult.failed(e)));
        }
      });

  Future<void> updatePassword(UserMeChangePasswordRequest req) async =>
      await taskManager.execute('DPC-uP6-${state.myDriver?.id}', () async {
        try {
          emit(
            state.copyWith(
              updatePasswordResult: const OperationResult.loading(),
            ),
          );

          final res = await _driverRepository.updatePassword(req);

          emit(
            state.copyWith(
              updatePasswordResult: OperationResult.success(res.data),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverProfileCubit] - Error updating password: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(updatePasswordResult: OperationResult.failed(e)));
        }
      });

  void reset() {
    emit(
      state.copyWith(
        updateProfileResult: const OperationResult.idle(),
        updatePasswordResult: const OperationResult.idle(),
      ),
    );
  }
}
