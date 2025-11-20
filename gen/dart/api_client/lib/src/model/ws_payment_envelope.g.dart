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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSPaymentEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSPaymentEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  WSPaymentEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    WSPaymentEnvelopePayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWSPaymentEnvelope.copyWith(...)` or call `instanceOfWSPaymentEnvelope.copyWith.fieldName(value)` for a single field.
class _$WSPaymentEnvelopeCWProxyImpl implements _$WSPaymentEnvelopeCWProxy {
  const _$WSPaymentEnvelopeCWProxyImpl(this._value);

  final WSPaymentEnvelope _value;

  @override
  WSPaymentEnvelope type(WSEnvelopeType type) => call(type: type);

  @override
  WSPaymentEnvelope from(WSEnvelopeSender from) => call(from: from);

  @override
  WSPaymentEnvelope to(WSEnvelopeSender to) => call(to: to);

  @override
  WSPaymentEnvelope payload(WSPaymentEnvelopePayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSPaymentEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSPaymentEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  WSPaymentEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSPaymentEnvelope(
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
          : payload as WSPaymentEnvelopePayload,
    );
  }
}

extension $WSPaymentEnvelopeCopyWith on WSPaymentEnvelope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWSPaymentEnvelope.copyWith(...)` or `instanceOfWSPaymentEnvelope.copyWith.fieldName(...)`.
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
