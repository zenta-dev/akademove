part of '_export.dart';

class UserReviewState extends Equatable {
  const UserReviewState({
    this.submittedReview = const OperationResult.idle(),
    this.orderReviews = const OperationResult.idle(),
    this.canReview = const OperationResult.idle(),
  });

  final OperationResult<Review> submittedReview;
  final OperationResult<List<Review>> orderReviews;
  final OperationResult<bool> canReview;

  @override
  List<Object?> get props => [submittedReview, orderReviews, canReview];

  UserReviewState copyWith({
    OperationResult<Review>? submittedReview,
    OperationResult<List<Review>>? orderReviews,
    OperationResult<bool>? canReview,
  }) {
    return UserReviewState(
      submittedReview: submittedReview ?? this.submittedReview,
      orderReviews: orderReviews ?? this.orderReviews,
      canReview: canReview ?? this.canReview,
    );
  }

  @override
  bool get stringify => true;
}
