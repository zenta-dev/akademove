// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_envelope_payload_sync_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentEnvelopePayloadSyncRequestCWProxy {
  PaymentEnvelopePayloadSyncRequest paymentId(String paymentId);

  PaymentEnvelopePayloadSyncRequest lastKnownVersion(String? lastKnownVersion);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayloadSyncRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayloadSyncRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayloadSyncRequest call({
    String paymentId,
    String? lastKnownVersion,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentEnvelopePayloadSyncRequest.copyWith(...)` or call `instanceOfPaymentEnvelopePayloadSyncRequest.copyWith.fieldName(value)` for a single field.
class _$PaymentEnvelopePayloadSyncRequestCWProxyImpl
    implements _$PaymentEnvelopePayloadSyncRequestCWProxy {
  const _$PaymentEnvelopePayloadSyncRequestCWProxyImpl(this._value);

  final PaymentEnvelopePayloadSyncRequest _value;

  @override
  PaymentEnvelopePayloadSyncRequest paymentId(String paymentId) =>
      call(paymentId: paymentId);

  @override
  PaymentEnvelopePayloadSyncRequest lastKnownVersion(
    String? lastKnownVersion,
  ) => call(lastKnownVersion: lastKnownVersion);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayloadSyncRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayloadSyncRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayloadSyncRequest call({
    Object? paymentId = const $CopyWithPlaceholder(),
    Object? lastKnownVersion = const $CopyWithPlaceholder(),
  }) {
    return PaymentEnvelopePayloadSyncRequest(
      paymentId: paymentId == const $CopyWithPlaceholder() || paymentId == null
          ? _value.paymentId
          // ignore: cast_nullable_to_non_nullable
          : paymentId as String,
      lastKnownVersion: lastKnownVersion == const $CopyWithPlaceholder()
          ? _value.lastKnownVersion
          // ignore: cast_nullable_to_non_nullable
          : lastKnownVersion as String?,
    );
  }
}

extension $PaymentEnvelopePayloadSyncRequestCopyWith
    on PaymentEnvelopePayloadSyncRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentEnvelopePayloadSyncRequest.copyWith(...)` or `instanceOfPaymentEnvelopePayloadSyncRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentEnvelopePayloadSyncRequestCWProxy get copyWith =>
      _$PaymentEnvelopePayloadSyncRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentEnvelopePayloadSyncRequest _$PaymentEnvelopePayloadSyncRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PaymentEnvelopePayloadSyncRequest', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['paymentId']);
  final val = PaymentEnvelopePayloadSyncRequest(
    paymentId: $checkedConvert('paymentId', (v) => v as String),
    lastKnownVersion: $checkedConvert('lastKnownVersion', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PaymentEnvelopePayloadSyncRequestToJson(
  PaymentEnvelopePayloadSyncRequest instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'lastKnownVersion': ?instance.lastKnownVersion,
};
