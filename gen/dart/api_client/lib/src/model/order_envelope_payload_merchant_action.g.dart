// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_merchant_action.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadMerchantActionCWProxy {
  OrderEnvelopePayloadMerchantAction orderId(String orderId);

  OrderEnvelopePayloadMerchantAction merchantId(String merchantId);

  OrderEnvelopePayloadMerchantAction reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadMerchantAction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadMerchantAction(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadMerchantAction call({
    String orderId,
    String merchantId,
    String? reason,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadMerchantAction.copyWith(...)` or call `instanceOfOrderEnvelopePayloadMerchantAction.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadMerchantActionCWProxyImpl
    implements _$OrderEnvelopePayloadMerchantActionCWProxy {
  const _$OrderEnvelopePayloadMerchantActionCWProxyImpl(this._value);

  final OrderEnvelopePayloadMerchantAction _value;

  @override
  OrderEnvelopePayloadMerchantAction orderId(String orderId) =>
      call(orderId: orderId);

  @override
  OrderEnvelopePayloadMerchantAction merchantId(String merchantId) =>
      call(merchantId: merchantId);

  @override
  OrderEnvelopePayloadMerchantAction reason(String? reason) =>
      call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadMerchantAction(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadMerchantAction(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadMerchantAction call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadMerchantAction(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      merchantId:
          merchantId == const $CopyWithPlaceholder() || merchantId == null
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $OrderEnvelopePayloadMerchantActionCopyWith
    on OrderEnvelopePayloadMerchantAction {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadMerchantAction.copyWith(...)` or `instanceOfOrderEnvelopePayloadMerchantAction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadMerchantActionCWProxy get copyWith =>
      _$OrderEnvelopePayloadMerchantActionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadMerchantAction _$OrderEnvelopePayloadMerchantActionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayloadMerchantAction', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['orderId', 'merchantId']);
  final val = OrderEnvelopePayloadMerchantAction(
    orderId: $checkedConvert('orderId', (v) => v as String),
    merchantId: $checkedConvert('merchantId', (v) => v as String),
    reason: $checkedConvert('reason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadMerchantActionToJson(
  OrderEnvelopePayloadMerchantAction instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'merchantId': instance.merchantId,
  'reason': ?instance.reason,
};
