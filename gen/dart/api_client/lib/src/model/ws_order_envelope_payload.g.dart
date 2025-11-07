// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_order_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WSOrderEnvelopePayloadCWProxy {
  WSOrderEnvelopePayload driverUpdateLocation(Coordinate? driverUpdateLocation);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSOrderEnvelopePayload(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSOrderEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ````
  WSOrderEnvelopePayload call({Coordinate? driverUpdateLocation});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWSOrderEnvelopePayload.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWSOrderEnvelopePayload.copyWith.fieldName(...)`
class _$WSOrderEnvelopePayloadCWProxyImpl
    implements _$WSOrderEnvelopePayloadCWProxy {
  const _$WSOrderEnvelopePayloadCWProxyImpl(this._value);

  final WSOrderEnvelopePayload _value;

  @override
  WSOrderEnvelopePayload driverUpdateLocation(
    Coordinate? driverUpdateLocation,
  ) => this(driverUpdateLocation: driverUpdateLocation);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WSOrderEnvelopePayload(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WSOrderEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ````
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
  /// Returns a callable class that can be used as follows: `instanceOfWSOrderEnvelopePayload.copyWith(...)` or like so:`instanceOfWSOrderEnvelopePayload.copyWith.fieldName(...)`.
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
