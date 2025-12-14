// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_envelope_payload_sync_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantEnvelopePayloadSyncRequestCWProxy {
  MerchantEnvelopePayloadSyncRequest merchantId(String merchantId);

  MerchantEnvelopePayloadSyncRequest lastKnownVersion(String? lastKnownVersion);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantEnvelopePayloadSyncRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantEnvelopePayloadSyncRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantEnvelopePayloadSyncRequest call({
    String merchantId,
    String? lastKnownVersion,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantEnvelopePayloadSyncRequest.copyWith(...)` or call `instanceOfMerchantEnvelopePayloadSyncRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantEnvelopePayloadSyncRequestCWProxyImpl
    implements _$MerchantEnvelopePayloadSyncRequestCWProxy {
  const _$MerchantEnvelopePayloadSyncRequestCWProxyImpl(this._value);

  final MerchantEnvelopePayloadSyncRequest _value;

  @override
  MerchantEnvelopePayloadSyncRequest merchantId(String merchantId) =>
      call(merchantId: merchantId);

  @override
  MerchantEnvelopePayloadSyncRequest lastKnownVersion(
    String? lastKnownVersion,
  ) => call(lastKnownVersion: lastKnownVersion);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantEnvelopePayloadSyncRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantEnvelopePayloadSyncRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantEnvelopePayloadSyncRequest call({
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? lastKnownVersion = const $CopyWithPlaceholder(),
  }) {
    return MerchantEnvelopePayloadSyncRequest(
      merchantId:
          merchantId == const $CopyWithPlaceholder() || merchantId == null
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String,
      lastKnownVersion: lastKnownVersion == const $CopyWithPlaceholder()
          ? _value.lastKnownVersion
          // ignore: cast_nullable_to_non_nullable
          : lastKnownVersion as String?,
    );
  }
}

extension $MerchantEnvelopePayloadSyncRequestCopyWith
    on MerchantEnvelopePayloadSyncRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantEnvelopePayloadSyncRequest.copyWith(...)` or `instanceOfMerchantEnvelopePayloadSyncRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantEnvelopePayloadSyncRequestCWProxy get copyWith =>
      _$MerchantEnvelopePayloadSyncRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantEnvelopePayloadSyncRequest _$MerchantEnvelopePayloadSyncRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantEnvelopePayloadSyncRequest', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['merchantId']);
  final val = MerchantEnvelopePayloadSyncRequest(
    merchantId: $checkedConvert('merchantId', (v) => v as String),
    lastKnownVersion: $checkedConvert('lastKnownVersion', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$MerchantEnvelopePayloadSyncRequestToJson(
  MerchantEnvelopePayloadSyncRequest instance,
) => <String, dynamic>{
  'merchantId': instance.merchantId,
  'lastKnownVersion': ?instance.lastKnownVersion,
};
