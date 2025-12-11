import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:dio/dio.dart';

class MerchantCubit extends BaseCubit<MerchantState> {
  MerchantCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const MerchantState());
  final MerchantRepository _merchantRepository;

  Future<void> getMine() async => await taskManager.execute('MC-gM1', () async {
    try {
      emit(state.copyWith(mine: const OperationResult.loading()));
      final res = await _merchantRepository.getMine();
      emit(
        state.copyWith(
          mine: OperationResult.success(res.data, message: res.message),
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
          // Also update the 'mine' state with the new merchant data
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

  /// Clear the update profile result (useful after showing success/error message)
  void clearUpdateProfileResult() {
    emit(state.copyWith(updateProfile: const OperationResult.idle()));
  }

  void reset() => emit(const MerchantState());
}
