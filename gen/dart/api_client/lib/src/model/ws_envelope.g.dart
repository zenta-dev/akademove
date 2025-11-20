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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  WSEnvelope call({
    WSEnvelopeType type,
    WSEnvelopeSender from,
    WSEnvelopeSender to,
    Object? payload,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWSEnvelope.copyWith(...)` or call `instanceOfWSEnvelope.copyWith.fieldName(value)` for a single field.
class _$WSEnvelopeCWProxyImpl implements _$WSEnvelopeCWProxy {
  const _$WSEnvelopeCWProxyImpl(this._value);

  final WSEnvelope _value;

  @override
  WSEnvelope type(WSEnvelopeType type) => call(type: type);

  @override
  WSEnvelope from(WSEnvelopeSender from) => call(from: from);

  @override
  WSEnvelope to(WSEnvelopeSender to) => call(to: to);

  @override
  WSEnvelope payload(Object? payload) => call(payload: payload);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  WSEnvelope call({
    Object? type = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
    Object? to = const $CopyWithPlaceholder(),
    Object? payload = const $CopyWithPlaceholder(),
  }) {
    return WSEnvelope(
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
      payload: payload == const $CopyWithPlaceholder()
          ? _value.payload
          // ignore: cast_nullable_to_non_nullable
          : payload as Object?,
    );
  }
}

extension $WSEnvelopeCopyWith on WSEnvelope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWSEnvelope.copyWith(...)` or `instanceOfWSEnvelope.copyWith.fieldName(...)`.
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
