import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/repositories/_export.dart';
import 'package:akademove/features/merchant/presentation/states/_export.dart';
import 'package:akademove/features/review/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';

class MerchantReviewCubit extends BaseCubit<MerchantReviewState> {
  MerchantReviewCubit({required ReviewRepository reviewRepository})
    : _reviewRepository = reviewRepository,
      super(const MerchantReviewState());

  final ReviewRepository _reviewRepository;

  /// Submit a review for a user (customer or driver) after completing an order
  Future<void> submitReview({
    required String orderId,
    required String toUserId,
    required List<ReviewCategory> categories,
    required int score,
    String? comment,
    bool isDriverReview = false,
  }) async => await taskManager.execute('MRC-sR1-$orderId-$toUserId', () async {
    try {
      emit(state.copyWith(submitReviewResult: const OperationResult.loading()));

      final res = await _reviewRepository.submitReview(
        orderId: orderId,
        toUserId: toUserId,
        categories: categories,
        score: score,
        comment: comment,
      );

      final newReviewStatus = ReviewStatus(
        canReview: false,
        alreadyReviewed: true,
        orderCompleted: true,
        existingReview: res.data,
      );

      emit(
        state.copyWith(
          submitReviewResult: OperationResult.success(res.data),
          submitted: res.data,
          // Update the appropriate review status
          customerReviewStatus: isDriverReview
              ? null
              : OperationResult.success(newReviewStatus),
          driverReviewStatus: isDriverReview
              ? OperationResult.success(newReviewStatus)
              : null,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantReviewCubit] Failed to submit review: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(submitReviewResult: OperationResult.failed(e)));
    }
  });

  /// Check review status for rating the customer
  Future<void> checkCustomerReviewStatus(
    String orderId,
  ) async => await taskManager.execute('MRC-cCRS1-$orderId', () async {
    try {
      emit(
        state.copyWith(customerReviewStatus: const OperationResult.loading()),
      );

      final res = await _reviewRepository.getReviewStatus(orderId: orderId);

      emit(
        state.copyWith(
          customerReviewStatus: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantReviewCubit] Failed to check customer review status: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(customerReviewStatus: OperationResult.failed(e)));
    }
  });

  /// Check review status for rating the driver
  Future<void> checkDriverReviewStatus(
    String orderId,
  ) async => await taskManager.execute('MRC-cDRS1-$orderId', () async {
    try {
      emit(state.copyWith(driverReviewStatus: const OperationResult.loading()));

      final res = await _reviewRepository.getReviewStatus(orderId: orderId);

      emit(
        state.copyWith(
          driverReviewStatus: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantReviewCubit] Failed to check driver review status: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(driverReviewStatus: OperationResult.failed(e)));
    }
  });

  /// Check review status for both customer and driver
  Future<void> checkAllReviewStatuses(String orderId) async {
    await Future.wait([
      checkCustomerReviewStatus(orderId),
      checkDriverReviewStatus(orderId),
    ]);
  }

  /// Load reviews received by the current merchant
  Future<void> loadMyReviews({
    bool refresh = false,
  }) async => await taskManager.execute(
    'MRC-lMR1-${refresh ? "refresh" : "loadMore"}-${state.cursor ?? "start"}',
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
          '[MerchantReviewCubit] Failed to load reviews: ${e.message}',
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
    emit(const MerchantReviewState());
  }
}
