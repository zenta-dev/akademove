import 'package:akademove/core/_export.dart';
import 'package:akademove/core/response.dart';
import 'package:api_client/api_client.dart';

class MerchantRepository extends BaseRepository {
  const MerchantRepository({required this.apiClient});

  final ApiClient apiClient;

  Future<BaseResponse<Merchant>> getMine() {
    return guard(() async {
      final res = await apiClient.getMerchantApi().merchantGetMine();

      final data =
          res.data?.body ??
          (throw const RepositoryError(
            'Merchant not found',
            code: ErrorCode.UNKNOWN,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
