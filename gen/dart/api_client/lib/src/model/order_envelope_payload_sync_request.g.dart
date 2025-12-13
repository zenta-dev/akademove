// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_sync_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadSyncRequestCWProxy {
  OrderEnvelopePayloadSyncRequest orderId(String orderId);

  OrderEnvelopePayloadSyncRequest lastKnownVersion(String? lastKnownVersion);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadSyncRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadSyncRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadSyncRequest call({
    String orderId,
    String? lastKnownVersion,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadSyncRequest.copyWith(...)` or call `instanceOfOrderEnvelopePayloadSyncRequest.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadSyncRequestCWProxyImpl
    implements _$OrderEnvelopePayloadSyncRequestCWProxy {
  const _$OrderEnvelopePayloadSyncRequestCWProxyImpl(this._value);

  final OrderEnvelopePayloadSyncRequest _value;

  @override
  OrderEnvelopePayloadSyncRequest orderId(String orderId) =>
      call(orderId: orderId);

  @override
  OrderEnvelopePayloadSyncRequest lastKnownVersion(String? lastKnownVersion) =>
      call(lastKnownVersion: lastKnownVersion);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadSyncRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadSyncRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadSyncRequest call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? lastKnownVersion = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadSyncRequest(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      lastKnownVersion: lastKnownVersion == const $CopyWithPlaceholder()
          ? _value.lastKnownVersion
          // ignore: cast_nullable_to_non_nullable
          : lastKnownVersion as String?,
    );
  }
}

extension $OrderEnvelopePayloadSyncRequestCopyWith
    on OrderEnvelopePayloadSyncRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadSyncRequest.copyWith(...)` or `instanceOfOrderEnvelopePayloadSyncRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadSyncRequestCWProxy get copyWith =>
      _$OrderEnvelopePayloadSyncRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadSyncRequest _$OrderEnvelopePayloadSyncRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayloadSyncRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['orderId']);
  final val = OrderEnvelopePayloadSyncRequest(
    orderId: $checkedConvert('orderId', (v) => v as String),
    lastKnownVersion: $checkedConvert('lastKnownVersion', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadSyncRequestToJson(
  OrderEnvelopePayloadSyncRequest instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'lastKnownVersion': ?instance.lastKnownVersion,
};
