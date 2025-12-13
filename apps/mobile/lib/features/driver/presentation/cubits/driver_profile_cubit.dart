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
    required OrderRepository orderRepository,
    required ConfigurationRepository configurationRepository,
  }) : _driverRepository = driverRepository,
       _orderRepository = orderRepository,
       _configurationRepository = configurationRepository,
       super(const DriverProfileState());

  final DriverRepository _driverRepository;
  final OrderRepository _orderRepository;
  final ConfigurationRepository _configurationRepository;

  double? _platformFeeRate;

  /// Get current driver from state (single source of truth).
  Driver? get driver => state.driver;

  /// Initialize the cubit - loads driver profile and today's stats.
  Future<void> init() async {
    try {
      emit(state.copyWith(initResult: const OperationResult.loading()));

      // Get driver profile
      final driverRes = await _driverRepository.getMine();

      // Get today's stats
      final orders = await _orderRepository.list(
        const ListOrderQuery(statuses: [OrderStatus.COMPLETED]),
      );

      // Calculate today's earnings and trips
      final now = DateTime.now();
      final todayOrders = orders.data.where((order) {
        final orderDate = order.updatedAt;
        return order.status == OrderStatus.COMPLETED &&
            orderDate.year == now.year &&
            orderDate.month == now.month &&
            orderDate.day == now.day;
      }).toList();

      // Calculate driver earnings (totalPrice - platform commission)
      final todayEarnings = await _calculateDriverEarnings(todayOrders);

      emit(
        state.copyWith(
          driver: driverRes.data,
          initResult: OperationResult.success(driverRes.data),
          todayEarnings: todayEarnings,
          todayTrips: todayOrders.length,
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
        try {
          emit(
            state.copyWith(refreshStatsResult: const OperationResult.loading()),
          );

          final orders = await _orderRepository.list(
            const ListOrderQuery(statuses: [OrderStatus.COMPLETED]),
          );

          final now = DateTime.now();
          final todayOrders = orders.data.where((order) {
            final orderDate = order.updatedAt;
            return order.status == OrderStatus.COMPLETED &&
                orderDate.year == now.year &&
                orderDate.month == now.month &&
                orderDate.day == now.day;
          }).toList();

          // Calculate driver earnings (totalPrice - platform commission)
          final todayEarnings = await _calculateDriverEarnings(todayOrders);

          emit(
            state.copyWith(
              refreshStatsResult: OperationResult.success(true),
              todayEarnings: todayEarnings,
              todayTrips: todayOrders.length,
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

  /// Calculate total driver earnings from orders after platform commission.
  /// NOTE: Platform fee rate MUST come from database configuration.
  /// Fallback values are forbidden per business requirements.
  Future<num> _calculateDriverEarnings(List<Order> orders) async {
    if (orders.isEmpty) return 0;

    // Fetch platform fee rate from configuration if not already cached
    if (_platformFeeRate == null) {
      try {
        // Fetch ride pricing configuration (contains platformFeeRate)
        final configRes = await _configurationRepository.get(
          'ride-service-pricing',
        );
        final pricingConfig = configRes.data.value;

        // Parse the pricing configuration JSON
        if (pricingConfig is Map<String, Object?>) {
          final platformFeeRate = pricingConfig['platformFeeRate'];
          if (platformFeeRate is num) {
            _platformFeeRate = platformFeeRate.toDouble();
          } else {
            logger.e(
              '[DriverProfileCubit] platformFeeRate not found in configuration',
            );
            // Return 0 earnings to indicate error rather than showing wrong data
            return 0;
          }
        }
      } catch (e) {
        logger.e(
          '[DriverProfileCubit] Failed to fetch platform fee rate from database',
          error: e,
        );
        // Return 0 earnings to indicate error rather than showing wrong data
        return 0;
      }
    }

    // platformFeeRate should now be available from database
    if (_platformFeeRate == null) {
      logger.e('[DriverProfileCubit] Platform fee rate not available');
      return 0;
    }

    final driverShare = 1.0 - _platformFeeRate!;

    return orders.fold<num>(
      0,
      (sum, order) => sum + (order.totalPrice * driverShare),
    );
  }

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
  Future<void> updateProfile(DriverUpdateProfileRequest req) async =>
      await taskManager.execute('DPC-uP5-${driver?.id}', () async {
        final currentDriver = driver;
        if (currentDriver == null) return;

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
            driverId: currentDriver.id,
            studentId: req.studentId,
            licensePlate: req.licensePlate,
            studentCard: studentCard ?? photo,
            driverLicense: driverLicense,
            vehicleCertificate: vehicleCertificate,
            bank: req.bank,
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
    _platformFeeRate = null;
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
