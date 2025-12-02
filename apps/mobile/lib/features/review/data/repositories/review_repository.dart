import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ReviewRepository {
  ReviewRepository({required ReviewApi reviewApi}) : _reviewApi = reviewApi;

  final ReviewApi _reviewApi;

  Future<ReviewEligibilityStatus> checkCanReview(String orderId) async {
    try {
      final response = await _reviewApi.reviewCheckCanReview(orderId: orderId);

      if (response.statusCode != 200 || response.data == null) {
        throw Exception('Failed to check review eligibility');
      }

      final data = response.data!.data;

      return ReviewEligibilityStatus(
        canReview: data.canReview ?? false,
        alreadyReviewed: data.alreadyReviewed ?? false,
        orderCompleted: data.orderCompleted ?? false,
      );
    } catch (e, st) {
      logger.e('Failed to check review eligibility', error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<Review> createReview(InsertReview review) async {
    try {
      final response = await _reviewApi.reviewCreate(insertReview: review);

      if (response.statusCode != 200 || response.data == null) {
        throw Exception('Failed to submit review');
      }

      return response.data!.data;
    } catch (e, st) {
      logger.e('Failed to create review', error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<List<Review>> getOrderReviews(String orderId) async {
    try {
      final response = await _reviewApi.reviewGetByOrder(orderId: orderId);

      if (response.statusCode != 200 || response.data == null) {
        throw Exception('Failed to get order reviews');
      }

      return response.data!.data ?? [];
    } catch (e, st) {
      logger.e('Failed to get order reviews', error: e, stackTrace: st);
      rethrow;
    }
  }
}

class ReviewEligibilityStatus {
  const ReviewEligibilityStatus({
    required this.canReview,
    required this.alreadyReviewed,
    required this.orderCompleted,
  });

  final bool canReview;
  final bool alreadyReviewed;
  final bool orderCompleted;

  String? getErrorMessage() {
    if (alreadyReviewed) {
      return 'You have already reviewed this order';
    }
    if (!orderCompleted) {
      return 'Order must be completed before reviewing';
    }
    if (!canReview) {
      return 'You cannot review this order';
    }
    return null;
  }
}
