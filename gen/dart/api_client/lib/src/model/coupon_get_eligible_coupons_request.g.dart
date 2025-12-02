// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_get_eligible_coupons_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponGetEligibleCouponsRequestCWProxy {
  CouponGetEligibleCouponsRequest serviceType(OrderType serviceType);

  CouponGetEligibleCouponsRequest totalAmount(num totalAmount);

  CouponGetEligibleCouponsRequest merchantId(String? merchantId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponGetEligibleCouponsRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponGetEligibleCouponsRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponGetEligibleCouponsRequest call({
    OrderType serviceType,
    num totalAmount,
    String? merchantId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponGetEligibleCouponsRequest.copyWith(...)` or call `instanceOfCouponGetEligibleCouponsRequest.copyWith.fieldName(value)` for a single field.
class _$CouponGetEligibleCouponsRequestCWProxyImpl
    implements _$CouponGetEligibleCouponsRequestCWProxy {
  const _$CouponGetEligibleCouponsRequestCWProxyImpl(this._value);

  final CouponGetEligibleCouponsRequest _value;

  @override
  CouponGetEligibleCouponsRequest serviceType(OrderType serviceType) =>
      call(serviceType: serviceType);

  @override
  CouponGetEligibleCouponsRequest totalAmount(num totalAmount) =>
      call(totalAmount: totalAmount);

  @override
  CouponGetEligibleCouponsRequest merchantId(String? merchantId) =>
      call(merchantId: merchantId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponGetEligibleCouponsRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponGetEligibleCouponsRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponGetEligibleCouponsRequest call({
    Object? serviceType = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
  }) {
    return CouponGetEligibleCouponsRequest(
      serviceType:
          serviceType == const $CopyWithPlaceholder() || serviceType == null
          ? _value.serviceType
          // ignore: cast_nullable_to_non_nullable
          : serviceType as OrderType,
      totalAmount:
          totalAmount == const $CopyWithPlaceholder() || totalAmount == null
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as num,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
    );
  }
}

extension $CouponGetEligibleCouponsRequestCopyWith
    on CouponGetEligibleCouponsRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponGetEligibleCouponsRequest.copyWith(...)` or `instanceOfCouponGetEligibleCouponsRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponGetEligibleCouponsRequestCWProxy get copyWith =>
      _$CouponGetEligibleCouponsRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponGetEligibleCouponsRequest _$CouponGetEligibleCouponsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponGetEligibleCouponsRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['serviceType', 'totalAmount']);
  final val = CouponGetEligibleCouponsRequest(
    serviceType: $checkedConvert(
      'serviceType',
      (v) => $enumDecode(_$OrderTypeEnumMap, v),
    ),
    totalAmount: $checkedConvert('totalAmount', (v) => v as num),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$CouponGetEligibleCouponsRequestToJson(
  CouponGetEligibleCouponsRequest instance,
) => <String, dynamic>{
  'serviceType': _$OrderTypeEnumMap[instance.serviceType]!,
  'totalAmount': instance.totalAmount,
  'merchantId': ?instance.merchantId,
};

const _$OrderTypeEnumMap = {
  OrderType.RIDE: 'RIDE',
  OrderType.DELIVERY: 'DELIVERY',
  OrderType.FOOD: 'FOOD',
};
