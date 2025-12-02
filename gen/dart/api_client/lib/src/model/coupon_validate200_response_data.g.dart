// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_validate200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponValidate200ResponseDataCWProxy {
  CouponValidate200ResponseData valid(bool valid);

  CouponValidate200ResponseData coupon(Coupon? coupon);

  CouponValidate200ResponseData discountAmount(num discountAmount);

  CouponValidate200ResponseData finalAmount(num finalAmount);

  CouponValidate200ResponseData reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponValidate200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponValidate200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponValidate200ResponseData call({bool valid, Coupon? coupon, num discountAmount, num finalAmount, String? reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponValidate200ResponseData.copyWith(...)` or call `instanceOfCouponValidate200ResponseData.copyWith.fieldName(value)` for a single field.
class _$CouponValidate200ResponseDataCWProxyImpl implements _$CouponValidate200ResponseDataCWProxy {
  const _$CouponValidate200ResponseDataCWProxyImpl(this._value);

  final CouponValidate200ResponseData _value;

  @override
  CouponValidate200ResponseData valid(bool valid) => call(valid: valid);

  @override
  CouponValidate200ResponseData coupon(Coupon? coupon) => call(coupon: coupon);

  @override
  CouponValidate200ResponseData discountAmount(num discountAmount) => call(discountAmount: discountAmount);

  @override
  CouponValidate200ResponseData finalAmount(num finalAmount) => call(finalAmount: finalAmount);

  @override
  CouponValidate200ResponseData reason(String? reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponValidate200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponValidate200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponValidate200ResponseData call({
    Object? valid = const $CopyWithPlaceholder(),
    Object? coupon = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? finalAmount = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return CouponValidate200ResponseData(
      valid: valid == const $CopyWithPlaceholder() || valid == null
          ? _value.valid
          // ignore: cast_nullable_to_non_nullable
          : valid as bool,
      coupon: coupon == const $CopyWithPlaceholder()
          ? _value.coupon
          // ignore: cast_nullable_to_non_nullable
          : coupon as Coupon?,
      discountAmount: discountAmount == const $CopyWithPlaceholder() || discountAmount == null
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as num,
      finalAmount: finalAmount == const $CopyWithPlaceholder() || finalAmount == null
          ? _value.finalAmount
          // ignore: cast_nullable_to_non_nullable
          : finalAmount as num,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $CouponValidate200ResponseDataCopyWith on CouponValidate200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponValidate200ResponseData.copyWith(...)` or `instanceOfCouponValidate200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponValidate200ResponseDataCWProxy get copyWith => _$CouponValidate200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponValidate200ResponseData _$CouponValidate200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponValidate200ResponseData', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['valid', 'discountAmount', 'finalAmount']);
      final val = CouponValidate200ResponseData(
        valid: $checkedConvert('valid', (v) => v as bool),
        coupon: $checkedConvert('coupon', (v) => v == null ? null : Coupon.fromJson(v as Map<String, dynamic>)),
        discountAmount: $checkedConvert('discountAmount', (v) => v as num),
        finalAmount: $checkedConvert('finalAmount', (v) => v as num),
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$CouponValidate200ResponseDataToJson(CouponValidate200ResponseData instance) => <String, dynamic>{
  'valid': instance.valid,
  'coupon': ?instance.coupon?.toJson(),
  'discountAmount': instance.discountAmount,
  'finalAmount': instance.finalAmount,
  'reason': ?instance.reason,
};
