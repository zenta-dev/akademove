// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_request_current_location.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverUpdateRequestCurrentLocationCWProxy {
  DriverUpdateRequestCurrentLocation x(num x);

  DriverUpdateRequestCurrentLocation y(num y);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverUpdateRequestCurrentLocation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverUpdateRequestCurrentLocation(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverUpdateRequestCurrentLocation call({num x, num y});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverUpdateRequestCurrentLocation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverUpdateRequestCurrentLocation.copyWith.fieldName(...)`
class _$DriverUpdateRequestCurrentLocationCWProxyImpl
    implements _$DriverUpdateRequestCurrentLocationCWProxy {
  const _$DriverUpdateRequestCurrentLocationCWProxyImpl(this._value);

  final DriverUpdateRequestCurrentLocation _value;

  @override
  DriverUpdateRequestCurrentLocation x(num x) => this(x: x);

  @override
  DriverUpdateRequestCurrentLocation y(num y) => this(y: y);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverUpdateRequestCurrentLocation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverUpdateRequestCurrentLocation(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverUpdateRequestCurrentLocation call({
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
  }) {
    return DriverUpdateRequestCurrentLocation(
      x: x == const $CopyWithPlaceholder()
          ? _value.x
          // ignore: cast_nullable_to_non_nullable
          : x as num,
      y: y == const $CopyWithPlaceholder()
          ? _value.y
          // ignore: cast_nullable_to_non_nullable
          : y as num,
    );
  }
}

extension $DriverUpdateRequestCurrentLocationCopyWith
    on DriverUpdateRequestCurrentLocation {
  /// Returns a callable class that can be used as follows: `instanceOfDriverUpdateRequestCurrentLocation.copyWith(...)` or like so:`instanceOfDriverUpdateRequestCurrentLocation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverUpdateRequestCurrentLocationCWProxy get copyWith =>
      _$DriverUpdateRequestCurrentLocationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUpdateRequestCurrentLocation _$DriverUpdateRequestCurrentLocationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverUpdateRequestCurrentLocation', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['x', 'y']);
  final val = DriverUpdateRequestCurrentLocation(
    x: $checkedConvert('x', (v) => v as num),
    y: $checkedConvert('y', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DriverUpdateRequestCurrentLocationToJson(
  DriverUpdateRequestCurrentLocation instance,
) => <String, dynamic>{'x': instance.x, 'y': instance.y};
