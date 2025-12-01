import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ReviewRepository extends BaseRepository {
  const ReviewRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Submit a review for a user after completing an order
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

  /// Get reviews received by the current user (driver)
  Future<BaseResponse<List<Review>>> getMyReviews({
    int limit = 20,
    String? cursor,
  }) {
    return guard(() async {
      final res = await _apiClient.getReviewApi().reviewList(
        limit: limit,
        cursor: cursor,
        sortBy: 'createdAt',
        order: PaginationOrder.desc,
        mode: PaginationMode.cursor,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to fetch reviews',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
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
