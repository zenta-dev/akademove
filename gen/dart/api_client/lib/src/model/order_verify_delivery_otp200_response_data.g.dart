// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_verify_delivery_otp200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderVerifyDeliveryOTP200ResponseDataCWProxy {
  OrderVerifyDeliveryOTP200ResponseData verified(bool verified);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderVerifyDeliveryOTP200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderVerifyDeliveryOTP200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderVerifyDeliveryOTP200ResponseData call({bool verified});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderVerifyDeliveryOTP200ResponseData.copyWith(...)` or call `instanceOfOrderVerifyDeliveryOTP200ResponseData.copyWith.fieldName(value)` for a single field.
class _$OrderVerifyDeliveryOTP200ResponseDataCWProxyImpl
    implements _$OrderVerifyDeliveryOTP200ResponseDataCWProxy {
  const _$OrderVerifyDeliveryOTP200ResponseDataCWProxyImpl(this._value);

  final OrderVerifyDeliveryOTP200ResponseData _value;

  @override
  OrderVerifyDeliveryOTP200ResponseData verified(bool verified) =>
      call(verified: verified);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderVerifyDeliveryOTP200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderVerifyDeliveryOTP200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderVerifyDeliveryOTP200ResponseData call({
    Object? verified = const $CopyWithPlaceholder(),
  }) {
    return OrderVerifyDeliveryOTP200ResponseData(
      verified: verified == const $CopyWithPlaceholder() || verified == null
          ? _value.verified
          // ignore: cast_nullable_to_non_nullable
          : verified as bool,
    );
  }
}

extension $OrderVerifyDeliveryOTP200ResponseDataCopyWith
    on OrderVerifyDeliveryOTP200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderVerifyDeliveryOTP200ResponseData.copyWith(...)` or `instanceOfOrderVerifyDeliveryOTP200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderVerifyDeliveryOTP200ResponseDataCWProxy get copyWith =>
      _$OrderVerifyDeliveryOTP200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderVerifyDeliveryOTP200ResponseData
_$OrderVerifyDeliveryOTP200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderVerifyDeliveryOTP200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['verified']);
      final val = OrderVerifyDeliveryOTP200ResponseData(
        verified: $checkedConvert('verified', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$OrderVerifyDeliveryOTP200ResponseDataToJson(
  OrderVerifyDeliveryOTP200ResponseData instance,
) => <String, dynamic>{'verified': instance.verified};
