// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewCreateRequestCWProxy {
  ReviewCreateRequest orderId(String orderId);

  ReviewCreateRequest fromUserId(String fromUserId);

  ReviewCreateRequest toUserId(String toUserId);

  ReviewCreateRequest category(ReviewCreateRequestCategoryEnum category);

  ReviewCreateRequest score(num score);

  ReviewCreateRequest comment(String? comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewCreateRequest call({
    String orderId,
    String fromUserId,
    String toUserId,
    ReviewCreateRequestCategoryEnum category,
    num score,
    String? comment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReviewCreateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReviewCreateRequest.copyWith.fieldName(...)`
class _$ReviewCreateRequestCWProxyImpl implements _$ReviewCreateRequestCWProxy {
  const _$ReviewCreateRequestCWProxyImpl(this._value);

  final ReviewCreateRequest _value;

  @override
  ReviewCreateRequest orderId(String orderId) => this(orderId: orderId);

  @override
  ReviewCreateRequest fromUserId(String fromUserId) =>
      this(fromUserId: fromUserId);

  @override
  ReviewCreateRequest toUserId(String toUserId) => this(toUserId: toUserId);

  @override
  ReviewCreateRequest category(ReviewCreateRequestCategoryEnum category) =>
      this(category: category);

  @override
  ReviewCreateRequest score(num score) => this(score: score);

  @override
  ReviewCreateRequest comment(String? comment) => this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewCreateRequest call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return ReviewCreateRequest(
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
          : category as ReviewCreateRequestCategoryEnum,
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

extension $ReviewCreateRequestCopyWith on ReviewCreateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfReviewCreateRequest.copyWith(...)` or like so:`instanceOfReviewCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewCreateRequestCWProxy get copyWith =>
      _$ReviewCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewCreateRequest _$ReviewCreateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReviewCreateRequest', json, ($checkedConvert) {
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
      final val = ReviewCreateRequest(
        orderId: $checkedConvert('orderId', (v) => v as String),
        fromUserId: $checkedConvert('fromUserId', (v) => v as String),
        toUserId: $checkedConvert('toUserId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$ReviewCreateRequestCategoryEnumEnumMap, v),
        ),
        score: $checkedConvert('score', (v) => v as num),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$ReviewCreateRequestToJson(
  ReviewCreateRequest instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'category': _$ReviewCreateRequestCategoryEnumEnumMap[instance.category]!,
  'score': instance.score,
  'comment': ?instance.comment,
};

const _$ReviewCreateRequestCategoryEnumEnumMap = {
  ReviewCreateRequestCategoryEnum.cleanliness: 'cleanliness',
  ReviewCreateRequestCategoryEnum.courtesy: 'courtesy',
  ReviewCreateRequestCategoryEnum.other: 'other',
};
