// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_request_current_location.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverUpdateRequestCurrentLocationCWProxy {
  DriverUpdateRequestCurrentLocation x(num x);

  DriverUpdateRequestCurrentLocation y(num y);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateRequestCurrentLocation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateRequestCurrentLocation(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateRequestCurrentLocation call({num x, num y});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverUpdateRequestCurrentLocation.copyWith(...)` or call `instanceOfDriverUpdateRequestCurrentLocation.copyWith.fieldName(value)` for a single field.
class _$DriverUpdateRequestCurrentLocationCWProxyImpl implements _$DriverUpdateRequestCurrentLocationCWProxy {
  const _$DriverUpdateRequestCurrentLocationCWProxyImpl(this._value);

  final DriverUpdateRequestCurrentLocation _value;

  @override
  DriverUpdateRequestCurrentLocation x(num x) => call(x: x);

  @override
  DriverUpdateRequestCurrentLocation y(num y) => call(y: y);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateRequestCurrentLocation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateRequestCurrentLocation(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateRequestCurrentLocation call({
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
  }) {
    return DriverUpdateRequestCurrentLocation(
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

extension $DriverUpdateRequestCurrentLocationCopyWith on DriverUpdateRequestCurrentLocation {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverUpdateRequestCurrentLocation.copyWith(...)` or `instanceOfDriverUpdateRequestCurrentLocation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverUpdateRequestCurrentLocationCWProxy get copyWith => _$DriverUpdateRequestCurrentLocationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUpdateRequestCurrentLocation _$DriverUpdateRequestCurrentLocationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverUpdateRequestCurrentLocation', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['x', 'y']);
      final val = DriverUpdateRequestCurrentLocation(
        x: $checkedConvert('x', (v) => v as num),
        y: $checkedConvert('y', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$DriverUpdateRequestCurrentLocationToJson(DriverUpdateRequestCurrentLocation instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};
