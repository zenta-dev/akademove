// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_order_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSOrderEnvelopeCWProxy {
  WSOrderEnvelope type(WSEnvelopeType type);

  WSOrderEnvelope from(WSEnvelopeSender from);

  WSOrderEnvelope to(WSEnvelopeSender to);

  WSOrderEnvelope payload(WSOrderEnvelopePayload payload);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSOrderEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSOrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSOrderEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    WSOrderEnvelopePayload payload,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWSOrderEnvelope.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWSOrderEnvelope.copyWith.fieldName(...)`
class _$WSOrderEnvelopeCWProxyImpl implements _$WSOrderEnvelopeCWProxy {
  const _$WSOrderEnvelopeCWProxyImpl(this._value);

  final WSOrderEnvelope _value;

  @override
  WSOrderEnvelope type(WSEnvelopeType type) => this(type: type);

  @override
  WSOrderEnvelope from(WSEnvelopeSender from) => this(from: from);

  @override
  WSOrderEnvelope to(WSEnvelopeSender to) => this(to: to);

  @override
  WSOrderEnvelope payload(WSOrderEnvelopePayload payload) =>
      this(payload: payload);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSOrderEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSOrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSOrderEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSOrderEnvelope(
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
          : payload as WSOrderEnvelopePayload,
    );
  }
}

extension $WSOrderEnvelopeCopyWith on WSOrderEnvelope {
  /// Returns a callable class that can be used as follows: `instanceOfWSOrderEnvelope.copyWith(...)` or like so:`instanceOfWSOrderEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WSOrderEnvelopeCWProxy get copyWith => _$WSOrderEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSOrderEnvelope _$WSOrderEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WSOrderEnvelope', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'from', 'to', 'payload']);
      final val = WSOrderEnvelope(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$WSEnvelopeTypeEnumMap, v),
        ),
        from: $checkedConvert(
          'from',
          (v) => $enumDecode(_$WSEnvelopeSenderEnumMap, v),
        ),
        to: $checkedConvert(
          'to',
          (v) => $enumDecode(_$WSEnvelopeSenderEnumMap, v),
        ),
        payload: $checkedConvert(
          'payload',
          (v) => WSOrderEnvelopePayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WSOrderEnvelopeToJson(WSOrderEnvelope instance) =>
    <String, dynamic>{
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
