// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_validate_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CouponValidateRequestCWProxy {
  CouponValidateRequest code(String? code);

  CouponValidateRequest orderAmount(num orderAmount);

  CouponValidateRequest serviceType(OrderType? serviceType);

  CouponValidateRequest merchantId(String? merchantId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponValidateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponValidateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponValidateRequest call({
    String? code,
    num orderAmount,
    OrderType? serviceType,
    String? merchantId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCouponValidateRequest.copyWith(...)` or call `instanceOfCouponValidateRequest.copyWith.fieldName(value)` for a single field.
class _$CouponValidateRequestCWProxyImpl
    implements _$CouponValidateRequestCWProxy {
  const _$CouponValidateRequestCWProxyImpl(this._value);

  final CouponValidateRequest _value;

  @override
  CouponValidateRequest code(String? code) => call(code: code);

  @override
  CouponValidateRequest orderAmount(num orderAmount) =>
      call(orderAmount: orderAmount);

  @override
  CouponValidateRequest serviceType(OrderType? serviceType) =>
      call(serviceType: serviceType);

  @override
  CouponValidateRequest merchantId(String? merchantId) =>
      call(merchantId: merchantId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CouponValidateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CouponValidateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  CouponValidateRequest call({
    Object? code = const $CopyWithPlaceholder(),
    Object? orderAmount = const $CopyWithPlaceholder(),
    Object? serviceType = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
  }) {
    return CouponValidateRequest(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      orderAmount:
          orderAmount == const $CopyWithPlaceholder() || orderAmount == null
          ? _value.orderAmount
          // ignore: cast_nullable_to_non_nullable
          : orderAmount as num,
      serviceType: serviceType == const $CopyWithPlaceholder()
          ? _value.serviceType
          // ignore: cast_nullable_to_non_nullable
          : serviceType as OrderType?,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
    );
  }
}

extension $CouponValidateRequestCopyWith on CouponValidateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCouponValidateRequest.copyWith(...)` or `instanceOfCouponValidateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CouponValidateRequestCWProxy get copyWith =>
      _$CouponValidateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponValidateRequest _$CouponValidateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CouponValidateRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['code', 'orderAmount']);
  final val = CouponValidateRequest(
    code: $checkedConvert('code', (v) => v as String?),
    orderAmount: $checkedConvert('orderAmount', (v) => v as num),
    serviceType: $checkedConvert(
      'serviceType',
      (v) => $enumDecodeNullable(_$OrderTypeEnumMap, v),
    ),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$CouponValidateRequestToJson(
  CouponValidateRequest instance,
) => <String, dynamic>{
  'code': instance.code,
  'orderAmount': instance.orderAmount,
  'serviceType': ?_$OrderTypeEnumMap[instance.serviceType],
  'merchantId': ?instance.merchantId,
};

const _$OrderTypeEnumMap = {
  OrderType.RIDE: 'RIDE',
  OrderType.DELIVERY: 'DELIVERY',
  OrderType.FOOD: 'FOOD',
};
