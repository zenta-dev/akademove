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

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSPlaceOrderEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSPlaceOrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSPlaceOrderEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    PlaceOrderResponse payload,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWSPlaceOrderEnvelope.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWSPlaceOrderEnvelope.copyWith.fieldName(...)`
class _$WSPlaceOrderEnvelopeCWProxyImpl
    implements _$WSPlaceOrderEnvelopeCWProxy {
  const _$WSPlaceOrderEnvelopeCWProxyImpl(this._value);

  final WSPlaceOrderEnvelope _value;

  @override
  WSPlaceOrderEnvelope type(WSEnvelopeType type) => this(type: type);

  @override
  WSPlaceOrderEnvelope from(WSEnvelopeSender from) => this(from: from);

  @override
  WSPlaceOrderEnvelope to(WSEnvelopeSender to) => this(to: to);

  @override
  WSPlaceOrderEnvelope payload(PlaceOrderResponse payload) =>
      this(payload: payload);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSPlaceOrderEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSPlaceOrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSPlaceOrderEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSPlaceOrderEnvelope(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as WSEnvelopeType,
      from: from == const $CopyWithPlaceholder()
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as WSEnvelopeSender,
      to: to == const $CopyWithPlaceholder()
          ? _value.to
          // ignore: cast_nullable_to_non_nullable
          : to as WSEnvelopeSender,
      payload: payload == const $CopyWithPlaceholder()
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as PlaceOrderResponse,
    );
  }
}

extension $WSPlaceOrderEnvelopeCopyWith on WSPlaceOrderEnvelope {
  /// Returns a callable class that can be used as follows: `instanceOfWSPlaceOrderEnvelope.copyWith(...)` or like so:`instanceOfWSPlaceOrderEnvelope.copyWith.fieldName(...)`.
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
