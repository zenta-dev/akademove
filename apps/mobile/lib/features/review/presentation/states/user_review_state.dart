part of '_export.dart';

class UserReviewState extends Equatable {
  const UserReviewState({
    this.status = const OperationResult.idle(),
    this.submittedReview,
    this.orderReviews = const [],
    this.canReview = false,
  });

  final OperationResult<void> status;
  final Review? submittedReview;
  final List<Review> orderReviews;
  final bool canReview;

  bool get isLoading => status.isLoading;
  bool get isFailure => status.isFailure;
  bool get isSuccess => status.isSuccess;
  BaseError? get error => status.error;
  String? get message => status.message;

  @override
  List<Object?> get props => [status, submittedReview, orderReviews, canReview];

  UserReviewState copyWith({
    OperationResult<void>? status,
    Review? submittedReview,
    List<Review>? orderReviews,
    bool? canReview,
  }) {
    return UserReviewState(
      status: status ?? this.status,
      submittedReview: submittedReview ?? this.submittedReview,
      orderReviews: orderReviews ?? this.orderReviews,
      canReview: canReview ?? this.canReview,
    );
  }

  UserReviewState toLoading() =>
      copyWith(status: const OperationResult.loading());

  UserReviewState toSuccess({
    String? message,
    Review? submittedReview,
    List<Review>? orderReviews,
    bool? canReview,
  }) {
    return copyWith(
      status: OperationResult.success(null, message: message),
      submittedReview: submittedReview,
      orderReviews: orderReviews,
      canReview: canReview,
    );
  }

  UserReviewState toFailure(BaseError error) =>
      copyWith(status: OperationResult.failed(error));

  @override
  bool get stringify => true;
}
