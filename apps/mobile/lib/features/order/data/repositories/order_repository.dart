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

  ListOrderQuery copyWith({
    List<OrderStatus>? statuses,
    int? limit,
    int? page,
    String? cursor,
    String? query,
    String? sortBy,
    PaginationOrder? orderBy,
  }) {
    return ListOrderQuery(
      statuses: statuses ?? this.statuses,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      cursor: cursor ?? this.cursor,
      query: query ?? this.query,
      sortBy: sortBy ?? this.sortBy,
      orderBy: orderBy ?? this.orderBy,
    );
  }
}

class EstimateOrderQuery {
  const EstimateOrderQuery({
    required this.type,
    required this.pickupLocation,
    required this.dropoffLocation,
    this.weight,
    this.items,
    this.gender,
  });

  final OrderType type;
  final Coordinate pickupLocation;
  final Coordinate dropoffLocation;
  final num? weight;
  final List<OrderItem>? items;
  final UserGender? gender;
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
        order: query.orderBy,
        mode: PaginationMode.cursor,
        statuses: query.statuses.map((v) => v.value).toList(),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Orders not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(
        message: data.message,
        data: data.data,
        paginationResult: data.pagination,
      );
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
        weight: query.weight,
        items: query.items,
        gender: query.gender,
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

  Future<BaseResponse<PlaceOrderResponse>> placeOrder(PlaceOrder req) {
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

  /// Upload delivery proof photo (driver only)
  /// POST /api/orders/{id}/delivery-proof
  /// Returns the uploaded proof URL
  Future<BaseResponse<String>> uploadDeliveryProof(
    String orderId,
    Object file,
  ) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderUploadDeliveryProof(
        id: orderId,
        orderUploadDeliveryProofRequest: OrderUploadDeliveryProofRequest(
          file: file,
        ),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to upload delivery proof',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data.url);
    });
  }

  /// Verify delivery OTP (customer only)
  /// POST /api/orders/{id}/verify-otp
  /// Returns whether verification was successful
  Future<BaseResponse<bool>> verifyDeliveryOTP(String orderId, String otp) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderVerifyDeliveryOTP(
        id: orderId,
        orderVerifyDeliveryOTPRequest: OrderVerifyDeliveryOTPRequest(otp: otp),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to verify delivery OTP',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data.verified);
    });
  }

  /// Place a scheduled order
  /// POST /api/orders/scheduled
  Future<BaseResponse<PlaceScheduledOrderResponse>> placeScheduledOrder(
    PlaceScheduledOrder req,
  ) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderPlaceScheduledOrder(
        placeScheduledOrder: req,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to place scheduled order',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// List scheduled orders
  /// GET /api/orders/scheduled
  Future<BaseResponse<List<Order>>> listScheduledOrders(ListOrderQuery query) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderListScheduledOrders(
        cursor: query.cursor?.trim(),
        limit: query.limit,
        page: query.page,
        query: query.query?.trim(),
        sortBy: query.sortBy?.trim(),
        order: query.orderBy,
        mode: PaginationMode.cursor,
        statuses: query.statuses.map((v) => v.value).toList(),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Scheduled orders not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(
        message: data.message,
        data: data.data,
        paginationResult: data.pagination,
      );
    });
  }

  /// Update a scheduled order (reschedule)
  /// PUT /api/orders/scheduled/{id}
  Future<BaseResponse<Order>> updateScheduledOrder(
    String id,
    UpdateScheduledOrder request,
  ) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderUpdateScheduledOrder(
        id: id,
        updateScheduledOrder: request,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update scheduled order',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Cancel a scheduled order
  /// POST /api/orders/scheduled/{id}/cancel
  Future<BaseResponse<Order>> cancelScheduledOrder(
    String id, {
    String? reason,
  }) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderCancelScheduledOrder(
        id: id,
        orderCancelRequest: OrderCancelRequest(reason: reason),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to cancel scheduled order',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
