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

  Review category(ReviewCategory category);

  Review score(num score);

  Review comment(String? comment);

  Review createdAt(DateTime createdAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Review(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Review(...).copyWith(id: 12, name: "My name")
  /// ```
  Review call({
    String id,
    String orderId,
    String fromUserId,
    String toUserId,
    ReviewCategory category,
    num score,
    String? comment,
    DateTime createdAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReview.copyWith(...)` or call `instanceOfReview.copyWith.fieldName(value)` for a single field.
class _$ReviewCWProxyImpl implements _$ReviewCWProxy {
  const _$ReviewCWProxyImpl(this._value);

  final Review _value;

  @override
  Review id(String id) => call(id: id);

  @override
  Review orderId(String orderId) => call(orderId: orderId);

  @override
  Review fromUserId(String fromUserId) => call(fromUserId: fromUserId);

  @override
  Review toUserId(String toUserId) => call(toUserId: toUserId);

  @override
  Review category(ReviewCategory category) => call(category: category);

  @override
  Review score(num score) => call(score: score);

  @override
  Review comment(String? comment) => call(comment: comment);

  @override
  Review createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Review(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Review(...).copyWith(id: 12, name: "My name")
  /// ```
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
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      fromUserId: fromUserId == const $CopyWithPlaceholder() || fromUserId == null
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
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
    );
  }
}

extension $ReviewCopyWith on Review {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReview.copyWith(...)` or `instanceOfReview.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewCWProxy get copyWith => _$ReviewCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => $checkedCreate('Review', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'orderId', 'fromUserId', 'toUserId', 'category', 'score', 'createdAt']);
  final val = Review(
    id: $checkedConvert('id', (v) => v as String),
    orderId: $checkedConvert('orderId', (v) => v as String),
    fromUserId: $checkedConvert('fromUserId', (v) => v as String),
    toUserId: $checkedConvert('toUserId', (v) => v as String),
    category: $checkedConvert('category', (v) => $enumDecode(_$ReviewCategoryEnumMap, v)),
    score: $checkedConvert('score', (v) => v as num),
    comment: $checkedConvert('comment', (v) => v as String? ?? ''),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'category': _$ReviewCategoryEnumMap[instance.category]!,
  'score': instance.score,
  'comment': ?instance.comment,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$ReviewCategoryEnumMap = {
  ReviewCategory.CLEANLINESS: 'CLEANLINESS',
  ReviewCategory.COURTESY: 'COURTESY',
  ReviewCategory.OTHER: 'OTHER',
};
