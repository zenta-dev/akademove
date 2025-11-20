// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_place_order_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSPlaceOrderEnvelopeCWProxy {
  WSPlaceOrderEnvelope type(WSEnvelopeType type);

  WSPlaceOrderEnvelope from(WSEnvelopeSender from);

  WSPlaceOrderEnvelope to(WSEnvelopeSender to);

  WSPlaceOrderEnvelope payload(PlaceOrderResponse payload);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSPlaceOrderEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSPlaceOrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  WSPlaceOrderEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    PlaceOrderResponse payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWSPlaceOrderEnvelope.copyWith(...)` or call `instanceOfWSPlaceOrderEnvelope.copyWith.fieldName(value)` for a single field.
class _$WSPlaceOrderEnvelopeCWProxyImpl
    implements _$WSPlaceOrderEnvelopeCWProxy {
  const _$WSPlaceOrderEnvelopeCWProxyImpl(this._value);

  final WSPlaceOrderEnvelope _value;

  @override
  WSPlaceOrderEnvelope type(WSEnvelopeType type) => call(type: type);

  @override
  WSPlaceOrderEnvelope from(WSEnvelopeSender from) => call(from: from);

  @override
  WSPlaceOrderEnvelope to(WSEnvelopeSender to) => call(to: to);

  @override
  WSPlaceOrderEnvelope payload(PlaceOrderResponse payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSPlaceOrderEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSPlaceOrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  WSPlaceOrderEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSPlaceOrderEnvelope(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as WSEnvelopeType,
      from: from == const $CopyWithPlaceholder() || from == null
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as WSEnvelopeSender,
      to: to == const $CopyWithPlaceholder() || to == null
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as WSEnvelopeSender,
      payload: payload == const $CopyWithPlaceholder() || payload == null
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as PlaceOrderResponse,
    );
  }
}

extension $WSPlaceOrderEnvelopeCopyWith on WSPlaceOrderEnvelope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWSPlaceOrderEnvelope.copyWith(...)` or `instanceOfWSPlaceOrderEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WSPlaceOrderEnvelopeCWProxy get copyWith =>
      _$WSPlaceOrderEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSPlaceOrderEnvelope _$WSPlaceOrderEnvelopeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WSPlaceOrderEnvelope', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['type', 'from', 'to', 'payload']);
  final val = WSPlaceOrderEnvelope(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$WSEnvelopeTypeEnumMap, v),
    ),
    from: $checkedConvert(
      'from',
      (v) => $enumDecode(_$WSEnvelopeSenderEnumMap, v),
    ),
    to: $checkedConvert('to', (v) => $enumDecode(_$WSEnvelopeSenderEnumMap, v)),
    payload: $checkedConvert(
      'payload',
      (v) => PlaceOrderResponse.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WSPlaceOrderEnvelopeToJson(
  WSPlaceOrderEnvelope instance,
) => <String, dynamic>{
  'type': _$WSEnvelopeTypeEnumMap[instance.type]!,
  'from': _$WSEnvelopeSenderEnumMap[instance.from]!,
  'to': _$WSEnvelopeSenderEnumMap[instance.to]!,
  'payload': instance.payload.toJson(),
};

const _$WSEnvelopeTypeEnumMap = {
  WSEnvelopeType.orderColonRequest: 'order:request',
  WSEnvelopeType.orderColonMatching: 'order:matching',
  WSEnvelopeType.orderColonCancelled: 'order:cancelled',
  WSEnvelopeType.orderColonAccepted: 'order:accepted',
  WSEnvelopeType.orderColonUnavailable: 'order:unavailable',
  WSEnvelopeType.orderColonDone: 'order:done',
  WSEnvelopeType.driverColonLocationUpdate: 'driver:location_update',
  WSEnvelopeType.walletColonTopUpSuccess: 'wallet:top_up_success',
  WSEnvelopeType.walletColonTopUpFailed: 'wallet:top_up_failed',
  WSEnvelopeType.paymentColonSuccess: 'payment:success',
  WSEnvelopeType.paymentColonFailed: 'payment:failed',
};

const _$WSEnvelopeSenderEnumMap = {
  WSEnvelopeSender.server: 'server',
  WSEnvelopeSender.client: 'client',
};
