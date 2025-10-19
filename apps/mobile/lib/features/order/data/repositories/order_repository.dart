import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ListOrderQuery extends UnifiedQuery {
  const ListOrderQuery({
    required this.statuses,
    super.limit,
    super.page,
    super.cursor,
    super.query,
    super.sortBy,
    super.orderBy,
  });

  final List<OrderStatusEnum> statuses;
}

class OrderRepository extends BaseRepository {
  OrderRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<List<Order>>> list(ListOrderQuery query) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderList(
        cursor: query.cursor?.trim(),
        limit: query.limit,
        page: query.page,
        query: query.query?.trim(),
        sortBy: query.sortBy?.trim(),
        order: query.orderBy.name,
        statuses: query.statuses.map((v) => v.value).toList(),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Orders not found',
            code: ErrorCode.NOT_FOUND,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Order>> get(String id) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderGet(id: id);

      final data =
          res.data ??
          (throw const RepositoryError(
            'Order not found',
            code: ErrorCode.NOT_FOUND,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

            code: ErrorCode.UNKNOWN,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
