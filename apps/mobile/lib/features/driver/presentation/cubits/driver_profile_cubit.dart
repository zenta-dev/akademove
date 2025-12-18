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

/// Cubit for managing driver profile, online status, and daily stats.
///
/// This cubit owns the [Driver] object as the single source of truth.
/// Other cubits that need driver data should read from this cubit's state.
class DriverProfileCubit extends BaseCubit<DriverProfileState> {
  DriverProfileCubit({
    required DriverRepository driverRepository,
    required UserRepository userRepository,
  }) : _driverRepository = driverRepository,
       _userRepository = userRepository,
       super(const DriverProfileState());

  final DriverRepository _driverRepository;
  final UserRepository _userRepository;

  /// Get current driver from state (single source of truth).
  Driver? get driver => state.driver;

  /// Initialize the cubit - loads driver profile and today's stats.
  Future<void> init() async {
    try {
      emit(state.copyWith(initResult: const OperationResult.loading()));

      // Get driver profile
      final driverRes = await _driverRepository.getMine();
      final driverData = driverRes.data;

      // Get today's stats using server-side analytics API
      final analyticsRes = await _driverRepository.getAnalytics(
        driverId: driverData.id,
        period: 'today',
      );

      emit(
        state.copyWith(
          driver: driverData,
          initResult: OperationResult.success(driverData),
          todayEarnings: analyticsRes.data.totalEarnings,
          todayTrips: analyticsRes.data.completedOrders.toInt(),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverProfileCubit] - init error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(initResult: OperationResult.failed(e)));
    }
  }

  /// Refresh today's stats only.
  Future<void> refreshStats() async =>
      await taskManager.execute('DPC-rS1', () async {
        final currentDriver = state.driver;
        if (currentDriver == null) return;

        try {
          emit(
            state.copyWith(refreshStatsResult: const OperationResult.loading()),
          );

          // Get today's stats using server-side analytics API
          final analyticsRes = await _driverRepository.getAnalytics(
            driverId: currentDriver.id,
            period: 'today',
          );

          emit(
            state.copyWith(
              refreshStatsResult: OperationResult.success(true),
              todayEarnings: analyticsRes.data.totalEarnings,
              todayTrips: analyticsRes.data.completedOrders.toInt(),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverProfileCubit] - refreshStats error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          // Don't emit error for stats refresh failure
        }
      });

  /// Load driver profile from server (alias for refreshProfile).
  Future<void> loadProfile() async =>
      await taskManager.execute('DPC-lP1', () async {
        try {
          emit(
            state.copyWith(fetchProfileResult: const OperationResult.loading()),
          );

          final res = await _driverRepository.getMine();

          emit(
            state.copyWith(
              driver: res.data,
              fetchProfileResult: OperationResult.success(res.data),
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

  /// Toggle driver online/offline status.
  Future<void> toggleOnlineStatus() async =>
      await taskManager.execute('DPC-tOS1', () async {
        final currentDriver = state.driver;
        if (currentDriver == null) return;

        try {
          final newStatus = !currentDriver.isOnline;

          emit(
            state.copyWith(toggleOnlineResult: const OperationResult.loading()),
          );

          // Optimistic update
          emit(
            state.copyWith(driver: currentDriver.copyWith(isOnline: newStatus)),
          );

          final res = await _driverRepository.updateOnlineStatus(
            driverId: currentDriver.id,
            isOnline: newStatus,
          );

          emit(
            state.copyWith(
              driver: res.data,
              toggleOnlineResult: OperationResult.success(res.data),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverProfileCubit] - toggleOnlineStatus error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          // Revert optimistic update
          emit(
            state.copyWith(
              driver: currentDriver,
              toggleOnlineResult: OperationResult.failed(e),
            ),
          );
        }
      });

  /// Update driver profile with driver-specific fields.
  Future<void> updateDriverProfile({
    num? studentId,
    String? licensePlate,
    MultipartFile? studentCard,
    MultipartFile? driverLicense,
    MultipartFile? vehicleCertificate,
    Bank? bank,
  }) async => await taskManager.execute('DPC-uP2-${driver?.id}', () async {
    final currentDriver = driver;
    if (currentDriver == null) return;

    try {
      emit(
        state.copyWith(updateProfileResult: const OperationResult.loading()),
      );

      final res = await _driverRepository.update(
        driverId: currentDriver.id,
        studentId: studentId,
        licensePlate: licensePlate,
        studentCard: studentCard,
        driverLicense: driverLicense,
        vehicleCertificate: vehicleCertificate,
        bank: bank,
      );

      emit(
        state.copyWith(
          driver: res.data,
          updateProfileResult: OperationResult.success(res.data),
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

  /// Update profile with full request object.
  /// Updates both user fields (name, email, phone, photo) and driver fields
  /// (studentId, licensePlate, documents, bank).
  Future<void> updateProfile(
    DriverUpdateProfileRequest req,
  ) async => await taskManager.execute('DPC-uP5-${driver?.id}', () async {
    final currentDriver = driver;
    if (currentDriver == null) return;

    try {
      emit(
        state.copyWith(updateProfileResult: const OperationResult.loading()),
      );

      // Check if there are user fields to update
      final hasUserFields =
          req.name != null ||
          req.email != null ||
          req.phone != null ||
          req.photoPath != null;

      // Check if there are driver fields to update
      final hasDriverFields =
          req.studentId != null ||
          req.licensePlate != null ||
          req.studentCardPath != null ||
          req.driverLicensePath != null ||
          req.vehicleCertificatePath != null ||
          req.bank != null;

      // Update user fields if present
      if (hasUserFields) {
        await _userRepository.updateProfile(
          UpdateProfileRequest(
            name: req.name,
            email: req.email,
            phone: req.phone,
            photoPath: req.photoPath,
          ),
        );
      }

      // Update driver fields if present
      if (hasDriverFields) {
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

        await _driverRepository.update(
          driverId: currentDriver.id,
          studentId: req.studentId,
          licensePlate: req.licensePlate,
          studentCard: studentCard,
          driverLicense: driverLicense,
          vehicleCertificate: vehicleCertificate,
          bank: req.bank,
        );
      }

      // Fetch the updated driver profile to get all changes including user data
      final res = await _driverRepository.getMine();

      emit(
        state.copyWith(
          driver: res.data,
          updateProfileResult: OperationResult.success(res.data),
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

  /// Update password.
  Future<void> updatePassword(
    UserMeChangePasswordRequest req,
  ) async => await taskManager.execute('DPC-uP6-${driver?.id}', () async {
    try {
      emit(
        state.copyWith(updatePasswordResult: const OperationResult.loading()),
      );

      final res = await _driverRepository.updatePassword(req);

      emit(
        state.copyWith(updatePasswordResult: OperationResult.success(res.data)),
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

  /// Set driver directly (used by AuthCubit after login).
  void setDriver(Driver? driver) {
    emit(state.copyWith(driver: driver));
  }

  /// Reset state.
  void reset() {
    emit(const DriverProfileState());
  }

  /// Clear operation results (useful after showing success/error messages).
  void clearResults() {
    emit(
      state.copyWith(
        initResult: const OperationResult.idle(),
        fetchProfileResult: const OperationResult.idle(),
        updateProfileResult: const OperationResult.idle(),
        updatePasswordResult: const OperationResult.idle(),
        toggleOnlineResult: const OperationResult.idle(),
        refreshStatsResult: const OperationResult.idle(),
      ),
    );
  }
}
