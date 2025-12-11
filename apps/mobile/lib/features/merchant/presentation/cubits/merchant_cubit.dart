import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class MerchantCubit extends BaseCubit<MerchantState> {
  MerchantCubit({
    required MerchantRepository merchantRepository,
    required UserRepository userRepository,
  }) : _merchantRepository = merchantRepository,
       _userRepository = userRepository,
       super(const MerchantState());

  final MerchantRepository _merchantRepository;
  final UserRepository _userRepository;

  /// Load merchant profile with proper loading/error state tracking
  Future<void> loadProfile() async =>
      await taskManager.execute('MC-loadProfile', () async {
        try {
          emit(
            state.copyWith(fetchProfileResult: const OperationResult.loading()),
          );
          final res = await _merchantRepository.getMine();
          emit(
            state.copyWith(
              fetchProfileResult: OperationResult.success(
                res.data,
                message: res.message,
              ),
              merchant: res.data,
              // Also update mine for backward compatibility
              mine: OperationResult.success(res.data, message: res.message),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantCubit] - Error loading profile: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(fetchProfileResult: OperationResult.failed(e)));
        }
      });

  /// Refresh profile - alias for loadProfile for semantic clarity
  Future<void> refreshProfile() async => loadProfile();

  /// Legacy getMine method - kept for backward compatibility
  Future<void> getMine() async => await taskManager.execute('MC-gM1', () async {
    try {
      emit(state.copyWith(mine: const OperationResult.loading()));
      final res = await _merchantRepository.getMine();
      emit(
        state.copyWith(
          mine: OperationResult.success(res.data, message: res.message),
          merchant: res.data,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(mine: OperationResult.failed(e)));
    }
  });

  /// Update merchant profile
  Future<void> updateProfile({
    required String merchantId,
    String? name,
    String? email,
    required String phoneCountryCode,
    required int phoneNumber,
    String? address,
    required num locationX,
    required num locationY,
    String? category,
    required String bankProvider,
    required num bankNumber,
    String? bankAccountName,
    MultipartFile? document,
    MultipartFile? image,
  }) async => await taskManager.execute('MC-updateProfile', () async {
    try {
      emit(state.copyWith(updateProfile: const OperationResult.loading()));
      final res = await _merchantRepository.update(
        merchantId: merchantId,
        name: name,
        email: email,
        phoneCountryCode: phoneCountryCode,
        phoneNumber: phoneNumber,
        address: address,
        locationX: locationX,
        locationY: locationY,
        category: category,
        bankProvider: bankProvider,
        bankNumber: bankNumber,
        bankAccountName: bankAccountName,
        document: document,
        image: image,
      );
      emit(
        state.copyWith(
          updateProfile: OperationResult.success(
            res.data,
            message: res.message,
          ),
          // Also update the cached merchant and 'mine' state
          merchant: res.data,
          mine: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantCubit] - Update profile error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(updateProfile: OperationResult.failed(e)));
    }
  });

  /// Update password
  Future<void> updatePassword(UserMeChangePasswordRequest req) async =>
      await taskManager.execute('MC-updatePassword', () async {
        try {
          emit(
            state.copyWith(
              updatePasswordResult: const OperationResult.loading(),
            ),
          );

          final res = await _userRepository.updatePassword(req);

          emit(
            state.copyWith(
              updatePasswordResult: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantCubit] - Error updating password: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(updatePasswordResult: OperationResult.failed(e)));
        }
      });

  /// Setup outlet - updates merchant image and category
  /// This is used in the outlet setup wizard (Step 1)
  Future<void> setupOutlet({
    required String merchantId,
    MerchantCategory? category,
    MultipartFile? image,
  }) async => await taskManager.execute('MC-setupOutlet', () async {
    try {
      emit(state.copyWith(setupOutlet: const OperationResult.loading()));
      final res = await _merchantRepository.setupOutlet(
        merchantId: merchantId,
        category: category,
        image: image,
      );
      emit(
        state.copyWith(
          setupOutlet: OperationResult.success(res.data, message: res.message),
          // Also update the cached merchant and 'mine' state
          merchant: res.data,
          mine: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantCubit] - Setup outlet error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(setupOutlet: OperationResult.failed(e)));
    }
  });

  /// Clear the update profile result (useful after showing success/error message)
  void clearUpdateProfileResult() {
    emit(state.copyWith(updateProfile: const OperationResult.idle()));
  }

  /// Clear the update password result (useful after showing success/error message)
  void clearUpdatePasswordResult() {
    emit(state.copyWith(updatePasswordResult: const OperationResult.idle()));
  }

  /// Clear the setup outlet result (useful after showing success/error message)
  void clearSetupOutletResult() {
    emit(state.copyWith(setupOutlet: const OperationResult.idle()));
  }

  /// Setup operating hours - bulk upsert weekly schedule
  /// This is used in the outlet setup wizard (Step 2)
  Future<void> setupOperatingHours({
    required String merchantId,
    required List<MerchantOperatingHoursCreateRequest> hours,
  }) async => await taskManager.execute('MC-setupOperatingHours', () async {
    try {
      emit(
        state.copyWith(setupOperatingHours: const OperationResult.loading()),
      );
      final res = await _merchantRepository.bulkUpsertOperatingHours(
        merchantId: merchantId,
        hours: hours,
      );
      emit(
        state.copyWith(
          setupOperatingHours: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantCubit] - Setup operating hours error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(setupOperatingHours: OperationResult.failed(e)));
    }
  });

  /// Clear the setup operating hours result
  void clearSetupOperatingHoursResult() {
    emit(state.copyWith(setupOperatingHours: const OperationResult.idle()));
  }

  void reset() => emit(const MerchantState());
}
