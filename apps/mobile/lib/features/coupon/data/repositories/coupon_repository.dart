import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ListCouponQuery extends UnifiedQuery {
  const ListCouponQuery({
    super.limit,
    super.page,
    super.cursor,
    super.query,
    super.sortBy,
    super.orderBy,
  });
}

class CouponRepository extends BaseRepository {
  CouponRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<List<Coupon>>> list(ListCouponQuery query) {
    return guard(() async {
      final res = await _apiClient.getCouponApi().couponList(
        cursor: query.cursor?.trim(),
        limit: query.limit,
        page: query.page,
        query: query.query?.trim(),
        sortBy: query.sortBy?.trim(),
        order: query.orderBy,
        mode: PaginationMode.cursor,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Coupons not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
