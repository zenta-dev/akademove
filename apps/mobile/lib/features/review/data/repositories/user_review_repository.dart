import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class UserReviewRepository extends BaseRepository {
  const UserReviewRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Submit a review for a driver after completing an order
  Future<BaseResponse<Review>> submitReview({
    required String orderId,
    required String toUserId,
    required ReviewCategory category,
    required num score,
    String? comment,
  }) {
    return guard(() async {
      // fromUserId is automatically set by backend from auth context
      final res = await _apiClient.getReviewApi().reviewCreate(
        insertReview: InsertReview(
          orderId: orderId,
          fromUserId: '', // Will be set by backend
          toUserId: toUserId,
          category: category,
          score: score,
          comment: comment,
        ),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to submit review',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Check if user can review an order
  Future<BaseResponse<bool>> canReviewOrder({
    required String orderId,
    required String currentUserId,
  }) {
    return guard(() async {
      // Note: This will need to be updated once the server API is regenerated
      // For now, we'll check by trying to get the order reviews
      try {
        final orderReviews = await getOrderReviews(orderId: orderId);
        // If we can get reviews, the order exists
        // Check if current user already reviewed
        final hasAlreadyReviewed = orderReviews.data.any(
          (r) => r.fromUserId == currentUserId,
        );
        return SuccessResponse(
          message: hasAlreadyReviewed ? 'Already reviewed' : 'Can review order',
          data: !hasAlreadyReviewed,
        );
      } catch (e) {
        return SuccessResponse(message: 'Cannot review', data: false);
      }
    });
  }

  /// Get reviews for a specific order
  Future<BaseResponse<List<Review>>> getOrderReviews({
    required String orderId,
  }) {
    return guard(() async {
      final res = await _apiClient.getReviewApi().reviewList(
        query: orderId,
        sortBy: 'createdAt',
        order: PaginationOrder.desc,
        mode: PaginationMode.offset,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to fetch order reviews',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get a single review by ID
  Future<BaseResponse<Review>> getReview(String id) {
    return guard(() async {
      final res = await _apiClient.getReviewApi().reviewGet(id: id);

      final data =
          res.data ??
          (throw const RepositoryError(
            'Review not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
