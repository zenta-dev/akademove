// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LocationCWProxy {
  Location lat(num lat);

  Location lng(num lng);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Location(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Location(...).copyWith(id: 12, name: "My name")
  /// ````
  Location call({num lat, num lng});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLocation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLocation.copyWith.fieldName(...)`
class _$LocationCWProxyImpl implements _$LocationCWProxy {
  const _$LocationCWProxyImpl(this._value);

  final Location _value;

  @override
  Location lat(num lat) => this(lat: lat);

  @override
  Location lng(num lng) => this(lng: lng);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Location(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Location(...).copyWith(id: 12, name: "My name")
  /// ````
  Location call({
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
  }) {
    return Location(
      lat: lat == const $CopyWithPlaceholder()
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as num,
      lng: lng == const $CopyWithPlaceholder()
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as num,
    );
  }
}

extension $LocationCopyWith on Location {
  /// Returns a callable class that can be used as follows: `instanceOfLocation.copyWith(...)` or like so:`instanceOfLocation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LocationCWProxy get copyWith => _$LocationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Location', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['lat', 'lng']);
      final val = Location(
        lat: $checkedConvert('lat', (v) => v as num),
        lng: $checkedConvert('lng', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
};
