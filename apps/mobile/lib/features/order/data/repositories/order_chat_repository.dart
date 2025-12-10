import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ListOrderChatMessagesQuery {
  const ListOrderChatMessagesQuery({
    required this.orderId,
    this.limit = 50,
    this.cursor,
  });

  final String orderId;
  final int limit;
  final String? cursor;
}

class SendOrderChatMessageRequest {
  const SendOrderChatMessageRequest({
    required this.orderId,
    required this.message,
  });

  final String orderId;
  final String message;
}

class OrderChatMessagesResponse {
  const OrderChatMessagesResponse({
    required this.rows,
    required this.hasMore,
    this.nextCursor,
  });

  final List<OrderChatMessage> rows;
  final bool hasMore;
  final String? nextCursor;
}

class OrderChatRepository extends BaseRepository {
  OrderChatRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<OrderChatMessagesResponse>> listMessages(
    ListOrderChatMessagesQuery query,
  ) {
    return guard(() async {
      final orderApi = _apiClient.getOrderApi();
      final response = await orderApi.orderListMessages(
        id: query.orderId,
        limit: query.limit,
        cursor: query.cursor,
      );

      final responseData = response.data;
      if (responseData == null) {
        throw const RepositoryError(
          'Failed to load chat messages',
          code: ErrorCode.internalServerError,
        );
      }

      final data = responseData.data;
      final result = OrderChatMessagesResponse(
        rows: data.rows,
        hasMore: data.hasMore,
        nextCursor: data.nextCursor,
      );

      return SuccessResponse(data: result, message: responseData.message ?? '');
    });
  }

  Future<BaseResponse<OrderChatMessage>> sendMessage(
    SendOrderChatMessageRequest request,
  ) {
    return guard(() async {
      final orderApi = _apiClient.getOrderApi();
      final response = await orderApi.orderSendMessage(
        id: request.orderId,
        orderSendMessageRequest: OrderSendMessageRequest(
          message: request.message,
        ),
      );

      final responseData = response.data;
      if (responseData == null) {
        throw const RepositoryError(
          'Failed to send message',
          code: ErrorCode.internalServerError,
        );
      }

      return SuccessResponse(
        data: responseData.data,
        message: responseData.message ?? '',
      );
    });
  }
}
