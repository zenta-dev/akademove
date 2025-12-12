import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class MerchantWalletCubit extends BaseCubit<MerchantWalletState> {
  MerchantWalletCubit({
    required MerchantWalletRepository merchantWalletRepository,
  }) : _merchantWalletRepository = merchantWalletRepository,
       super(const MerchantWalletState());

  final MerchantWalletRepository _merchantWalletRepository;

  Future<void> init(String merchantId) async {
    await Future.wait([getWallet(merchantId), getMonthlySummary(merchantId)]);
  }

  void reset() {
    emit(const MerchantWalletState());
  }

  Future<void> getWallet(String merchantId) async {
    await taskManager.execute("getWallet", () async {
      try {
        emit(state.copyWith(wallet: const OperationResult.loading()));
        final res = await _merchantWalletRepository.getWallet(
          merchantId: merchantId,
        );
        emit(
          state.copyWith(
            wallet: OperationResult.success(res.data, message: res.message),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          "[MerchantWalletCubit] - Error: ${e.message}",
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(wallet: OperationResult.failed(e)));
      }
    });
  }

  Future<void> getMonthlySummary(String merchantId) async {
    await taskManager.execute("getMonthlySummary", () async {
      try {
        emit(state.copyWith(monthlySummary: const OperationResult.loading()));
        final now = DateTime.now();
        final res = await _merchantWalletRepository.getMonthlySummary(
          merchantId: merchantId,
          month: now.month,
          year: now.year,
        );
        emit(
          state.copyWith(
            monthlySummary: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          "[MerchantWalletCubit] - Error: ${e.message}",
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(monthlySummary: OperationResult.failed(e)));
      }
    });
  }

  Future<BaseResponse<Payment>> withdraw({
    required String merchantId,
    required WithdrawRequest request,
  }) {
    return _merchantWalletRepository.withdraw(
      merchantId: merchantId,
      request: request,
    );
  }

  Future<
    BaseResponse<
      ({
        bool hasSavedBank,
        BankProvider? bankProvider,
        String? accountNumber,
        String? accountName,
      })
    >
  >
  getSavedBankAccount(String merchantId) {
    return _merchantWalletRepository.getSavedBankAccount(
      merchantId: merchantId,
    );
  }

  Future<
    BaseResponse<
      ({
        bool isValid,
        String? accountName,
        String bankCode,
        String accountNumber,
      })
    >
  >
  validateBankAccount({
    required BankProvider bankProvider,
    required String accountNumber,
  }) {
    return _merchantWalletRepository.validateBankAccount(
      bankProvider: bankProvider,
      accountNumber: accountNumber,
    );
  }
}
