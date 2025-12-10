// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_matching_job_payload_pickup_location.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverMatchingJobPayloadPickupLocationCWProxy {
  DriverMatchingJobPayloadPickupLocation x(num x);

  DriverMatchingJobPayloadPickupLocation y(num y);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMatchingJobPayloadPickupLocation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMatchingJobPayloadPickupLocation(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMatchingJobPayloadPickupLocation call({num x, num y});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverMatchingJobPayloadPickupLocation.copyWith(...)` or call `instanceOfDriverMatchingJobPayloadPickupLocation.copyWith.fieldName(value)` for a single field.
class _$DriverMatchingJobPayloadPickupLocationCWProxyImpl
    implements _$DriverMatchingJobPayloadPickupLocationCWProxy {
  const _$DriverMatchingJobPayloadPickupLocationCWProxyImpl(this._value);

  final DriverMatchingJobPayloadPickupLocation _value;

  @override
  DriverMatchingJobPayloadPickupLocation x(num x) => call(x: x);

  @override
  DriverMatchingJobPayloadPickupLocation y(num y) => call(y: y);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMatchingJobPayloadPickupLocation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMatchingJobPayloadPickupLocation(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMatchingJobPayloadPickupLocation call({
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
  }) {
    return DriverMatchingJobPayloadPickupLocation(
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

extension $DriverMatchingJobPayloadPickupLocationCopyWith
    on DriverMatchingJobPayloadPickupLocation {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverMatchingJobPayloadPickupLocation.copyWith(...)` or `instanceOfDriverMatchingJobPayloadPickupLocation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverMatchingJobPayloadPickupLocationCWProxy get copyWith =>
      _$DriverMatchingJobPayloadPickupLocationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverMatchingJobPayloadPickupLocation
_$DriverMatchingJobPayloadPickupLocationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverMatchingJobPayloadPickupLocation', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['x', 'y']);
      final val = DriverMatchingJobPayloadPickupLocation(
        x: $checkedConvert('x', (v) => v as num),
        y: $checkedConvert('y', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$DriverMatchingJobPayloadPickupLocationToJson(
  DriverMatchingJobPayloadPickupLocation instance,
) => <String, dynamic>{'x': instance.x, 'y': instance.y};
