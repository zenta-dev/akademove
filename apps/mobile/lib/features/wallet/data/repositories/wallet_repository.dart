import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class WalletRepository extends BaseRepository {
  WalletRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<Wallet>> getWallet() {
    return guard(() async {
      final res = await _apiClient.getWalletApi().walletGet();
      final data =
          res.data ??
          (throw const RepositoryError(
            'Wallet not found',
            code: ErrorCode.notFound,
          ));
      return SuccessResponse(message: data.message ?? '', data: data.data);
    });
  }

  Future<BaseResponse<WalletMonthlySummaryResponse>> getMonthlySummary({
    required int month,
    required int year,
  }) {
    return guard(() async {
      final res = await _apiClient.getWalletApi().walletGetMonthlySummary(
        month: month,
        year: year,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Monthly summary not found',
            code: ErrorCode.notFound,
          ));
      return SuccessResponse(message: data.message ?? '', data: data.data);
    });
  }

  Future<BaseResponse<Payment>> topUp(TopUpRequest req) {
    return guard(() async {
      final res = await _apiClient.getWalletApi().walletTopUp(
        topUpRequest: req,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to top-up',
            code: ErrorCode.notFound,
          ));
      return SuccessResponse(message: data.message ?? '', data: data.data);
    });
  }

  Future<BaseResponse<Payment>> withdraw(WithdrawRequest req) {
    return guard(() async {
      final res = await _apiClient.getWalletApi().walletWithdraw(
        withdrawRequest: req,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to withdraw',
            code: ErrorCode.unknown,
          ));
      return SuccessResponse(message: data.message ?? '', data: data.data);
    });
  }

  Future<BaseResponse<TransferResponse>> transfer({
    required String recipientUserId,
    required int amount,
    String? note,
  }) {
    return guard(() async {
      final res = await _apiClient.getWalletApi().walletTransfer(
        transferRequest: TransferRequest(
          recipientUserId: recipientUserId,
          amount: amount,
          note: note,
        ),
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to transfer',
            code: ErrorCode.unknown,
          ));
      return SuccessResponse(message: data.message ?? '', data: data.data);
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
  getSavedBankAccount() {
    return guard(() async {
      final res = await _apiClient.getWalletApi().walletGetSavedBankAccount();
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to get saved bank account',
            code: ErrorCode.unknown,
          ));
      final savedBank = data.data;
      return SuccessResponse(
        message: data.message ?? '',
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
