// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_done.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadDoneCWProxy {
  OrderEnvelopePayloadDone by(OrderEnvelopePayloadDoneByEnum by);

  OrderEnvelopePayloadDone orderId(String orderId);

  OrderEnvelopePayloadDone driverId(String driverId);

  OrderEnvelopePayloadDone driverCurrentLocation(Coordinate driverCurrentLocation);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadDone(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadDone(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadDone call({
    OrderEnvelopePayloadDoneByEnum by,
    String orderId,
    String driverId,
    Coordinate driverCurrentLocation,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadDone.copyWith(...)` or call `instanceOfOrderEnvelopePayloadDone.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadDoneCWProxyImpl implements _$OrderEnvelopePayloadDoneCWProxy {
  const _$OrderEnvelopePayloadDoneCWProxyImpl(this._value);

  final OrderEnvelopePayloadDone _value;

  @override
  OrderEnvelopePayloadDone by(OrderEnvelopePayloadDoneByEnum by) => call(by: by);

  @override
  OrderEnvelopePayloadDone orderId(String orderId) => call(orderId: orderId);

  @override
  OrderEnvelopePayloadDone driverId(String driverId) => call(driverId: driverId);

  @override
  OrderEnvelopePayloadDone driverCurrentLocation(Coordinate driverCurrentLocation) =>
      call(driverCurrentLocation: driverCurrentLocation);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadDone(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadDone(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadDone call({
    Object? by = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? driverCurrentLocation = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadDone(
      by: by == const $CopyWithPlaceholder() || by == null
          ? _value.by
          // ignore: cast_nullable_to_non_nullable
          : by as OrderEnvelopePayloadDoneByEnum,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      driverId: driverId == const $CopyWithPlaceholder() || driverId == null
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      driverCurrentLocation: driverCurrentLocation == const $CopyWithPlaceholder() || driverCurrentLocation == null
          ? _value.driverCurrentLocation
          // ignore: cast_nullable_to_non_nullable
          : driverCurrentLocation as Coordinate,
    );
  }
}

extension $OrderEnvelopePayloadDoneCopyWith on OrderEnvelopePayloadDone {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadDone.copyWith(...)` or `instanceOfOrderEnvelopePayloadDone.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadDoneCWProxy get copyWith => _$OrderEnvelopePayloadDoneCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadDone _$OrderEnvelopePayloadDoneFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderEnvelopePayloadDone', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['by', 'orderId', 'driverId', 'driverCurrentLocation']);
      final val = OrderEnvelopePayloadDone(
        by: $checkedConvert('by', (v) => $enumDecode(_$OrderEnvelopePayloadDoneByEnumEnumMap, v)),
        orderId: $checkedConvert('orderId', (v) => v as String),
        driverId: $checkedConvert('driverId', (v) => v as String),
        driverCurrentLocation: $checkedConvert(
          'driverCurrentLocation',
          (v) => Coordinate.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderEnvelopePayloadDoneToJson(OrderEnvelopePayloadDone instance) => <String, dynamic>{
  'by': _$OrderEnvelopePayloadDoneByEnumEnumMap[instance.by]!,
  'orderId': instance.orderId,
  'driverId': instance.driverId,
  'driverCurrentLocation': instance.driverCurrentLocation.toJson(),
};

const _$OrderEnvelopePayloadDoneByEnumEnumMap = {
  OrderEnvelopePayloadDoneByEnum.USER: 'USER',
  OrderEnvelopePayloadDoneByEnum.DRIVER: 'DRIVER',
};
