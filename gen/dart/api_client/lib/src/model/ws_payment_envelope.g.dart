// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_payment_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSPaymentEnvelopeCWProxy {
  WSPaymentEnvelope type(WSEnvelopeType type);

  WSPaymentEnvelope from(WSEnvelopeSender from);

  WSPaymentEnvelope to(WSEnvelopeSender to);

  WSPaymentEnvelope payload(WSPaymentEnvelopePayload payload);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSPaymentEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSPaymentEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSPaymentEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    WSPaymentEnvelopePayload payload,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWSPaymentEnvelope.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWSPaymentEnvelope.copyWith.fieldName(...)`
class _$WSPaymentEnvelopeCWProxyImpl implements _$WSPaymentEnvelopeCWProxy {
  const _$WSPaymentEnvelopeCWProxyImpl(this._value);

  final WSPaymentEnvelope _value;

  @override
  WSPaymentEnvelope type(WSEnvelopeType type) => this(type: type);

  @override
  WSPaymentEnvelope from(WSEnvelopeSender from) => this(from: from);

  @override
  WSPaymentEnvelope to(WSEnvelopeSender to) => this(to: to);

  @override
  WSPaymentEnvelope payload(WSPaymentEnvelopePayload payload) =>
      this(payload: payload);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSPaymentEnvelope(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSPaymentEnvelope(...).copyWith(id: 12, name: "My name")
  /// ````
  WSPaymentEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSPaymentEnvelope(
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
          : payload as WSPaymentEnvelopePayload,
    );
  }
}

extension $WSPaymentEnvelopeCopyWith on WSPaymentEnvelope {
  /// Returns a callable class that can be used as follows: `instanceOfWSPaymentEnvelope.copyWith(...)` or like so:`instanceOfWSPaymentEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WSPaymentEnvelopeCWProxy get copyWith =>
      _$WSPaymentEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSPaymentEnvelope _$WSPaymentEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WSPaymentEnvelope', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['type', 'from', 'to', 'payload']);
      final val = WSPaymentEnvelope(
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
          (v) => WSPaymentEnvelopePayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WSPaymentEnvelopeToJson(WSPaymentEnvelope instance) =>
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
  WSEnvelopeType.walletColonTopUpSuccess: 'wallet:top_up_success',
  WSEnvelopeType.walletColonTopUpFailed: 'wallet:top_up_failed',
  WSEnvelopeType.paymentColonSuccess: 'payment:success',
  WSEnvelopeType.paymentColonFailed: 'payment:failed',
};

const _$WSEnvelopeSenderEnumMap = {
  WSEnvelopeSender.server: 'server',
  WSEnvelopeSender.client: 'client',
};
