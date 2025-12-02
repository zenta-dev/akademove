// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_driver_update_location.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadDriverUpdateLocationCWProxy {
  OrderEnvelopePayloadDriverUpdateLocation driverId(String driverId);

  OrderEnvelopePayloadDriverUpdateLocation x(num x);

  OrderEnvelopePayloadDriverUpdateLocation y(num y);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadDriverUpdateLocation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadDriverUpdateLocation(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadDriverUpdateLocation call({String driverId, num x, num y});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadDriverUpdateLocation.copyWith(...)` or call `instanceOfOrderEnvelopePayloadDriverUpdateLocation.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadDriverUpdateLocationCWProxyImpl
    implements _$OrderEnvelopePayloadDriverUpdateLocationCWProxy {
  const _$OrderEnvelopePayloadDriverUpdateLocationCWProxyImpl(this._value);

  final OrderEnvelopePayloadDriverUpdateLocation _value;

  @override
  OrderEnvelopePayloadDriverUpdateLocation driverId(String driverId) => call(driverId: driverId);

  @override
  OrderEnvelopePayloadDriverUpdateLocation x(num x) => call(x: x);

  @override
  OrderEnvelopePayloadDriverUpdateLocation y(num y) => call(y: y);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadDriverUpdateLocation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadDriverUpdateLocation(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadDriverUpdateLocation call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadDriverUpdateLocation(
      driverId: driverId == const $CopyWithPlaceholder() || driverId == null
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      x: x == const $CopyWithPlaceholder() || x == null
          ? _value.x
          // ignore: cast_nullable_to_non_nullable
          : x as num,
      y: y == const $CopyWithPlaceholder() || y == null
          ? _value.y
          // ignore: cast_nullable_to_non_nullable
          : y as num,
    );
  }
}

extension $OrderEnvelopePayloadDriverUpdateLocationCopyWith on OrderEnvelopePayloadDriverUpdateLocation {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadDriverUpdateLocation.copyWith(...)` or `instanceOfOrderEnvelopePayloadDriverUpdateLocation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadDriverUpdateLocationCWProxy get copyWith =>
      _$OrderEnvelopePayloadDriverUpdateLocationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadDriverUpdateLocation _$OrderEnvelopePayloadDriverUpdateLocationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayloadDriverUpdateLocation', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['driverId', 'x', 'y']);
  final val = OrderEnvelopePayloadDriverUpdateLocation(
    driverId: $checkedConvert('driverId', (v) => v as String),
    x: $checkedConvert('x', (v) => v as num),
    y: $checkedConvert('y', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadDriverUpdateLocationToJson(
  OrderEnvelopePayloadDriverUpdateLocation instance,
) => <String, dynamic>{'driverId': instance.driverId, 'x': instance.x, 'y': instance.y};
