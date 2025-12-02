// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_get_eligible_coupons200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponGetEligibleCoupons200ResponseDataCWProxy {
  CouponGetEligibleCoupons200ResponseData coupons(List<Coupon> coupons);

  CouponGetEligibleCoupons200ResponseData bestCoupon(Coupon? bestCoupon);

  CouponGetEligibleCoupons200ResponseData bestDiscountAmount(
    num bestDiscountAmount,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponGetEligibleCoupons200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponGetEligibleCoupons200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponGetEligibleCoupons200ResponseData call({
    List<Coupon> coupons,
    Coupon? bestCoupon,
    num bestDiscountAmount,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponGetEligibleCoupons200ResponseData.copyWith(...)` or call `instanceOfCouponGetEligibleCoupons200ResponseData.copyWith.fieldName(value)` for a single field.
class _$CouponGetEligibleCoupons200ResponseDataCWProxyImpl
    implements _$CouponGetEligibleCoupons200ResponseDataCWProxy {
  const _$CouponGetEligibleCoupons200ResponseDataCWProxyImpl(this._value);

  final CouponGetEligibleCoupons200ResponseData _value;

  @override
  CouponGetEligibleCoupons200ResponseData coupons(List<Coupon> coupons) =>
      call(coupons: coupons);

  @override
  CouponGetEligibleCoupons200ResponseData bestCoupon(Coupon? bestCoupon) =>
      call(bestCoupon: bestCoupon);

  @override
  CouponGetEligibleCoupons200ResponseData bestDiscountAmount(
    num bestDiscountAmount,
  ) => call(bestDiscountAmount: bestDiscountAmount);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponGetEligibleCoupons200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponGetEligibleCoupons200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponGetEligibleCoupons200ResponseData call({
    Object? coupons = const $CopyWithPlaceholder(),
    Object? bestCoupon = const $CopyWithPlaceholder(),
    Object? bestDiscountAmount = const $CopyWithPlaceholder(),
  }) {
    return CouponGetEligibleCoupons200ResponseData(
      coupons: coupons == const $CopyWithPlaceholder() || coupons == null
          ? _value.coupons
          // ignore: cast_nullable_to_non_nullable
          : coupons as List<Coupon>,
      bestCoupon: bestCoupon == const $CopyWithPlaceholder()
          ? _value.bestCoupon
          // ignore: cast_nullable_to_non_nullable
          : bestCoupon as Coupon?,
      bestDiscountAmount:
          bestDiscountAmount == const $CopyWithPlaceholder() ||
              bestDiscountAmount == null
          ? _value.bestDiscountAmount
          // ignore: cast_nullable_to_non_nullable
          : bestDiscountAmount as num,
    );
  }
}

extension $CouponGetEligibleCoupons200ResponseDataCopyWith
    on CouponGetEligibleCoupons200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponGetEligibleCoupons200ResponseData.copyWith(...)` or `instanceOfCouponGetEligibleCoupons200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponGetEligibleCoupons200ResponseDataCWProxy get copyWith =>
      _$CouponGetEligibleCoupons200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponGetEligibleCoupons200ResponseData
_$CouponGetEligibleCoupons200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CouponGetEligibleCoupons200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(
        json,
        requiredKeys: const ['coupons', 'bestCoupon', 'bestDiscountAmount'],
      );
      final val = CouponGetEligibleCoupons200ResponseData(
        coupons: $checkedConvert(
          'coupons',
          (v) => (v as List<dynamic>)
              .map((e) => Coupon.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        bestCoupon: $checkedConvert(
          'bestCoupon',
          (v) => v == null ? null : Coupon.fromJson(v as Map<String, dynamic>),
        ),
        bestDiscountAmount: $checkedConvert(
          'bestDiscountAmount',
          (v) => v as num,
        ),
      );
      return val;
    });

Map<String, dynamic> _$CouponGetEligibleCoupons200ResponseDataToJson(
  CouponGetEligibleCoupons200ResponseData instance,
) => <String, dynamic>{
  'coupons': instance.coupons.map((e) => e.toJson()).toList(),
  'bestCoupon': instance.bestCoupon?.toJson(),
  'bestDiscountAmount': instance.bestDiscountAmount,
};
