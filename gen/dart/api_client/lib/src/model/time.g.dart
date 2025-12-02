// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TimeCWProxy {
  Time h(num h);

  Time m(num m);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Time(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Time(...).copyWith(id: 12, name: "My name")
  /// ```
  Time call({num h, num m});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfTime.copyWith(...)` or call `instanceOfTime.copyWith.fieldName(value)` for a single field.
class _$TimeCWProxyImpl implements _$TimeCWProxy {
  const _$TimeCWProxyImpl(this._value);

  final Time _value;

  @override
  Time h(num h) => call(h: h);

  @override
  Time m(num m) => call(m: m);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Time(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Time(...).copyWith(id: 12, name: "My name")
  /// ```
  Time call({
    Object? h = const $CopyWithPlaceholder(),
    Object? m = const $CopyWithPlaceholder(),
  }) {
    return Time(
      h: h == const $CopyWithPlaceholder() || h == null
          ? _value.h
          // ignore: cast_nullable_to_non_nullable
          : h as num,
      m: m == const $CopyWithPlaceholder() || m == null
          ? _value.m
          // ignore: cast_nullable_to_non_nullable
          : m as num,
    );
  }
}

extension $TimeCopyWith on Time {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfTime.copyWith(...)` or `instanceOfTime.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TimeCWProxy get copyWith => _$TimeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Time _$TimeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Time', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['h', 'm']);
      final val = Time(
        h: $checkedConvert('h', (v) => v as num),
        m: $checkedConvert('m', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
  'h': instance.h,
  'm': instance.m,
};
