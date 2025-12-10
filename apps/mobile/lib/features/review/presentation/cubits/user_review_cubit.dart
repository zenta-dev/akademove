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
  Future<void> submitReview({
    required String orderId,
    required String toUserId,
    required ReviewCategory category,
    required num score,
    String? comment,
  }) async => await taskManager.execute('URC-sR1-$orderId', () async {
    try {
      emit(state.copyWith(submittedReview: const OperationResult.loading()));

      final res = await _reviewRepository.submitReview(
        orderId: orderId,
        toUserId: toUserId,
        category: category,
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

  /// Check if user can review an order
  Future<void> checkCanReview(
    String orderId,
  ) async => await taskManager.execute('URC-cCR1-$orderId', () async {
    try {
      emit(state.copyWith(canReview: const OperationResult.loading()));

      final res = await _reviewRepository.canReviewOrder(orderId: orderId);

      emit(
        state.copyWith(
          canReview: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserReviewCubit] Failed to check review eligibility: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(canReview: OperationResult.failed(e)));
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
