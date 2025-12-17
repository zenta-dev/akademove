import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/repositories/_export.dart';
import 'package:akademove/features/driver/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class DriverReviewCubit extends BaseCubit<DriverReviewState> {
  DriverReviewCubit({required ReviewRepository reviewRepository})
    : _reviewRepository = reviewRepository,
      super(const DriverReviewState());

  final ReviewRepository _reviewRepository;

  /// Submit a review for a user after completing an order
  Future<void> submitReview({
    required String orderId,
    required String toUserId,
    required List<ReviewCategory> categories,
    required int score,
    String? comment,
  }) async => await taskManager.execute('DRC-sR1-$orderId', () async {
    try {
      emit(state.copyWith(submitReviewResult: const OperationResult.loading()));

      final res = await _reviewRepository.submitReview(
        orderId: orderId,
        toUserId: toUserId,
        categories: categories,
        score: score,
        comment: comment,
      );

      emit(
        state.copyWith(
          submitReviewResult: OperationResult.success(res.data),
          submitted: res.data,
          // Also update reviewStatus to reflect the newly submitted review
          reviewStatus: OperationResult.success(
            ReviewStatus(
              canReview: false,
              alreadyReviewed: true,
              orderCompleted: true,
              existingReview: res.data,
            ),
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverReviewCubit] Failed to submit review: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(submitReviewResult: OperationResult.failed(e)));
    }
  });

  /// Check review status for an order (includes existing review if already reviewed)
  Future<void> checkReviewStatus(String orderId) async =>
      await taskManager.execute('DRC-cRS1-$orderId', () async {
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
            '[DriverReviewCubit] Failed to check review status: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(reviewStatus: OperationResult.failed(e)));
        }
      });

  /// Load reviews received by the current user (driver)
  Future<void> loadMyReviews({
    bool refresh = false,
  }) async => await taskManager.execute(
    'DRC-lMR1-${refresh ? "refresh" : "loadMore"}-${state.cursor ?? "start"}',
    () async {
      try {
        if (refresh) {
          emit(
            state.copyWith(fetchReviewsResult: const OperationResult.loading()),
          );
        } else {
          if (!state.hasMore || state.fetchReviewsResult.isLoading) return;
          emit(
            state.copyWith(fetchReviewsResult: const OperationResult.loading()),
          );
        }

        final res = await _reviewRepository.getMyReviews(
          limit: 20,
          cursor: refresh ? null : state.cursor,
        );

        final nextCursor = res.pagination?.nextCursor;
        final hasMore = res.pagination?.hasMore ?? false;

        if (refresh) {
          emit(
            state.copyWith(
              fetchReviewsResult: OperationResult.success(res.data),
              reviews: res.data,
              cursor: nextCursor,
              hasMore: hasMore,
            ),
          );
        } else {
          final updatedReviews = [...state.reviews, ...res.data];
          emit(
            state.copyWith(
              fetchReviewsResult: OperationResult.success(updatedReviews),
              reviews: updatedReviews,
              cursor: nextCursor,
              hasMore: hasMore,
            ),
          );
        }
      } on BaseError catch (e, st) {
        logger.e(
          '[DriverReviewCubit] Failed to load reviews: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(fetchReviewsResult: OperationResult.failed(e)));
      }
    },
  );

  /// Load more reviews (pagination)
  Future<void> loadMoreReviews() async {
    if (!state.hasMore || state.fetchReviewsResult.isLoading) return;
    await loadMyReviews(refresh: false);
  }

  /// Refresh reviews
  Future<void> refreshReviews() async {
    await loadMyReviews(refresh: true);
  }

  /// Reset state
  void reset() {
    emit(const DriverReviewState());
  }
}
