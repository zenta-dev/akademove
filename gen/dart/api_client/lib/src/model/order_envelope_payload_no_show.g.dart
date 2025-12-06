// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_no_show.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadNoShowCWProxy {
  OrderEnvelopePayloadNoShow orderId(String orderId);

  OrderEnvelopePayloadNoShow driverId(String driverId);

  OrderEnvelopePayloadNoShow reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadNoShow(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadNoShow(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadNoShow call({
    String orderId,
    String driverId,
    String? reason,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadNoShow.copyWith(...)` or call `instanceOfOrderEnvelopePayloadNoShow.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadNoShowCWProxyImpl
    implements _$OrderEnvelopePayloadNoShowCWProxy {
  const _$OrderEnvelopePayloadNoShowCWProxyImpl(this._value);

  final OrderEnvelopePayloadNoShow _value;

  @override
  OrderEnvelopePayloadNoShow orderId(String orderId) => call(orderId: orderId);

  @override
  OrderEnvelopePayloadNoShow driverId(String driverId) =>
      call(driverId: driverId);

  @override
  OrderEnvelopePayloadNoShow reason(String? reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadNoShow(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadNoShow(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadNoShow call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadNoShow(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      driverId: driverId == const $CopyWithPlaceholder() || driverId == null
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $OrderEnvelopePayloadNoShowCopyWith on OrderEnvelopePayloadNoShow {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadNoShow.copyWith(...)` or `instanceOfOrderEnvelopePayloadNoShow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadNoShowCWProxy get copyWith =>
      _$OrderEnvelopePayloadNoShowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadNoShow _$OrderEnvelopePayloadNoShowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayloadNoShow', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['orderId', 'driverId']);
  final val = OrderEnvelopePayloadNoShow(
    orderId: $checkedConvert('orderId', (v) => v as String),
    driverId: $checkedConvert('driverId', (v) => v as String),
    reason: $checkedConvert('reason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadNoShowToJson(
  OrderEnvelopePayloadNoShow instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'driverId': instance.driverId,
  'reason': ?instance.reason,
};
