import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class WalletRepository extends BaseRepository {
  WalletRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

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
      return SuccessResponse(message: data.message, data: data.data);
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
      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<List<Transaction>>> getTransactions() {
    return guard(() async {
      final res = await _apiClient.getWalletApi().walletTransactions();

      final data =
          res.data ??
          (throw const RepositoryError(
            'Transactions not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Payment>> pay(PayRequest req) {
    return guard(() async {
      final res = await _apiClient.getWalletApi().walletPay(payRequest: req);
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to pay',
            code: ErrorCode.notFound,
          ));
      return SuccessResponse(message: data.message, data: data.data);
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
      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
