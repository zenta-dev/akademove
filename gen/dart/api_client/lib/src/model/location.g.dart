// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LocationCWProxy {
  Location lat(num lat);

  Location lng(num lng);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Location(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Location(...).copyWith(id: 12, name: "My name")
  /// ```
  Location call({num lat, num lng});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLocation.copyWith(...)` or call `instanceOfLocation.copyWith.fieldName(value)` for a single field.
class _$LocationCWProxyImpl implements _$LocationCWProxy {
  const _$LocationCWProxyImpl(this._value);

  final Location _value;

  @override
  Location lat(num lat) => call(lat: lat);

  @override
  Location lng(num lng) => call(lng: lng);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Location(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Location(...).copyWith(id: 12, name: "My name")
  /// ```
  Location call({Object? lat = const $CopyWithPlaceholder(), Object? lng = const $CopyWithPlaceholder()}) {
    return Location(
      lat: lat == const $CopyWithPlaceholder() || lat == null
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as num,
      lng: lng == const $CopyWithPlaceholder() || lng == null
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as num,
    );
  }
}

extension $LocationCopyWith on Location {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLocation.copyWith(...)` or `instanceOfLocation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LocationCWProxy get copyWith => _$LocationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => $checkedCreate('Location', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['lat', 'lng']);
  final val = Location(lat: $checkedConvert('lat', (v) => v as num), lng: $checkedConvert('lng', (v) => v as num));
  return val;
});

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};
