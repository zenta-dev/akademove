// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_review.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertReviewCWProxy {
  InsertReview orderId(String orderId);

  InsertReview fromUserId(String fromUserId);

  InsertReview toUserId(String toUserId);

  InsertReview categories(List<ReviewCategory> categories);

  InsertReview score(int score);

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
    List<ReviewCategory> categories,
    int score,
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
  InsertReview categories(List<ReviewCategory> categories) =>
      call(categories: categories);

  @override
  InsertReview score(int score) => call(score: score);

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
    Object? categories = const $CopyWithPlaceholder(),
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
      categories:
          categories == const $CopyWithPlaceholder() || categories == null
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as List<ReviewCategory>,
      score: score == const $CopyWithPlaceholder() || score == null
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as int,
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
          'categories',
          'score',
        ],
      );
      final val = InsertReview(
        orderId: $checkedConvert('orderId', (v) => v as String),
        fromUserId: $checkedConvert('fromUserId', (v) => v as String),
        toUserId: $checkedConvert('toUserId', (v) => v as String),
        categories: $checkedConvert(
          'categories',
          (v) => (v as List<dynamic>)
              .map((e) => $enumDecode(_$ReviewCategoryEnumMap, e))
              .toList(),
        ),
        score: $checkedConvert('score', (v) => (v as num).toInt()),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$InsertReviewToJson(InsertReview instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'categories': instance.categories
          .map((e) => _$ReviewCategoryEnumMap[e]!)
          .toList(),
      'score': instance.score,
      'comment': ?instance.comment,
    };

const _$ReviewCategoryEnumMap = {
  ReviewCategory.CLEANLINESS: 'CLEANLINESS',
  ReviewCategory.COURTESY: 'COURTESY',
  ReviewCategory.PUNCTUALITY: 'PUNCTUALITY',
  ReviewCategory.SAFETY: 'SAFETY',
  ReviewCategory.COMMUNICATION: 'COMMUNICATION',
  ReviewCategory.OTHER: 'OTHER',
};
