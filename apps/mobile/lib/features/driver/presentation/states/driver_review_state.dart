part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverReviewState extends BaseState2 with DriverReviewStateMappable {
  DriverReviewState({
    super.state,
    super.message,
    super.error,
    this.submitted,
    this.reviews = const [],
    this.hasMore = true,
    this.cursor,
  });

  final Review? submitted;
  final List<Review> reviews;
  final bool hasMore;
  final String? cursor;

  @override
  DriverReviewState toInitial() => DriverReviewState();
  @override
  DriverReviewState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverReviewState toSuccess({
    String? message,
    Review? submitted,
    List<Review>? reviews,
    bool? hasMore,
    String? cursor,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    submitted: submitted ?? this.submitted,
    reviews: reviews ?? this.reviews,
    hasMore: hasMore ?? this.hasMore,
    cursor: cursor ?? this.cursor,
  );

  @override
  DriverReviewState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
