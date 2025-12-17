part of '_export.dart';

/// Data class to hold review eligibility status
class ReviewStatus extends Equatable {
  const ReviewStatus({
    required this.canReview,
    required this.alreadyReviewed,
    required this.orderCompleted,
    this.existingReview,
  });

  final bool canReview;
  final bool alreadyReviewed;
  final bool orderCompleted;
  final Review? existingReview;

  @override
  List<Object?> get props => [
    canReview,
    alreadyReviewed,
    orderCompleted,
    existingReview,
  ];
}

class UserReviewState extends Equatable {
  const UserReviewState({
    this.submittedReview = const OperationResult.idle(),
    this.orderReviews = const OperationResult.idle(),
    this.reviewStatus = const OperationResult.idle(),
  });

  final OperationResult<Review> submittedReview;
  final OperationResult<List<Review>> orderReviews;
  final OperationResult<ReviewStatus> reviewStatus;

  @override
  List<Object?> get props => [submittedReview, orderReviews, reviewStatus];

  UserReviewState copyWith({
    OperationResult<Review>? submittedReview,
    OperationResult<List<Review>>? orderReviews,
    OperationResult<ReviewStatus>? reviewStatus,
  }) {
    return UserReviewState(
      submittedReview: submittedReview ?? this.submittedReview,
      orderReviews: orderReviews ?? this.orderReviews,
      reviewStatus: reviewStatus ?? this.reviewStatus,
    );
  }

  @override
  bool get stringify => true;
}
