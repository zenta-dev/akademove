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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSOrderEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSOrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  WSOrderEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    WSOrderEnvelopePayload payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWSOrderEnvelope.copyWith(...)` or call `instanceOfWSOrderEnvelope.copyWith.fieldName(value)` for a single field.
class _$WSOrderEnvelopeCWProxyImpl implements _$WSOrderEnvelopeCWProxy {
  const _$WSOrderEnvelopeCWProxyImpl(this._value);

  final WSOrderEnvelope _value;

  @override
  WSOrderEnvelope type(WSEnvelopeType type) => call(type: type);

  @override
  WSOrderEnvelope from(WSEnvelopeSender from) => call(from: from);

  @override
  WSOrderEnvelope to(WSEnvelopeSender to) => call(to: to);

  @override
  WSOrderEnvelope payload(WSOrderEnvelopePayload payload) =>
      call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSOrderEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSOrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  WSOrderEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSOrderEnvelope(
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
          : payload as WSOrderEnvelopePayload,
    );
  }
}

extension $WSOrderEnvelopeCopyWith on WSOrderEnvelope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWSOrderEnvelope.copyWith(...)` or `instanceOfWSOrderEnvelope.copyWith.fieldName(...)`.
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
