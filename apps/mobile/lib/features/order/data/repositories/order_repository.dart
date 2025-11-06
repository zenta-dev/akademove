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

  final List<OrderStatus> statuses;
}

class EstimateOrderQuery {
  const EstimateOrderQuery({
    required this.type,
    required this.pickupLocation,
    required this.dropoffLocation,
  });

  final OrderType type;
  final Coordinate pickupLocation;
  final Coordinate dropoffLocation;
}

class OrderRepository extends BaseRepository {
  OrderRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

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
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<OrderSummary>> estimate(EstimateOrderQuery query) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderEstimate(
        type: query.type,
        pickupLocationX: query.pickupLocation.x,
        pickupLocationY: query.pickupLocation.y,
        dropoffLocationX: query.dropoffLocation.x,
        dropoffLocationY: query.dropoffLocation.y,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Cant estimate order',
            code: ErrorCode.notFound,
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
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Order>> placeOrder(PlaceOrder req) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderPlaceOrder(
        placeOrder: req,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Cant estimate order',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Order>> update(String id, UpdateOrder request) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderUpdate(
        id: id,
        updateOrder: request,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update order',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
