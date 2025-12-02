// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_location.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyLocationCWProxy {
  EmergencyLocation latitude(num latitude);

  EmergencyLocation longitude(num longitude);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyLocation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyLocation(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyLocation call({num latitude, num longitude});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyLocation.copyWith(...)` or call `instanceOfEmergencyLocation.copyWith.fieldName(value)` for a single field.
class _$EmergencyLocationCWProxyImpl implements _$EmergencyLocationCWProxy {
  const _$EmergencyLocationCWProxyImpl(this._value);

  final EmergencyLocation _value;

  @override
  EmergencyLocation latitude(num latitude) => call(latitude: latitude);

  @override
  EmergencyLocation longitude(num longitude) => call(longitude: longitude);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyLocation(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyLocation(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyLocation call({
    Object? latitude = const $CopyWithPlaceholder(),
    Object? longitude = const $CopyWithPlaceholder(),
  }) {
    return EmergencyLocation(
      latitude: latitude == const $CopyWithPlaceholder() || latitude == null
          ? _value.latitude
          // ignore: cast_nullable_to_non_nullable
          : latitude as num,
      longitude: longitude == const $CopyWithPlaceholder() || longitude == null
          ? _value.longitude
          // ignore: cast_nullable_to_non_nullable
          : longitude as num,
    );
  }
}

extension $EmergencyLocationCopyWith on EmergencyLocation {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyLocation.copyWith(...)` or `instanceOfEmergencyLocation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyLocationCWProxy get copyWith => _$EmergencyLocationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyLocation _$EmergencyLocationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EmergencyLocation', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['latitude', 'longitude']);
      final val = EmergencyLocation(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$EmergencyLocationToJson(EmergencyLocation instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
