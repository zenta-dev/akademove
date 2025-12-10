import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class TransactionRepository extends BaseRepository {
  TransactionRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<List<Transaction>>> list() {
    return guard(() async {
      final res = await _apiClient.getTransactionApi().transactionList();

      final data =
          res.data ??
          (throw const RepositoryError(
            'Transactions not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
