// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinate_with_meta.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CoordinateWithMetaCWProxy {
  CoordinateWithMeta x(num x);

  CoordinateWithMeta y(num y);

  CoordinateWithMeta isMockLocation(bool? isMockLocation);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CoordinateWithMeta(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CoordinateWithMeta(...).copyWith(id: 12, name: "My name")
  /// ```
  CoordinateWithMeta call({num x, num y, bool? isMockLocation});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCoordinateWithMeta.copyWith(...)` or call `instanceOfCoordinateWithMeta.copyWith.fieldName(value)` for a single field.
class _$CoordinateWithMetaCWProxyImpl implements _$CoordinateWithMetaCWProxy {
  const _$CoordinateWithMetaCWProxyImpl(this._value);

  final CoordinateWithMeta _value;

  @override
  CoordinateWithMeta x(num x) => call(x: x);

  @override
  CoordinateWithMeta y(num y) => call(y: y);

  @override
  CoordinateWithMeta isMockLocation(bool? isMockLocation) =>
      call(isMockLocation: isMockLocation);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CoordinateWithMeta(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CoordinateWithMeta(...).copyWith(id: 12, name: "My name")
  /// ```
  CoordinateWithMeta call({
    Object? x = const $CopyWithPlaceholder(),
    Object? y = const $CopyWithPlaceholder(),
    Object? isMockLocation = const $CopyWithPlaceholder(),
  }) {
    return CoordinateWithMeta(
      x: x == const $CopyWithPlaceholder() || x == null
          ? _value.x
          // ignore: cast_nullable_to_non_nullable
          : x as num,
      y: y == const $CopyWithPlaceholder() || y == null
          ? _value.y
          // ignore: cast_nullable_to_non_nullable
          : y as num,
      isMockLocation: isMockLocation == const $CopyWithPlaceholder()
          ? _value.isMockLocation
          // ignore: cast_nullable_to_non_nullable
          : isMockLocation as bool?,
    );
  }
}

extension $CoordinateWithMetaCopyWith on CoordinateWithMeta {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCoordinateWithMeta.copyWith(...)` or `instanceOfCoordinateWithMeta.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CoordinateWithMetaCWProxy get copyWith =>
      _$CoordinateWithMetaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinateWithMeta _$CoordinateWithMetaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CoordinateWithMeta', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['x', 'y']);
      final val = CoordinateWithMeta(
        x: $checkedConvert('x', (v) => v as num),
        y: $checkedConvert('y', (v) => v as num),
        isMockLocation: $checkedConvert('isMockLocation', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$CoordinateWithMetaToJson(CoordinateWithMeta instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'isMockLocation': ?instance.isMockLocation,
    };
