import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class MerchantRepository extends BaseRepository {
  const MerchantRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<Merchant>> getMine() {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantGetMine();

      final data =
          res.data?.body ??
          (throw const RepositoryError(
            'Merchant not found',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<List<Merchant>>> getPopulars() {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantPopulars();

      final data =
          res.data ??
          (throw const RepositoryError(
            'Merchant not found',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  // TODO: Uncomment once API client is regenerated from OpenAPI spec
  // After running: bun run generate from project root

  // Future<BaseResponse<List<Merchant>>> getByCategory({
  //   required String category,
  // }) {
  //   return guard(() async {
  //     final res = await _apiClient.getMerchantApi().merchantList(
  //       category: category,
  //     );
  //     final data = res.data ?? (throw const RepositoryError('Merchants not found', code: ErrorCode.unknown));
  //     return SuccessResponse(message: data.message, data: data.data);
  //   });
  // }

  // Future<BaseResponse<List<MerchantMenu>>> getBestSellers({
  //   String? category,
  //   int limit = 10,
  // }) {
  //   return guard(() async {
  //     final res = await _apiClient.getMerchantApi().merchantBestSellers(
  //       category: category,
  //       limit: limit,
  //     );
  //     final data = res.data ?? (throw const RepositoryError('Best sellers not found', code: ErrorCode.unknown));
  //     return SuccessResponse(message: data.message, data: data.data);
  //   });
  // }
}
