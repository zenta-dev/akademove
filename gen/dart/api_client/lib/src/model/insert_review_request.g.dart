// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_review_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertReviewRequestCWProxy {
  InsertReviewRequest orderId(String orderId);

  InsertReviewRequest fromUserId(String fromUserId);

  InsertReviewRequest toUserId(String toUserId);

  InsertReviewRequest category(InsertReviewRequestCategoryEnum category);

  InsertReviewRequest score(num score);

  InsertReviewRequest comment(String? comment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertReviewRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertReviewRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertReviewRequest call({
    String orderId,
    String fromUserId,
    String toUserId,
    InsertReviewRequestCategoryEnum category,
    num score,
    String? comment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertReviewRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertReviewRequest.copyWith.fieldName(...)`
class _$InsertReviewRequestCWProxyImpl implements _$InsertReviewRequestCWProxy {
  const _$InsertReviewRequestCWProxyImpl(this._value);

  final InsertReviewRequest _value;

  @override
  InsertReviewRequest orderId(String orderId) => this(orderId: orderId);

  @override
  InsertReviewRequest fromUserId(String fromUserId) =>
      this(fromUserId: fromUserId);

  @override
  InsertReviewRequest toUserId(String toUserId) => this(toUserId: toUserId);

  @override
  InsertReviewRequest category(InsertReviewRequestCategoryEnum category) =>
      this(category: category);

  @override
  InsertReviewRequest score(num score) => this(score: score);

  @override
  InsertReviewRequest comment(String? comment) => this(comment: comment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertReviewRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertReviewRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertReviewRequest call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? fromUserId = const $CopyWithPlaceholder(),
    Object? toUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return InsertReviewRequest(
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
          : category as InsertReviewRequestCategoryEnum,
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

extension $InsertReviewRequestCopyWith on InsertReviewRequest {
  /// Returns a callable class that can be used as follows: `instanceOfInsertReviewRequest.copyWith(...)` or like so:`instanceOfInsertReviewRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertReviewRequestCWProxy get copyWith =>
      _$InsertReviewRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertReviewRequest _$InsertReviewRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertReviewRequest', json, ($checkedConvert) {
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
      final val = InsertReviewRequest(
        orderId: $checkedConvert('orderId', (v) => v as String),
        fromUserId: $checkedConvert('fromUserId', (v) => v as String),
        toUserId: $checkedConvert('toUserId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$InsertReviewRequestCategoryEnumEnumMap, v),
        ),
        score: $checkedConvert('score', (v) => v as num),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$InsertReviewRequestToJson(
  InsertReviewRequest instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'category': _$InsertReviewRequestCategoryEnumEnumMap[instance.category]!,
  'score': instance.score,
  'comment': ?instance.comment,
};

const _$InsertReviewRequestCategoryEnumEnumMap = {
  InsertReviewRequestCategoryEnum.cleanliness: 'cleanliness',
  InsertReviewRequestCategoryEnum.courtesy: 'courtesy',
  InsertReviewRequestCategoryEnum.other: 'other',
};
