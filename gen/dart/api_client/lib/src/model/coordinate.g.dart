// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinate.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CoordinateCWProxy {
  Coordinate x(num x);

  Coordinate y(num y);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Coordinate(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Coordinate(...).copyWith(id: 12, name: "My name")
  /// ````
  Coordinate call({num x, num y});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCoordinate.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCoordinate.copyWith.fieldName(...)`
class _$CoordinateCWProxyImpl implements _$CoordinateCWProxy {
  const _$CoordinateCWProxyImpl(this._value);

  final Coordinate _value;

  @override
  Coordinate x(num x) => this(x: x);

  @override
  Coordinate y(num y) => this(y: y);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Coordinate(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Coordinate(...).copyWith(id: 12, name: "My name")
  /// ````
  Coordinate call({
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
  }) {
    return Coordinate(
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

extension $CoordinateCopyWith on Coordinate {
  /// Returns a callable class that can be used as follows: `instanceOfCoordinate.copyWith(...)` or like so:`instanceOfCoordinate.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CoordinateCWProxy get copyWith => _$CoordinateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coordinate _$CoordinateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Coordinate', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['x', 'y']);
      final val = Coordinate(
        x: $checkedConvert('x', (v) => v as num),
        y: $checkedConvert('y', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$CoordinateToJson(Coordinate instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};
