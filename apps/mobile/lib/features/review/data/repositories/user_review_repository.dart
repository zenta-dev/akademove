import 'package:akademove/core/_export.dart';
import 'package:akademove/features/review/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class UserReviewRepository extends BaseRepository {
  const UserReviewRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Submit a review for a driver after completing an order
  ///
  /// [categories] - List of selected categories (multi-select)
  /// [score] - Overall rating for the entire review (1-5)
  Future<BaseResponse<Review>> submitReview({
    required String orderId,
    required String toUserId,
    required List<ReviewCategory> categories,
    required int score,
    String? comment,
  }) {
    return guard(() async {
      final res = await _apiClient.getReviewApi().reviewCreate(
        insertReview: InsertReview(
          orderId: orderId,
          fromUserId: '', // Will be set by backend from auth context
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
