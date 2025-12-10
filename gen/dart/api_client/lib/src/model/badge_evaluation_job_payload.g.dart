// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_evaluation_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeEvaluationJobPayloadCWProxy {
  BadgeEvaluationJobPayload driverId(String driverId);

  BadgeEvaluationJobPayload userId(String userId);

  BadgeEvaluationJobPayload orderId(String orderId);

  BadgeEvaluationJobPayload orderType(
    BadgeEvaluationJobPayloadOrderTypeEnum orderType,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeEvaluationJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeEvaluationJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeEvaluationJobPayload call({
    String driverId,
    String userId,
    String orderId,
    BadgeEvaluationJobPayloadOrderTypeEnum orderType,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBadgeEvaluationJobPayload.copyWith(...)` or call `instanceOfBadgeEvaluationJobPayload.copyWith.fieldName(value)` for a single field.
class _$BadgeEvaluationJobPayloadCWProxyImpl
    implements _$BadgeEvaluationJobPayloadCWProxy {
  const _$BadgeEvaluationJobPayloadCWProxyImpl(this._value);

  final BadgeEvaluationJobPayload _value;

  @override
  BadgeEvaluationJobPayload driverId(String driverId) =>
      call(driverId: driverId);

  @override
  BadgeEvaluationJobPayload userId(String userId) => call(userId: userId);

  @override
  BadgeEvaluationJobPayload orderId(String orderId) => call(orderId: orderId);

  @override
  BadgeEvaluationJobPayload orderType(
    BadgeEvaluationJobPayloadOrderTypeEnum orderType,
  ) => call(orderType: orderType);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeEvaluationJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeEvaluationJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeEvaluationJobPayload call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
  }) {
    return BadgeEvaluationJobPayload(
      driverId: driverId == const $CopyWithPlaceholder() || driverId == null
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as BadgeEvaluationJobPayloadOrderTypeEnum,
    );
  }
}

extension $BadgeEvaluationJobPayloadCopyWith on BadgeEvaluationJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBadgeEvaluationJobPayload.copyWith(...)` or `instanceOfBadgeEvaluationJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeEvaluationJobPayloadCWProxy get copyWith =>
      _$BadgeEvaluationJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeEvaluationJobPayload _$BadgeEvaluationJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeEvaluationJobPayload', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['driverId', 'userId', 'orderId', 'orderType'],
  );
  final val = BadgeEvaluationJobPayload(
    driverId: $checkedConvert('driverId', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    orderId: $checkedConvert('orderId', (v) => v as String),
    orderType: $checkedConvert(
      'orderType',
      (v) => $enumDecode(_$BadgeEvaluationJobPayloadOrderTypeEnumEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$BadgeEvaluationJobPayloadToJson(
  BadgeEvaluationJobPayload instance,
) => <String, dynamic>{
  'driverId': instance.driverId,
  'userId': instance.userId,
  'orderId': instance.orderId,
  'orderType':
      _$BadgeEvaluationJobPayloadOrderTypeEnumEnumMap[instance.orderType]!,
};

const _$BadgeEvaluationJobPayloadOrderTypeEnumEnumMap = {
  BadgeEvaluationJobPayloadOrderTypeEnum.RIDE: 'RIDE',
  BadgeEvaluationJobPayloadOrderTypeEnum.DELIVERY: 'DELIVERY',
  BadgeEvaluationJobPayloadOrderTypeEnum.FOOD: 'FOOD',
};
