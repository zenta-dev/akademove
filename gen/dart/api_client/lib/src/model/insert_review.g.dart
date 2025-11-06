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

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertReview(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertReview(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertReview call({
    String orderId,
    String fromUserId,
    String toUserId,
    ReviewCategory category,
    num score,
    String? comment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertReview.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertReview.copyWith.fieldName(...)`
class _$InsertReviewCWProxyImpl implements _$InsertReviewCWProxy {
  const _$InsertReviewCWProxyImpl(this._value);

  final InsertReview _value;

  @override
  InsertReview orderId(String orderId) => this(orderId: orderId);

  @override
  InsertReview fromUserId(String fromUserId) => this(fromUserId: fromUserId);

  @override
  InsertReview toUserId(String toUserId) => this(toUserId: toUserId);

  @override
  InsertReview category(ReviewCategory category) => this(category: category);

  @override
  InsertReview score(num score) => this(score: score);

  @override
  InsertReview comment(String? comment) => this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertReview(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertReview(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertReview call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return InsertReview(
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      fromUserId: fromUserId == const $CopyWithPlaceholder()
          ? _value.fromUserId
          // ignore: cast_nullable_to_non_nullable
          : fromUserId as String,
      toUserId: toUserId == const $CopyWithPlaceholder()
          ? _value.toUserId
          // ignore: cast_nullable_to_non_nullable
          : toUserId as String,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as ReviewCategory,
      score: score == const $CopyWithPlaceholder()
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
  /// Returns a callable class that can be used as follows: `instanceOfInsertReview.copyWith(...)` or like so:`instanceOfInsertReview.copyWith.fieldName(...)`.
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
