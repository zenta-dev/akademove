// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_order_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSOrderEnvelopePayloadCWProxy {
  WSOrderEnvelopePayload driverUpdateLocation(Coordinate? driverUpdateLocation);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSOrderEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSOrderEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  WSOrderEnvelopePayload call({Coordinate? driverUpdateLocation});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWSOrderEnvelopePayload.copyWith(...)` or call `instanceOfWSOrderEnvelopePayload.copyWith.fieldName(value)` for a single field.
class _$WSOrderEnvelopePayloadCWProxyImpl
    implements _$WSOrderEnvelopePayloadCWProxy {
  const _$WSOrderEnvelopePayloadCWProxyImpl(this._value);

  final WSOrderEnvelopePayload _value;

  @override
  WSOrderEnvelopePayload driverUpdateLocation(
    Coordinate? driverUpdateLocation,
  ) => call(driverUpdateLocation: driverUpdateLocation);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WSOrderEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WSOrderEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  WSOrderEnvelopePayload call({
    Object? driverUpdateLocation = const $CopyWithPlaceholder(),
  }) {
    return WSOrderEnvelopePayload(
      driverUpdateLocation: driverUpdateLocation == const $CopyWithPlaceholder()
          ? _value.driverUpdateLocation
          // ignore: cast_nullable_to_non_nullable
          : driverUpdateLocation as Coordinate?,
    );
  }
}

extension $WSOrderEnvelopePayloadCopyWith on WSOrderEnvelopePayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWSOrderEnvelopePayload.copyWith(...)` or `instanceOfWSOrderEnvelopePayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WSOrderEnvelopePayloadCWProxy get copyWith =>
      _$WSOrderEnvelopePayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WSOrderEnvelopePayload _$WSOrderEnvelopePayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WSOrderEnvelopePayload', json, ($checkedConvert) {
  final val = WSOrderEnvelopePayload(
    driverUpdateLocation: $checkedConvert(
      'driverUpdateLocation',
      (v) => v == null ? null : Coordinate.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WSOrderEnvelopePayloadToJson(
  WSOrderEnvelopePayload instance,
) => <String, dynamic>{
  'driverUpdateLocation': ?instance.driverUpdateLocation?.toJson(),
};
