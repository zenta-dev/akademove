// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSEnvelopeCWProxy {
  WSEnvelope type(WSEnvelopeType type);

  WSEnvelope from(WSEnvelopeSender from);

  WSEnvelope to(WSEnvelopeSender to);

  WSEnvelope payload(Object? payload);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    Object? payload,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWSEnvelope.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWSEnvelope.copyWith.fieldName(...)`
class _$WSEnvelopeCWProxyImpl implements _$WSEnvelopeCWProxy {
  const _$WSEnvelopeCWProxyImpl(this._value);

  final WSEnvelope _value;

  @override
  WSEnvelope type(WSEnvelopeType type) => this(type: type);

  @override
  WSEnvelope from(WSEnvelopeSender from) => this(from: from);

  @override
  WSEnvelope to(WSEnvelopeSender to) => this(to: to);

  @override
  WSEnvelope payload(Object? payload) => this(payload: payload);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSEnvelope(
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
          : payload as Object?,
    );
  }
}

extension $WSEnvelopeCopyWith on WSEnvelope {
  /// Returns a callable class that can be used as follows: `instanceOfWSEnvelope.copyWith(...)` or like so:`instanceOfWSEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WSEnvelopeCWProxy get copyWith => _$WSEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSEnvelope _$WSEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WSEnvelope', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'from', 'to']);
      final val = WSEnvelope(
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
        payload: $checkedConvert('payload', (v) => v),
      );
      return val;
    });

Map<String, dynamic> _$WSEnvelopeToJson(WSEnvelope instance) =>
    <String, dynamic>{
      'type': _$WSEnvelopeTypeEnumMap[instance.type]!,
      'from': _$WSEnvelopeSenderEnumMap[instance.from]!,
      'to': _$WSEnvelopeSenderEnumMap[instance.to]!,
      'payload': ?instance.payload,
    };

const _$WSEnvelopeTypeEnumMap = {
  WSEnvelopeType.orderColonRequest: 'order:request',
  WSEnvelopeType.orderColonMatching: 'order:matching',
  WSEnvelopeType.orderColonCancelled: 'order:cancelled',
  WSEnvelopeType.orderColonAccepted: 'order:accepted',
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
