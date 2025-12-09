// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_fraud_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewFraudEventCWProxy {
  ReviewFraudEvent status(ReviewFraudEventStatusEnum status);

  ReviewFraudEvent resolution(String? resolution);

  ReviewFraudEvent actionTaken(String? actionTaken);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReviewFraudEvent(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewFraudEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  ReviewFraudEvent call({
    ReviewFraudEventStatusEnum status,
    String? resolution,
    String? actionTaken,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReviewFraudEvent.copyWith(...)` or call `instanceOfReviewFraudEvent.copyWith.fieldName(value)` for a single field.
class _$ReviewFraudEventCWProxyImpl implements _$ReviewFraudEventCWProxy {
  const _$ReviewFraudEventCWProxyImpl(this._value);

  final ReviewFraudEvent _value;

  @override
  ReviewFraudEvent status(ReviewFraudEventStatusEnum status) =>
      call(status: status);

  @override
  ReviewFraudEvent resolution(String? resolution) =>
      call(resolution: resolution);

  @override
  ReviewFraudEvent actionTaken(String? actionTaken) =>
      call(actionTaken: actionTaken);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReviewFraudEvent(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewFraudEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  ReviewFraudEvent call({
    Object? status = const $CopyWithPlaceholder(),
    Object? resolution = const $CopyWithPlaceholder(),
    Object? actionTaken = const $CopyWithPlaceholder(),
  }) {
    return ReviewFraudEvent(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ReviewFraudEventStatusEnum,
      resolution: resolution == const $CopyWithPlaceholder()
          ? _value.resolution
          // ignore: cast_nullable_to_non_nullable
          : resolution as String?,
      actionTaken: actionTaken == const $CopyWithPlaceholder()
          ? _value.actionTaken
          // ignore: cast_nullable_to_non_nullable
          : actionTaken as String?,
    );
  }
}

extension $ReviewFraudEventCopyWith on ReviewFraudEvent {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReviewFraudEvent.copyWith(...)` or `instanceOfReviewFraudEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewFraudEventCWProxy get copyWith => _$ReviewFraudEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewFraudEvent _$ReviewFraudEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReviewFraudEvent', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['status']);
      final val = ReviewFraudEvent(
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$ReviewFraudEventStatusEnumEnumMap, v),
        ),
        resolution: $checkedConvert('resolution', (v) => v as String?),
        actionTaken: $checkedConvert('actionTaken', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ReviewFraudEventToJson(ReviewFraudEvent instance) =>
    <String, dynamic>{
      'status': _$ReviewFraudEventStatusEnumEnumMap[instance.status]!,
      'resolution': ?instance.resolution,
      'actionTaken': ?instance.actionTaken,
    };

const _$ReviewFraudEventStatusEnumEnumMap = {
  ReviewFraudEventStatusEnum.REVIEWING: 'REVIEWING',
  ReviewFraudEventStatusEnum.CONFIRMED: 'CONFIRMED',
  ReviewFraudEventStatusEnum.DISMISSED: 'DISMISSED',
};
