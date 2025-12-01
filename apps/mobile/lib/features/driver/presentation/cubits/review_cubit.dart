import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/repositories/_export.dart';
import 'package:akademove/features/driver/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class ReviewCubit extends BaseCubit<ReviewState> {
  ReviewCubit({required ReviewRepository reviewRepository})
    : _reviewRepository = reviewRepository,
      super(const ReviewState());

  final ReviewRepository _reviewRepository;

  /// Submit a review for a user after completing an order
  Future<void> submitReview({
    required String orderId,
    required String toUserId,
    required ReviewCategory category,
    required num score,
    String? comment,
  }) async {
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
  }

  /// Load reviews received by the current user (driver)
  Future<void> loadMyReviews({bool refresh = false}) async {
    try {
      if (refresh) {
        emit(const ReviewState().toLoading());
      } else {
        if (!state.hasMore || state.isLoading) return;
        emit(state.toLoading());
      }

      final res = await _reviewRepository.getMyReviews(
        limit: 20,
        cursor: refresh ? null : state.cursor,
      );

      if (refresh) {
        emit(
          state.toSuccess(
            reviews: res.data,
            cursor: (res as dynamic).pagination?.cursor,
            hasMore: (res as dynamic).pagination?.cursor != null,
            message: res.message,
          ),
        );
      } else {
        emit(
          state.appendReviews(res.data, (res as dynamic).pagination?.cursor),
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
  }

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
    emit(const ReviewState());
  }
}
