import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/repositories/_export.dart';
import 'package:akademove/features/driver/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class DriverReviewCubit extends BaseCubit<DriverReviewState> {
  DriverReviewCubit({required ReviewRepository reviewRepository})
    : _reviewRepository = reviewRepository,
      super(DriverReviewState());

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
      emit(state.toLoading());

      final res = await _reviewRepository.submitReview(
        orderId: orderId,
        toUserId: toUserId,
        category: category,
        score: score,
        comment: comment,
      );

      emit(state.toSuccess(submitted: res.data, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[ReviewCubit] Failed to submit review: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
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
          emit(state.toLoading());
        } else {
          if (!state.hasMore || state.isLoading) return;
          emit(state.toLoading());
        }

        final res = await _reviewRepository.getMyReviews(
          limit: 20,
          cursor: refresh ? null : state.cursor,
        );

        final nextCursor = res.pagination?.nextCursor;
        final hasMore = res.pagination?.hasMore ?? false;

        if (refresh) {
          emit(
            state.toSuccess(
              reviews: res.data,
              cursor: nextCursor,
              hasMore: hasMore,
              message: res.message,
            ),
          );
        } else {
          emit(
            state.toSuccess(
              reviews: [...state.reviews, ...res.data],
              cursor: nextCursor,
              hasMore: hasMore,
              message: res.message,
            ),
          );
        }
      } on BaseError catch (e, st) {
        logger.e(
          '[ReviewCubit] Failed to load reviews: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.toFailure(e));
      }
    },
  );

  /// Load more reviews (pagination)
  Future<void> loadMoreReviews() async {
    if (!state.hasMore || state.isLoading) return;
    await loadMyReviews(refresh: false);
  }

  /// Refresh reviews
  Future<void> refreshReviews() async {
    await loadMyReviews(refresh: true);
  }

  /// Reset state
  void reset() {
    emit(DriverReviewState());
  }
}
