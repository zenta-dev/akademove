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
    required ReviewCategory category,
    required num score,
    String? comment,
  }) async => await taskManager.execute('DRC-sR1-$orderId', () async {
    try {
      emit(state.copyWith(submitReviewResult: const OperationResult.loading()));

      final res = await _reviewRepository.submitReview(
        orderId: orderId,
        toUserId: toUserId,
        category: category,
        score: score,
        comment: comment,
      );

      emit(
        state.copyWith(
          submitReviewResult: OperationResult.success(res.data),
          submitted: res.data,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[ReviewCubit] Failed to submit review: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(submitReviewResult: OperationResult.failed(e)));
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
          '[ReviewCubit] Failed to load reviews: ${e.message}',
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
