import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'review_state.mapper.dart';

@MappableClass()
class ReviewState with ReviewStateMappable {
  const ReviewState({
    this.submitted,
    this.reviews = const [],
    this.hasMore = true,
    this.cursor,
    this.isLoading = false,
    this.error,
    this.message,
  });

  final Review? submitted;
  final List<Review> reviews;
  final bool hasMore;
  final String? cursor;
  final bool isLoading;
  final BaseError? error;
  final String? message;

  bool get isSuccess => error == null && !isLoading;
  bool get isFailure => error != null;

  ReviewState toLoading() {
    return copyWith(isLoading: true, error: null, message: null);
  }

  ReviewState toSuccess({
    Review? submitted,
    List<Review>? reviews,
    bool? hasMore,
    String? cursor,
    String? message,
  }) {
    return copyWith(
      submitted: submitted,
      reviews: reviews ?? this.reviews,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor,
      isLoading: false,
      error: null,
      message: message,
    );
  }

  ReviewState toFailure(BaseError error) {
    return copyWith(isLoading: false, error: error);
  }

  ReviewState appendReviews(List<Review> newReviews, String? nextCursor) {
    return copyWith(
      reviews: [...reviews, ...newReviews],
      cursor: nextCursor,
      hasMore: nextCursor != null,
    );
  }

  ReviewState reset() {
    return const ReviewState();
  }
}
