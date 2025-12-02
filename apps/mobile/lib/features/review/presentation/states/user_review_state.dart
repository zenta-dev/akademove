part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserReviewState extends BaseState2 with UserReviewStateMappable {
  UserReviewState({
    this.submittedReview,
    this.orderReviews = const [],
    this.canReview = false,
    super.state,
    super.message,
    super.error,
  });

  final Review? submittedReview;
  final List<Review> orderReviews;
  final bool canReview;

  @override
  UserReviewState toInitial() => UserReviewState(state: CubitState.initial);

  @override
  UserReviewState toLoading() => copyWith(state: CubitState.loading);

  @override
  UserReviewState toSuccess({
    Review? submittedReview,
    List<Review>? orderReviews,
    bool? canReview,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    submittedReview: submittedReview ?? this.submittedReview,
    orderReviews: orderReviews ?? this.orderReviews,
    canReview: canReview ?? this.canReview,
    message: message,
    error: null,
  );

  @override
  UserReviewState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
