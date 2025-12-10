// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_usage_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponUsageJobPayloadCWProxy {
  CouponUsageJobPayload couponId(String couponId);

  CouponUsageJobPayload userId(String userId);

  CouponUsageJobPayload orderId(String orderId);

  CouponUsageJobPayload discountAmount(num discountAmount);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponUsageJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponUsageJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponUsageJobPayload call({
    String couponId,
    String userId,
    String orderId,
    num discountAmount,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponUsageJobPayload.copyWith(...)` or call `instanceOfCouponUsageJobPayload.copyWith.fieldName(value)` for a single field.
class _$CouponUsageJobPayloadCWProxyImpl
    implements _$CouponUsageJobPayloadCWProxy {
  const _$CouponUsageJobPayloadCWProxyImpl(this._value);

  final CouponUsageJobPayload _value;

  @override
  CouponUsageJobPayload couponId(String couponId) => call(couponId: couponId);

  @override
  CouponUsageJobPayload userId(String userId) => call(userId: userId);

  @override
  CouponUsageJobPayload orderId(String orderId) => call(orderId: orderId);

  @override
  CouponUsageJobPayload discountAmount(num discountAmount) =>
      call(discountAmount: discountAmount);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponUsageJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponUsageJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponUsageJobPayload call({
    Object? couponId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
  }) {
    return CouponUsageJobPayload(
      couponId: couponId == const $CopyWithPlaceholder() || couponId == null
          ? _value.couponId
          // ignore: cast_nullable_to_non_nullable
          : couponId as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      discountAmount:
          discountAmount == const $CopyWithPlaceholder() ||
              discountAmount == null
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as num,
    );
  }
}

extension $CouponUsageJobPayloadCopyWith on CouponUsageJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponUsageJobPayload.copyWith(...)` or `instanceOfCouponUsageJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponUsageJobPayloadCWProxy get copyWith =>
      _$CouponUsageJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponUsageJobPayload _$CouponUsageJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponUsageJobPayload', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['couponId', 'userId', 'orderId', 'discountAmount'],
  );
  final val = CouponUsageJobPayload(
    couponId: $checkedConvert('couponId', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    orderId: $checkedConvert('orderId', (v) => v as String),
    discountAmount: $checkedConvert('discountAmount', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$CouponUsageJobPayloadToJson(
  CouponUsageJobPayload instance,
) => <String, dynamic>{
  'couponId': instance.couponId,
  'userId': instance.userId,
  'orderId': instance.orderId,
  'discountAmount': instance.discountAmount,
};
