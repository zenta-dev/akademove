// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinate.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CoordinateCWProxy {
  Coordinate x(num x);

  Coordinate y(num y);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Coordinate(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Coordinate(...).copyWith(id: 12, name: "My name")
  /// ```
  Coordinate call({num x, num y});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCoordinate.copyWith(...)` or call `instanceOfCoordinate.copyWith.fieldName(value)` for a single field.
class _$CoordinateCWProxyImpl implements _$CoordinateCWProxy {
  const _$CoordinateCWProxyImpl(this._value);

  final Coordinate _value;

  @override
  Coordinate x(num x) => call(x: x);

  @override
  Coordinate y(num y) => call(y: y);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Coordinate(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Coordinate(...).copyWith(id: 12, name: "My name")
  /// ```
  Coordinate call({
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
  }) {
    return Coordinate(
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

extension $CoordinateCopyWith on Coordinate {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCoordinate.copyWith(...)` or `instanceOfCoordinate.copyWith.fieldName(...)`.
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
