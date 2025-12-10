part of '_export.dart';

class DriverReviewState extends Equatable {
  const DriverReviewState({
    this.fetchReviewsResult = const OperationResult.idle(),
    this.submitReviewResult = const OperationResult.idle(),
    this.submitted,
    this.reviews = const [],
    this.hasMore = true,
    this.cursor,
  });

  final OperationResult<List<Review>> fetchReviewsResult;
  final OperationResult<Review> submitReviewResult;

  final Review? submitted;
  final List<Review> reviews;
  final bool hasMore;
  final String? cursor;

  bool get isLoading =>
      fetchReviewsResult.isLoading || submitReviewResult.isLoading;

  bool get isFailure =>
      fetchReviewsResult.isFailure || submitReviewResult.isFailure;

  bool get isSuccess =>
      fetchReviewsResult.isSuccess || submitReviewResult.isSuccess;

  BaseError? get error => fetchReviewsResult.error ?? submitReviewResult.error;

  String? get message {
    if (submitReviewResult.isSuccess) return 'Review submitted';
    return null;
  }

  @override
  List<Object?> get props => [
    fetchReviewsResult,
    submitReviewResult,
    submitted,
    reviews,
    hasMore,
    cursor,
  ];

  @override
  bool get stringify => true;

  DriverReviewState copyWith({
    OperationResult<List<Review>>? fetchReviewsResult,
    OperationResult<Review>? submitReviewResult,
    Review? submitted,
    List<Review>? reviews,
    bool? hasMore,
    String? cursor,
  }) {
    return DriverReviewState(
      fetchReviewsResult: fetchReviewsResult ?? this.fetchReviewsResult,
      submitReviewResult: submitReviewResult ?? this.submitReviewResult,
      submitted: submitted ?? this.submitted,
      reviews: reviews ?? this.reviews,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
    );
  }
}
