// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_review.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateReviewCWProxy {
  UpdateReview orderId(String? orderId);

  UpdateReview fromUserId(String? fromUserId);

  UpdateReview toUserId(String? toUserId);

  UpdateReview category(ReviewCategory? category);

  UpdateReview score(num? score);

  UpdateReview comment(String? comment);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateReview(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateReview(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateReview call({
    String? orderId,
    String? fromUserId,
    String? toUserId,
    ReviewCategory? category,
    num? score,
    String? comment,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateReview.copyWith(...)` or call `instanceOfUpdateReview.copyWith.fieldName(value)` for a single field.
class _$UpdateReviewCWProxyImpl implements _$UpdateReviewCWProxy {
  const _$UpdateReviewCWProxyImpl(this._value);

  final UpdateReview _value;

  @override
  UpdateReview orderId(String? orderId) => call(orderId: orderId);

  @override
  UpdateReview fromUserId(String? fromUserId) => call(fromUserId: fromUserId);

  @override
  UpdateReview toUserId(String? toUserId) => call(toUserId: toUserId);

  @override
  UpdateReview category(ReviewCategory? category) => call(category: category);

  @override
  UpdateReview score(num? score) => call(score: score);

  @override
  UpdateReview comment(String? comment) => call(comment: comment);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateReview(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateReview(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateReview call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return UpdateReview(
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      fromUserId: fromUserId == const $CopyWithPlaceholder()
          ? _value.fromUserId
          // ignore: cast_nullable_to_non_nullable
          : fromUserId as String?,
      toUserId: toUserId == const $CopyWithPlaceholder()
          ? _value.toUserId
          // ignore: cast_nullable_to_non_nullable
          : toUserId as String?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as ReviewCategory?,
      score: score == const $CopyWithPlaceholder()
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as num?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
    );
  }
}

extension $UpdateReviewCopyWith on UpdateReview {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateReview.copyWith(...)` or `instanceOfUpdateReview.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateReviewCWProxy get copyWith => _$UpdateReviewCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateReview _$UpdateReviewFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateReview', json, ($checkedConvert) {
      final val = UpdateReview(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        fromUserId: $checkedConvert('fromUserId', (v) => v as String?),
        toUserId: $checkedConvert('toUserId', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) => $enumDecodeNullable(_$ReviewCategoryEnumMap, v),
        ),
        score: $checkedConvert('score', (v) => v as num?),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$UpdateReviewToJson(UpdateReview instance) =>
    <String, dynamic>{
      'orderId': ?instance.orderId,
      'fromUserId': ?instance.fromUserId,
      'toUserId': ?instance.toUserId,
      'category': ?_$ReviewCategoryEnumMap[instance.category],
      'score': ?instance.score,
      'comment': ?instance.comment,
    };

const _$ReviewCategoryEnumMap = {
  ReviewCategory.CLEANLINESS: 'CLEANLINESS',
  ReviewCategory.COURTESY: 'COURTESY',
  ReviewCategory.OTHER: 'OTHER',
};
