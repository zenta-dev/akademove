// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_response_auto_applied_coupon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceOrderResponseAutoAppliedCouponCWProxy {
  PlaceOrderResponseAutoAppliedCoupon code(String code);

  PlaceOrderResponseAutoAppliedCoupon discountAmount(num discountAmount);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceOrderResponseAutoAppliedCoupon(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceOrderResponseAutoAppliedCoupon(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceOrderResponseAutoAppliedCoupon call({String code, num discountAmount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPlaceOrderResponseAutoAppliedCoupon.copyWith(...)` or call `instanceOfPlaceOrderResponseAutoAppliedCoupon.copyWith.fieldName(value)` for a single field.
class _$PlaceOrderResponseAutoAppliedCouponCWProxyImpl
    implements _$PlaceOrderResponseAutoAppliedCouponCWProxy {
  const _$PlaceOrderResponseAutoAppliedCouponCWProxyImpl(this._value);

  final PlaceOrderResponseAutoAppliedCoupon _value;

  @override
  PlaceOrderResponseAutoAppliedCoupon code(String code) => call(code: code);

  @override
  PlaceOrderResponseAutoAppliedCoupon discountAmount(num discountAmount) =>
      call(discountAmount: discountAmount);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceOrderResponseAutoAppliedCoupon(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceOrderResponseAutoAppliedCoupon(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceOrderResponseAutoAppliedCoupon call({
    Object? code = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
  }) {
    return PlaceOrderResponseAutoAppliedCoupon(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      discountAmount:
          discountAmount == const $CopyWithPlaceholder() ||
              discountAmount == null
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as num,
    );
  }
}

extension $PlaceOrderResponseAutoAppliedCouponCopyWith
    on PlaceOrderResponseAutoAppliedCoupon {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPlaceOrderResponseAutoAppliedCoupon.copyWith(...)` or `instanceOfPlaceOrderResponseAutoAppliedCoupon.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlaceOrderResponseAutoAppliedCouponCWProxy get copyWith =>
      _$PlaceOrderResponseAutoAppliedCouponCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderResponseAutoAppliedCoupon
_$PlaceOrderResponseAutoAppliedCouponFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PlaceOrderResponseAutoAppliedCoupon', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['code', 'discountAmount']);
      final val = PlaceOrderResponseAutoAppliedCoupon(
        code: $checkedConvert('code', (v) => v as String),
        discountAmount: $checkedConvert('discountAmount', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$PlaceOrderResponseAutoAppliedCouponToJson(
  PlaceOrderResponseAutoAppliedCoupon instance,
) => <String, dynamic>{
  'code': instance.code,
  'discountAmount': instance.discountAmount,
};
