// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_timeout_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderTimeoutJobPayloadCWProxy {
  OrderTimeoutJobPayload orderId(String orderId);

  OrderTimeoutJobPayload userId(String userId);

  OrderTimeoutJobPayload paymentId(String? paymentId);

  OrderTimeoutJobPayload totalPrice(num totalPrice);

  OrderTimeoutJobPayload timeoutReason(String? timeoutReason);

  OrderTimeoutJobPayload processRefund(bool? processRefund);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderTimeoutJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderTimeoutJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderTimeoutJobPayload call({
    String orderId,
    String userId,
    String? paymentId,
    num totalPrice,
    String? timeoutReason,
    bool? processRefund,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderTimeoutJobPayload.copyWith(...)` or call `instanceOfOrderTimeoutJobPayload.copyWith.fieldName(value)` for a single field.
class _$OrderTimeoutJobPayloadCWProxyImpl
    implements _$OrderTimeoutJobPayloadCWProxy {
  const _$OrderTimeoutJobPayloadCWProxyImpl(this._value);

  final OrderTimeoutJobPayload _value;

  @override
  OrderTimeoutJobPayload orderId(String orderId) => call(orderId: orderId);

  @override
  OrderTimeoutJobPayload userId(String userId) => call(userId: userId);

  @override
  OrderTimeoutJobPayload paymentId(String? paymentId) =>
      call(paymentId: paymentId);

  @override
  OrderTimeoutJobPayload totalPrice(num totalPrice) =>
      call(totalPrice: totalPrice);

  @override
  OrderTimeoutJobPayload timeoutReason(String? timeoutReason) =>
      call(timeoutReason: timeoutReason);

  @override
  OrderTimeoutJobPayload processRefund(bool? processRefund) =>
      call(processRefund: processRefund);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderTimeoutJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderTimeoutJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderTimeoutJobPayload call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? paymentId = const $CopyWithPlaceholder(),
    Object? totalPrice = const $CopyWithPlaceholder(),
    Object? timeoutReason = const $CopyWithPlaceholder(),
    Object? processRefund = const $CopyWithPlaceholder(),
  }) {
    return OrderTimeoutJobPayload(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      paymentId: paymentId == const $CopyWithPlaceholder()
          ? _value.paymentId
          // ignore: cast_nullable_to_non_nullable
          : paymentId as String?,
      totalPrice:
          totalPrice == const $CopyWithPlaceholder() || totalPrice == null
          ? _value.totalPrice
          // ignore: cast_nullable_to_non_nullable
          : totalPrice as num,
      timeoutReason: timeoutReason == const $CopyWithPlaceholder()
          ? _value.timeoutReason
          // ignore: cast_nullable_to_non_nullable
          : timeoutReason as String?,
      processRefund: processRefund == const $CopyWithPlaceholder()
          ? _value.processRefund
          // ignore: cast_nullable_to_non_nullable
          : processRefund as bool?,
    );
  }
}

extension $OrderTimeoutJobPayloadCopyWith on OrderTimeoutJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderTimeoutJobPayload.copyWith(...)` or `instanceOfOrderTimeoutJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderTimeoutJobPayloadCWProxy get copyWith =>
      _$OrderTimeoutJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTimeoutJobPayload _$OrderTimeoutJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderTimeoutJobPayload', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['orderId', 'userId', 'totalPrice']);
  final val = OrderTimeoutJobPayload(
    orderId: $checkedConvert('orderId', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    paymentId: $checkedConvert('paymentId', (v) => v as String?),
    totalPrice: $checkedConvert('totalPrice', (v) => v as num),
    timeoutReason: $checkedConvert(
      'timeoutReason',
      (v) => v as String? ?? 'No driver available within timeout period',
    ),
    processRefund: $checkedConvert('processRefund', (v) => v as bool? ?? true),
  );
  return val;
});

Map<String, dynamic> _$OrderTimeoutJobPayloadToJson(
  OrderTimeoutJobPayload instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'userId': instance.userId,
  'paymentId': ?instance.paymentId,
  'totalPrice': instance.totalPrice,
  'timeoutReason': ?instance.timeoutReason,
  'processRefund': ?instance.processRefund,
};
