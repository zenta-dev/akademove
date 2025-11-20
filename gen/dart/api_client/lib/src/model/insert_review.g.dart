// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_review.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertReviewCWProxy {
  InsertReview orderId(String orderId);

  InsertReview fromUserId(String fromUserId);

  InsertReview toUserId(String toUserId);

  InsertReview category(ReviewCategory category);

  InsertReview score(num score);

  InsertReview comment(String? comment);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertReview(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertReview(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertReview call({
    String orderId,
    String fromUserId,
    String toUserId,
    ReviewCategory category,
    num score,
    String? comment,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertReview.copyWith(...)` or call `instanceOfInsertReview.copyWith.fieldName(value)` for a single field.
class _$InsertReviewCWProxyImpl implements _$InsertReviewCWProxy {
  const _$InsertReviewCWProxyImpl(this._value);

  final InsertReview _value;

  @override
  InsertReview orderId(String orderId) => call(orderId: orderId);

  @override
  InsertReview fromUserId(String fromUserId) => call(fromUserId: fromUserId);

  @override
  InsertReview toUserId(String toUserId) => call(toUserId: toUserId);

  @override
  InsertReview category(ReviewCategory category) => call(category: category);

  @override
  InsertReview score(num score) => call(score: score);

  @override
  InsertReview comment(String? comment) => call(comment: comment);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertReview(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertReview(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertReview call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return InsertReview(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      fromUserId:
          fromUserId == const $CopyWithPlaceholder() || fromUserId == null
          ? _value.fromUserId
          // ignore: cast_nullable_to_non_nullable
          : fromUserId as String,
      toUserId: toUserId == const $CopyWithPlaceholder() || toUserId == null
          ? _value.toUserId
          // ignore: cast_nullable_to_non_nullable
          : toUserId as String,
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as ReviewCategory,
      score: score == const $CopyWithPlaceholder() || score == null
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as num,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
    );
  }
}

extension $InsertReviewCopyWith on InsertReview {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertReview.copyWith(...)` or `instanceOfInsertReview.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertReviewCWProxy get copyWith => _$InsertReviewCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertReview _$InsertReviewFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertReview', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'orderId',
          'fromUserId',
          'toUserId',
          'category',
          'score',
        ],
      );
      final val = InsertReview(
        orderId: $checkedConvert('orderId', (v) => v as String),
        fromUserId: $checkedConvert('fromUserId', (v) => v as String),
        toUserId: $checkedConvert('toUserId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$ReviewCategoryEnumMap, v),
        ),
        score: $checkedConvert('score', (v) => v as num),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$InsertReviewToJson(InsertReview instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'category': _$ReviewCategoryEnumMap[instance.category]!,
      'score': instance.score,
      'comment': ?instance.comment,
    };

const _$ReviewCategoryEnumMap = {
  ReviewCategory.cleanliness: 'cleanliness',
  ReviewCategory.courtesy: 'courtesy',
  ReviewCategory.other: 'other',
};
