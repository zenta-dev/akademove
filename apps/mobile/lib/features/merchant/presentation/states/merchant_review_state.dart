import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantReviewState extends Equatable {
  const MerchantReviewState({
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

  MerchantReviewState copyWith({
    OperationResult<List<Review>>? fetchReviewsResult,
    OperationResult<Review>? submitReviewResult,
    Review? submitted,
    List<Review>? reviews,
    bool? hasMore,
    String? cursor,
  }) {
    return MerchantReviewState(
      fetchReviewsResult: fetchReviewsResult ?? this.fetchReviewsResult,
      submitReviewResult: submitReviewResult ?? this.submitReviewResult,
      submitted: submitted ?? this.submitted,
      reviews: reviews ?? this.reviews,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
    );
  }
}
