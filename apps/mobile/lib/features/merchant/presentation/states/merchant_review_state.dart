import 'package:akademove/core/_export.dart';
import 'package:akademove/features/review/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantReviewState extends Equatable {
  const MerchantReviewState({
    this.fetchReviewsResult = const OperationResult.idle(),
    this.submitReviewResult = const OperationResult.idle(),
    this.customerReviewStatus = const OperationResult.idle(),
    this.driverReviewStatus = const OperationResult.idle(),
    this.submitted,
    this.reviews = const [],
    this.hasMore = true,
    this.cursor,
  });

  final OperationResult<List<Review>> fetchReviewsResult;
  final OperationResult<Review> submitReviewResult;

  /// Review status for rating the customer
  final OperationResult<ReviewStatus> customerReviewStatus;

  /// Review status for rating the driver
  final OperationResult<ReviewStatus> driverReviewStatus;

  final Review? submitted;
  final List<Review> reviews;
  final bool hasMore;
  final String? cursor;

  @override
  List<Object?> get props => [
    fetchReviewsResult,
    submitReviewResult,
    customerReviewStatus,
    driverReviewStatus,
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
    OperationResult<ReviewStatus>? customerReviewStatus,
    OperationResult<ReviewStatus>? driverReviewStatus,
    Review? submitted,
    List<Review>? reviews,
    bool? hasMore,
    String? cursor,
  }) {
    return MerchantReviewState(
      fetchReviewsResult: fetchReviewsResult ?? this.fetchReviewsResult,
      submitReviewResult: submitReviewResult ?? this.submitReviewResult,
      customerReviewStatus: customerReviewStatus ?? this.customerReviewStatus,
      driverReviewStatus: driverReviewStatus ?? this.driverReviewStatus,
      submitted: submitted ?? this.submitted,
      reviews: reviews ?? this.reviews,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
    );
  }
}
