import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class MerchantWalletRepository extends BaseRepository {
  MerchantWalletRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<Wallet>> getWallet({required String merchantId}) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantWalletGetWallet(
        merchantId: merchantId,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Merchant wallet not found',
            code: ErrorCode.notFound,
          ));
      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<WalletMonthlySummaryResponse>> getMonthlySummary({
    required String merchantId,
    required int month,
    required int year,
  }) {
    return guard(() async {
      final res = await _apiClient
          .getMerchantApi()
          .merchantWalletGetMonthlySummary(
            merchantId: merchantId,
            month: month,
            year: year,
          );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Monthly summary not found',
            code: ErrorCode.notFound,
          ));
      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Payment>> withdraw({
    required String merchantId,
    required WithdrawRequest request,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantWalletWithdraw(
        merchantId: merchantId,
        withdrawRequest: request,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to withdraw',
            code: ErrorCode.unknown,
          ));
      return SuccessResponse(message: data.message, data: data.data);
    });
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
  getSavedBankAccount({required String merchantId}) {
    return guard(() async {
      final res = await _apiClient
          .getMerchantApi()
          .merchantWalletGetSavedBankAccount(merchantId: merchantId);
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to get saved bank account',
            code: ErrorCode.unknown,
          ));
      final savedBank = data.data;
      return SuccessResponse(
        message: data.message,
        data: (
          hasSavedBank: savedBank.hasSavedBank,
          bankProvider: savedBank.bankProvider,
          accountNumber: savedBank.accountNumber,
          accountName: savedBank.accountName,
        ),
      );
    });
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
    return guard(() async {
      final res = await _apiClient.getPaymentApi().bankValidateAccount(
        bankValidationRequest: BankValidationRequest(
          bankProvider: bankProvider,
          accountNumber: accountNumber,
        ),
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to validate bank account',
            code: ErrorCode.unknown,
          ));
      final validation = data.data;
      return SuccessResponse(
        message: data.message,
        data: (
          isValid: validation.isValid,
          accountName: validation.accountName,
          bankCode: validation.bankCode,
          accountNumber: validation.accountNumber,
        ),
      );
    });
  }
}
