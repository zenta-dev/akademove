import 'package:akademove/core/_export.dart';
import 'package:akademove/features/review/data/repositories/_export.dart';
import 'package:akademove/features/review/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class UserReviewCubit extends BaseCubit<UserReviewState> {
  UserReviewCubit({required UserReviewRepository reviewRepository})
    : _reviewRepository = reviewRepository,
      super(const UserReviewState());

  final UserReviewRepository _reviewRepository;

  /// Submit a review for a driver after completing an order
  /// [categories] - List of selected categories (multi-select)
  /// [score] - Overall rating for the entire review (1-5)
  Future<void> submitReview({
    required String orderId,
    required String toUserId,
    required List<ReviewCategory> categories,
    required int score,
    String? comment,
  }) async => await taskManager.execute('URC-sR1-$orderId', () async {
    try {
      emit(state.copyWith(submittedReview: const OperationResult.loading()));

      final res = await _reviewRepository.submitReview(
        orderId: orderId,
        toUserId: toUserId,
        categories: categories,
        score: score,
        comment: comment,
      );

      emit(
        state.copyWith(
          submittedReview: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserReviewCubit] Failed to submit review: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(submittedReview: OperationResult.failed(e)));
    }
  });

  /// Check review status for an order (includes existing review if already reviewed)
  Future<void> checkReviewStatus(String orderId) async =>
      await taskManager.execute('URC-cRS1-$orderId', () async {
        try {
          emit(state.copyWith(reviewStatus: const OperationResult.loading()));

          final res = await _reviewRepository.getReviewStatus(orderId: orderId);

          emit(
            state.copyWith(
              reviewStatus: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserReviewCubit] Failed to check review status: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(reviewStatus: OperationResult.failed(e)));
        }
      });

  /// Load reviews for a specific order
  Future<void> loadOrderReviews(String orderId) async =>
      await taskManager.execute('URC-lOR1-$orderId', () async {
        try {
          emit(state.copyWith(orderReviews: const OperationResult.loading()));

          final res = await _reviewRepository.getOrderReviews(orderId: orderId);

          emit(
            state.copyWith(
              orderReviews: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserReviewCubit] Failed to load order reviews: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(orderReviews: OperationResult.failed(e)));
        }
      });

  /// Reset state
  void reset() {
    emit(const UserReviewState());
  }
}
