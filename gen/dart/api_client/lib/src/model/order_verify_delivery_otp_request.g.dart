// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_verify_delivery_otp_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderVerifyDeliveryOTPRequestCWProxy {
  OrderVerifyDeliveryOTPRequest otp(String otp);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderVerifyDeliveryOTPRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderVerifyDeliveryOTPRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderVerifyDeliveryOTPRequest call({String otp});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderVerifyDeliveryOTPRequest.copyWith(...)` or call `instanceOfOrderVerifyDeliveryOTPRequest.copyWith.fieldName(value)` for a single field.
class _$OrderVerifyDeliveryOTPRequestCWProxyImpl
    implements _$OrderVerifyDeliveryOTPRequestCWProxy {
  const _$OrderVerifyDeliveryOTPRequestCWProxyImpl(this._value);

  final OrderVerifyDeliveryOTPRequest _value;

  @override
  OrderVerifyDeliveryOTPRequest otp(String otp) => call(otp: otp);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderVerifyDeliveryOTPRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderVerifyDeliveryOTPRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderVerifyDeliveryOTPRequest call({
    Object? otp = const $CopyWithPlaceholder(),
  }) {
    return OrderVerifyDeliveryOTPRequest(
      otp: otp == const $CopyWithPlaceholder() || otp == null
          ? _value.otp
          // ignore: cast_nullable_to_non_nullable
          : otp as String,
    );
  }
}

extension $OrderVerifyDeliveryOTPRequestCopyWith
    on OrderVerifyDeliveryOTPRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderVerifyDeliveryOTPRequest.copyWith(...)` or `instanceOfOrderVerifyDeliveryOTPRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderVerifyDeliveryOTPRequestCWProxy get copyWith =>
      _$OrderVerifyDeliveryOTPRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderVerifyDeliveryOTPRequest _$OrderVerifyDeliveryOTPRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderVerifyDeliveryOTPRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['otp']);
  final val = OrderVerifyDeliveryOTPRequest(
    otp: $checkedConvert('otp', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$OrderVerifyDeliveryOTPRequestToJson(
  OrderVerifyDeliveryOTPRequest instance,
) => <String, dynamic>{'otp': instance.otp};
