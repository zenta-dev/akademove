import 'package:akademove/core/_export.dart';
import 'package:akademove/features/review/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class ReviewRepository extends BaseRepository {
  const ReviewRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Submit a review for a user after completing an order
  Future<BaseResponse<Review>> submitReview({
    required String orderId,
    required String toUserId,
    required List<ReviewCategory> categories,
    required int score,
    String? comment,
  }) {
    return guard(() async {
      // fromUserId is automatically set by backend from auth context
      final res = await _apiClient.getReviewApi().reviewCreate(
        insertReview: InsertReview(
          orderId: orderId,
          fromUserId: '', // Will be set by backend
          toUserId: toUserId,
          categories: categories,
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

      final review = data.data;
      if (review == null) {
        throw const RepositoryError(
          'Failed to submit review: no data returned',
          code: ErrorCode.unknown,
        );
      }

      return SuccessResponse(message: data.message, data: review);
    });
  }

  /// Check if user can review an order and get existing review if already reviewed
  Future<BaseResponse<ReviewStatus>> getReviewStatus({
    required String orderId,
  }) {
    return guard(() async {
      final res = await _apiClient.getReviewApi().reviewCheckCanReview(
        orderId: orderId,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to check review eligibility',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(
        message: data.message,
        data: ReviewStatus(
          canReview: data.data.canReview,
          alreadyReviewed: data.data.alreadyReviewed,
          orderCompleted: data.data.orderCompleted,
          existingReview: data.data.existingReview,
        ),
      );
    });
  }

  /// Get reviews received by the current user (driver)
  Future<ReviewList200Response> getMyReviews({int limit = 20, String? cursor}) {
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

      return data;
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

      final review = data.data;
      if (review == null) {
        throw const RepositoryError(
          'Review not found',
          code: ErrorCode.notFound,
        );
      }

      return SuccessResponse(message: data.message, data: review);
    });
  }
}
