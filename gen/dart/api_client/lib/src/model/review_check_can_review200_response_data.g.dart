// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_check_can_review200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewCheckCanReview200ResponseDataCWProxy {
  ReviewCheckCanReview200ResponseData canReview(bool canReview);

  ReviewCheckCanReview200ResponseData alreadyReviewed(bool alreadyReviewed);

  ReviewCheckCanReview200ResponseData orderCompleted(bool orderCompleted);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReviewCheckCanReview200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewCheckCanReview200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  ReviewCheckCanReview200ResponseData call({
    bool canReview,
    bool alreadyReviewed,
    bool orderCompleted,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReviewCheckCanReview200ResponseData.copyWith(...)` or call `instanceOfReviewCheckCanReview200ResponseData.copyWith.fieldName(value)` for a single field.
class _$ReviewCheckCanReview200ResponseDataCWProxyImpl
    implements _$ReviewCheckCanReview200ResponseDataCWProxy {
  const _$ReviewCheckCanReview200ResponseDataCWProxyImpl(this._value);

  final ReviewCheckCanReview200ResponseData _value;

  @override
  ReviewCheckCanReview200ResponseData canReview(bool canReview) =>
      call(canReview: canReview);

  @override
  ReviewCheckCanReview200ResponseData alreadyReviewed(bool alreadyReviewed) =>
      call(alreadyReviewed: alreadyReviewed);

  @override
  ReviewCheckCanReview200ResponseData orderCompleted(bool orderCompleted) =>
      call(orderCompleted: orderCompleted);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReviewCheckCanReview200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewCheckCanReview200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  ReviewCheckCanReview200ResponseData call({
    Object? canReview = const $CopyWithPlaceholder(),
    Object? alreadyReviewed = const $CopyWithPlaceholder(),
    Object? orderCompleted = const $CopyWithPlaceholder(),
  }) {
    return ReviewCheckCanReview200ResponseData(
      canReview: canReview == const $CopyWithPlaceholder() || canReview == null
          ? _value.canReview
          // ignore: cast_nullable_to_non_nullable
          : canReview as bool,
      alreadyReviewed:
          alreadyReviewed == const $CopyWithPlaceholder() ||
              alreadyReviewed == null
          ? _value.alreadyReviewed
          // ignore: cast_nullable_to_non_nullable
          : alreadyReviewed as bool,
      orderCompleted:
          orderCompleted == const $CopyWithPlaceholder() ||
              orderCompleted == null
          ? _value.orderCompleted
          // ignore: cast_nullable_to_non_nullable
          : orderCompleted as bool,
    );
  }
}

extension $ReviewCheckCanReview200ResponseDataCopyWith
    on ReviewCheckCanReview200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReviewCheckCanReview200ResponseData.copyWith(...)` or `instanceOfReviewCheckCanReview200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewCheckCanReview200ResponseDataCWProxy get copyWith =>
      _$ReviewCheckCanReview200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewCheckCanReview200ResponseData
_$ReviewCheckCanReview200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReviewCheckCanReview200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(
        json,
        requiredKeys: const ['canReview', 'alreadyReviewed', 'orderCompleted'],
      );
      final val = ReviewCheckCanReview200ResponseData(
        canReview: $checkedConvert('canReview', (v) => v as bool),
        alreadyReviewed: $checkedConvert('alreadyReviewed', (v) => v as bool),
        orderCompleted: $checkedConvert('orderCompleted', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$ReviewCheckCanReview200ResponseDataToJson(
  ReviewCheckCanReview200ResponseData instance,
) => <String, dynamic>{
  'canReview': instance.canReview,
  'alreadyReviewed': instance.alreadyReviewed,
  'orderCompleted': instance.orderCompleted,
};
