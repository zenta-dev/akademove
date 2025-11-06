// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_top_up_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSTopUpEnvelopeCWProxy {
  WSTopUpEnvelope type(WSEnvelopeType type);

  WSTopUpEnvelope from(WSEnvelopeSender from);

  WSTopUpEnvelope to(WSEnvelopeSender to);

  WSTopUpEnvelope payload(WSTopUpEnvelopePayload payload);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSTopUpEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSTopUpEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSTopUpEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    WSTopUpEnvelopePayload payload,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWSTopUpEnvelope.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWSTopUpEnvelope.copyWith.fieldName(...)`
class _$WSTopUpEnvelopeCWProxyImpl implements _$WSTopUpEnvelopeCWProxy {
  const _$WSTopUpEnvelopeCWProxyImpl(this._value);

  final WSTopUpEnvelope _value;

  @override
  WSTopUpEnvelope type(WSEnvelopeType type) => this(type: type);

  @override
  WSTopUpEnvelope from(WSEnvelopeSender from) => this(from: from);

  @override
  WSTopUpEnvelope to(WSEnvelopeSender to) => this(to: to);

  @override
  WSTopUpEnvelope payload(WSTopUpEnvelopePayload payload) =>
      this(payload: payload);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSTopUpEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSTopUpEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSTopUpEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSTopUpEnvelope(
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
          : payload as WSTopUpEnvelopePayload,
    );
  }
}

extension $WSTopUpEnvelopeCopyWith on WSTopUpEnvelope {
  /// Returns a callable class that can be used as follows: `instanceOfWSTopUpEnvelope.copyWith(...)` or like so:`instanceOfWSTopUpEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WSTopUpEnvelopeCWProxy get copyWith => _$WSTopUpEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSTopUpEnvelope _$WSTopUpEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WSTopUpEnvelope', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'from', 'to', 'payload']);
      final val = WSTopUpEnvelope(
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
          (v) => WSTopUpEnvelopePayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WSTopUpEnvelopeToJson(WSTopUpEnvelope instance) =>
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
  WSEnvelopeType.driverColonLocationUpdate: 'driver:location_update',
  WSEnvelopeType.driverColonAssigned: 'driver:assigned',
  WSEnvelopeType.walletColonTopUpSuccess: 'wallet:top_up_success',
};

const _$WSEnvelopeSenderEnumMap = {
  WSEnvelopeSender.server: 'server',
  WSEnvelopeSender.client: 'client',
};
