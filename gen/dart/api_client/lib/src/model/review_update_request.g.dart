// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewUpdateRequestCWProxy {
  ReviewUpdateRequest orderId(String? orderId);

  ReviewUpdateRequest fromUserId(String? fromUserId);

  ReviewUpdateRequest toUserId(String? toUserId);

  ReviewUpdateRequest category(ReviewUpdateRequestCategoryEnum? category);

  ReviewUpdateRequest score(num? score);

  ReviewUpdateRequest comment(String? comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewUpdateRequest call({
    String? orderId,
    String? fromUserId,
    String? toUserId,
    ReviewUpdateRequestCategoryEnum? category,
    num? score,
    String? comment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReviewUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReviewUpdateRequest.copyWith.fieldName(...)`
class _$ReviewUpdateRequestCWProxyImpl implements _$ReviewUpdateRequestCWProxy {
  const _$ReviewUpdateRequestCWProxyImpl(this._value);

  final ReviewUpdateRequest _value;

  @override
  ReviewUpdateRequest orderId(String? orderId) => this(orderId: orderId);

  @override
  ReviewUpdateRequest fromUserId(String? fromUserId) =>
      this(fromUserId: fromUserId);

  @override
  ReviewUpdateRequest toUserId(String? toUserId) => this(toUserId: toUserId);

  @override
  ReviewUpdateRequest category(ReviewUpdateRequestCategoryEnum? category) =>
      this(category: category);

  @override
  ReviewUpdateRequest score(num? score) => this(score: score);

  @override
  ReviewUpdateRequest comment(String? comment) => this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewUpdateRequest call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return ReviewUpdateRequest(
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
          : category as ReviewUpdateRequestCategoryEnum?,
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

extension $ReviewUpdateRequestCopyWith on ReviewUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfReviewUpdateRequest.copyWith(...)` or like so:`instanceOfReviewUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewUpdateRequestCWProxy get copyWith =>
      _$ReviewUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewUpdateRequest _$ReviewUpdateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReviewUpdateRequest', json, ($checkedConvert) {
      final val = ReviewUpdateRequest(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        fromUserId: $checkedConvert('fromUserId', (v) => v as String?),
        toUserId: $checkedConvert('toUserId', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) =>
              $enumDecodeNullable(_$ReviewUpdateRequestCategoryEnumEnumMap, v),
        ),
        score: $checkedConvert('score', (v) => v as num?),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$ReviewUpdateRequestToJson(
  ReviewUpdateRequest instance,
) => <String, dynamic>{
  'orderId': ?instance.orderId,
  'fromUserId': ?instance.fromUserId,
  'toUserId': ?instance.toUserId,
  'category': ?_$ReviewUpdateRequestCategoryEnumEnumMap[instance.category],
  'score': ?instance.score,
  'comment': ?instance.comment,
};

const _$ReviewUpdateRequestCategoryEnumEnumMap = {
  ReviewUpdateRequestCategoryEnum.cleanliness: 'cleanliness',
  ReviewUpdateRequestCategoryEnum.courtesy: 'courtesy',
  ReviewUpdateRequestCategoryEnum.other: 'other',
};
