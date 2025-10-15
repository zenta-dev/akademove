// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TimeCWProxy {
  Time h(num h);

  Time m(num m);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Time(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Time(...).copyWith(id: 12, name: "My name")
  /// ````
  Time call({num h, num m});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTime.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTime.copyWith.fieldName(...)`
class _$TimeCWProxyImpl implements _$TimeCWProxy {
  const _$TimeCWProxyImpl(this._value);

  final Time _value;

  @override
  Time h(num h) => this(h: h);

  @override
  Time m(num m) => this(m: m);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Time(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Time(...).copyWith(id: 12, name: "My name")
  /// ````
  Time call({
    Object? h = const $CopyWithPlaceholder(),
    Object? m = const $CopyWithPlaceholder(),
  }) {
    return Time(
      h: h == const $CopyWithPlaceholder()
          ? _value.h
          // ignore: cast_nullable_to_non_nullable
          : h as num,
      m: m == const $CopyWithPlaceholder()
          ? _value.m
          // ignore: cast_nullable_to_non_nullable
          : m as num,
    );
  }
}

extension $TimeCopyWith on Time {
  /// Returns a callable class that can be used as follows: `instanceOfTime.copyWith(...)` or like so:`instanceOfTime.copyWith.fieldName(...)`.
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
