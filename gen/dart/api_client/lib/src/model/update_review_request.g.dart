// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_review_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateReviewRequestCWProxy {
  UpdateReviewRequest orderId(String? orderId);

  UpdateReviewRequest fromUserId(String? fromUserId);

  UpdateReviewRequest toUserId(String? toUserId);

  UpdateReviewRequest category(UpdateReviewRequestCategoryEnum? category);

  UpdateReviewRequest score(num? score);

  UpdateReviewRequest comment(String? comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateReviewRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateReviewRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateReviewRequest call({
    String? orderId,
    String? fromUserId,
    String? toUserId,
    UpdateReviewRequestCategoryEnum? category,
    num? score,
    String? comment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateReviewRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateReviewRequest.copyWith.fieldName(...)`
class _$UpdateReviewRequestCWProxyImpl implements _$UpdateReviewRequestCWProxy {
  const _$UpdateReviewRequestCWProxyImpl(this._value);

  final UpdateReviewRequest _value;

  @override
  UpdateReviewRequest orderId(String? orderId) => this(orderId: orderId);

  @override
  UpdateReviewRequest fromUserId(String? fromUserId) =>
      this(fromUserId: fromUserId);

  @override
  UpdateReviewRequest toUserId(String? toUserId) => this(toUserId: toUserId);

  @override
  UpdateReviewRequest category(UpdateReviewRequestCategoryEnum? category) =>
      this(category: category);

  @override
  UpdateReviewRequest score(num? score) => this(score: score);

  @override
  UpdateReviewRequest comment(String? comment) => this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateReviewRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateReviewRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateReviewRequest call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return UpdateReviewRequest(
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
          : category as UpdateReviewRequestCategoryEnum?,
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

extension $UpdateReviewRequestCopyWith on UpdateReviewRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateReviewRequest.copyWith(...)` or like so:`instanceOfUpdateReviewRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateReviewRequestCWProxy get copyWith =>
      _$UpdateReviewRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateReviewRequest _$UpdateReviewRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateReviewRequest', json, ($checkedConvert) {
      final val = UpdateReviewRequest(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        fromUserId: $checkedConvert('fromUserId', (v) => v as String?),
        toUserId: $checkedConvert('toUserId', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) =>
              $enumDecodeNullable(_$UpdateReviewRequestCategoryEnumEnumMap, v),
        ),
        score: $checkedConvert('score', (v) => v as num?),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$UpdateReviewRequestToJson(
  UpdateReviewRequest instance,
) => <String, dynamic>{
  'orderId': ?instance.orderId,
  'fromUserId': ?instance.fromUserId,
  'toUserId': ?instance.toUserId,
  'category': ?_$UpdateReviewRequestCategoryEnumEnumMap[instance.category],
  'score': ?instance.score,
  'comment': ?instance.comment,
};

const _$UpdateReviewRequestCategoryEnumEnumMap = {
  UpdateReviewRequestCategoryEnum.cleanliness: 'cleanliness',
  UpdateReviewRequestCategoryEnum.courtesy: 'courtesy',
  UpdateReviewRequestCategoryEnum.other: 'other',
};
