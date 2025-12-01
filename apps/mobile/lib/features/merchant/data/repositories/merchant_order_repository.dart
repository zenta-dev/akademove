import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

/// Repository for merchant-specific order operations
/// Handles accept, reject, and preparation status updates for food orders
class MerchantOrderRepository extends BaseRepository {
  const MerchantOrderRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Accept an order
  /// Updates order status from REQUESTED/MATCHING to ACCEPTED
  ///
  /// Throws [RepositoryError] if:
  /// - Order not found
  /// - Order doesn't belong to merchant
  /// - Order status is not REQUESTED or MATCHING
  Future<BaseResponse<Order>> acceptOrder({
    required String merchantId,
    required String orderId,
  }) {
    return guard(() async {
      // TODO: Regenerate API client after server changes
      // Run: bun run dev (start server)
      // Run: make gen (generate client)
      // Run: melos generate (build_runner)
      //
      // Expected API client method:
      // final res = await _apiClient.getMerchantApi().merchantAcceptOrder(
      //   merchantId: merchantId,
      //   orderId: orderId,
      // );

      throw UnimplementedError(
        'API client needs regeneration. '
        'Run: bun run dev && make gen && melos generate',
      );

      // final data =
      //     res.data?.body ??
      //     (throw const RepositoryError(
      //       'Failed to accept order',
      //       code: ErrorCode.unknown,
      //     ));
      //
      // return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Reject an order
  /// Updates order status to CANCELLED_BY_MERCHANT and processes refund
  ///
  /// [reason] must be one of: OUT_OF_STOCK, TOO_BUSY, INGREDIENT_UNAVAILABLE, CLOSED, OTHER
  /// [note] is optional additional context
  ///
  /// Throws [RepositoryError] if:
  /// - Order not found
  /// - Order doesn't belong to merchant
  /// - Invalid rejection reason
  Future<BaseResponse<Order>> rejectOrder({
    required String merchantId,
    required String orderId,
    required String reason,
    String? note,
  }) {
    return guard(() async {
      // TODO: Regenerate API client after server changes
      //
      // Expected API client method:
      // final res = await _apiClient.getMerchantApi().merchantRejectOrder(
      //   merchantId: merchantId,
      //   orderId: orderId,
      //   body: RejectOrderBody(reason: reason, note: note),
      // );

      throw UnimplementedError(
        'API client needs regeneration. '
        'Run: bun run dev && make gen && melos generate',
      );

      // final data =
      //     res.data?.body ??
      //     (throw const RepositoryError(
      //       'Failed to reject order',
      //       code: ErrorCode.unknown,
      //     ));
      //
      // return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Mark order as preparing
  /// Updates order status from ACCEPTED to PREPARING
  /// Sets preparedAt timestamp
  ///
  /// Throws [RepositoryError] if:
  /// - Order not found
  /// - Order doesn't belong to merchant
  /// - Order status is not ACCEPTED
  Future<BaseResponse<Order>> markPreparing({
    required String merchantId,
    required String orderId,
  }) {
    return guard(() async {
      // TODO: Regenerate API client after server changes
      //
      // Expected API client method:
      // final res = await _apiClient.getMerchantApi().merchantMarkPreparing(
      //   merchantId: merchantId,
      //   orderId: orderId,
      // );

      throw UnimplementedError(
        'API client needs regeneration. '
        'Run: bun run dev && make gen && melos generate',
      );

      // final data =
      //     res.data?.body ??
      //     (throw const RepositoryError(
      //       'Failed to mark order as preparing',
      //       code: ErrorCode.unknown,
      //     ));
      //
      // return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Mark order as ready for pickup
  /// Updates order status from PREPARING to READY_FOR_PICKUP
  /// Sets readyAt timestamp
  /// Driver will be notified to pickup the order
  ///
  /// Throws [RepositoryError] if:
  /// - Order not found
  /// - Order doesn't belong to merchant
  /// - Order status is not PREPARING
  Future<BaseResponse<Order>> markReady({
    required String merchantId,
    required String orderId,
  }) {
    return guard(() async {
      // TODO: Regenerate API client after server changes
      //
      // Expected API client method:
      // final res = await _apiClient.getMerchantApi().merchantMarkReady(
      //   merchantId: merchantId,
      //   orderId: orderId,
      // );

      throw UnimplementedError(
        'API client needs regeneration. '
        'Run: bun run dev && make gen && melos generate',
      );

      // final data =
      //     res.data?.body ??
      //     (throw const RepositoryError(
      //       'Failed to mark order as ready',
      //       code: ErrorCode.unknown,
      //     ));
      //
      // return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
