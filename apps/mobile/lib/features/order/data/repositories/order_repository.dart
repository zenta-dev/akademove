import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class ListOrderQuery extends UnifiedQuery {
  const ListOrderQuery({
    required this.statuses,
    this.type,
    super.limit,
    super.page,
    super.cursor,
    super.query,
    super.sortBy,
    super.orderBy,
  });

  final List<OrderStatus> statuses;
  final OrderType? type;

  ListOrderQuery copyWith({
    List<OrderStatus>? statuses,
    OrderType? type,
    int? limit,
    int? page,
    String? cursor,
    String? query,
    String? sortBy,
    PaginationOrder? orderBy,
  }) {
    return ListOrderQuery(
      statuses: statuses ?? this.statuses,
      type: type ?? this.type,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      cursor: cursor ?? this.cursor,
      query: query ?? this.query,
      sortBy: sortBy ?? this.sortBy,
      orderBy: orderBy ?? this.orderBy,
    );
  }
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
        type: query.type?.value,
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

  Future<BaseResponse<OrderSummary>> estimate(EstimateOrder req) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderEstimate(
        estimateOrder: req,
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

  /// Cancel an active order
  /// POST /api/orders/{id}/cancel
  Future<BaseResponse<Order>> cancelOrder(String id, {String? reason}) {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderCancel(
        id: id,
        orderCancelRequest: OrderCancelRequest(reason: reason),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to cancel order',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get the active order for the current user (for order recovery on app reopen)
  /// GET /api/orders/active
  /// Returns the active order with associated payment, transaction, and driver
  Future<BaseResponse<ActiveOrderResponse?>> getActiveOrder() {
    return guard(() async {
      final res = await _apiClient.getOrderApi().orderGetActive();

      final data = res.data;
      final order = data?.data?.order;
      final payment = data?.data?.payment;
      final transaction = data?.data?.transaction;
      final driver = data?.data?.driver;
      if (order == null) {
        return SuccessResponse(
          message: data?.message ?? 'No active order found',
          data: null,
        );
      }

      return SuccessResponse(
        message: data?.message ?? 'Successfully retrieved active order',
        data: ActiveOrderResponse(
          order: order,
          payment: payment,
          transaction: transaction,
          driver: driver,
        ),
      );
    });
  }
}

/// Response model for active order recovery
class ActiveOrderResponse {
  const ActiveOrderResponse({
    required this.order,
    this.payment,
    this.transaction,
    this.driver,
  });

  final Order order;
  final Payment? payment;
  final Transaction? transaction;
  final Driver? driver;
}
