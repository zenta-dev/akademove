// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewCWProxy {
  Review id(String id);

  Review orderId(String orderId);

  Review fromUserId(String fromUserId);

  Review toUserId(String toUserId);

  Review category(ReviewCategoryEnum category);

  Review score(num score);

  Review comment(String? comment);

  Review createdAt(DateTime createdAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Review(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Review(...).copyWith(id: 12, name: "My name")
  /// ````
  Review call({
    String id,
    String orderId,
    String fromUserId,
    String toUserId,
    ReviewCategoryEnum category,
    num score,
    String? comment,
    DateTime createdAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReview.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReview.copyWith.fieldName(...)`
class _$ReviewCWProxyImpl implements _$ReviewCWProxy {
  const _$ReviewCWProxyImpl(this._value);

  final Review _value;

  @override
  Review id(String id) => this(id: id);

  @override
  Review orderId(String orderId) => this(orderId: orderId);

  @override
  Review fromUserId(String fromUserId) => this(fromUserId: fromUserId);

  @override
  Review toUserId(String toUserId) => this(toUserId: toUserId);

  @override
  Review category(ReviewCategoryEnum category) => this(category: category);

  @override
  Review score(num score) => this(score: score);

  @override
  Review comment(String? comment) => this(comment: comment);

  @override
  Review createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Review(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Review(...).copyWith(id: 12, name: "My name")
  /// ````
  Review call({
    Object? id = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return Review(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
          : category as ReviewCategoryEnum,
      score: score == const $CopyWithPlaceholder()
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as num,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $ReviewCopyWith on Review {
  /// Returns a callable class that can be used as follows: `instanceOfReview.copyWith(...)` or like so:`instanceOfReview.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewCWProxy get copyWith => _$ReviewCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Review', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'orderId',
          'fromUserId',
          'toUserId',
          'category',
          'score',
          'createdAt',
        ],
      );
      final val = Review(
        id: $checkedConvert('id', (v) => v as String),
        orderId: $checkedConvert('orderId', (v) => v as String),
        fromUserId: $checkedConvert('fromUserId', (v) => v as String),
        toUserId: $checkedConvert('toUserId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$ReviewCategoryEnumEnumMap, v),
        ),
        score: $checkedConvert('score', (v) => v as num),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'category': _$ReviewCategoryEnumEnumMap[instance.category]!,
  'score': instance.score,
  'comment': ?instance.comment,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$ReviewCategoryEnumEnumMap = {
  ReviewCategoryEnum.cleanliness: 'cleanliness',
  ReviewCategoryEnum.courtesy: 'courtesy',
  ReviewCategoryEnum.other: 'other',
};
