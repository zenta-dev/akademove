// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_criteria.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeCriteriaCWProxy {
  BadgeCriteria minOrders(int? minOrders);

  BadgeCriteria minRating(num? minRating);

  BadgeCriteria minOnTimeRate(num? minOnTimeRate);

  BadgeCriteria minStreak(int? minStreak);

  BadgeCriteria minEarnings(num? minEarnings);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeCriteria(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeCriteria(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeCriteria call({
    int? minOrders,
    num? minRating,
    num? minOnTimeRate,
    int? minStreak,
    num? minEarnings,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeCriteria.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeCriteria.copyWith.fieldName(...)`
class _$BadgeCriteriaCWProxyImpl implements _$BadgeCriteriaCWProxy {
  const _$BadgeCriteriaCWProxyImpl(this._value);

  final BadgeCriteria _value;

  @override
  BadgeCriteria minOrders(int? minOrders) => this(minOrders: minOrders);

  @override
  BadgeCriteria minRating(num? minRating) => this(minRating: minRating);

  @override
  BadgeCriteria minOnTimeRate(num? minOnTimeRate) =>
      this(minOnTimeRate: minOnTimeRate);

  @override
  BadgeCriteria minStreak(int? minStreak) => this(minStreak: minStreak);

  @override
  BadgeCriteria minEarnings(num? minEarnings) => this(minEarnings: minEarnings);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeCriteria(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeCriteria(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeCriteria call({
    Object? minOrders = const $CopyWithPlaceholder(),
    Object? minRating = const $CopyWithPlaceholder(),
    Object? minOnTimeRate = const $CopyWithPlaceholder(),
    Object? minStreak = const $CopyWithPlaceholder(),
    Object? minEarnings = const $CopyWithPlaceholder(),
  }) {
    return BadgeCriteria(
      minOrders: minOrders == const $CopyWithPlaceholder()
          ? _value.minOrders
          // ignore: cast_nullable_to_non_nullable
          : minOrders as int?,
      minRating: minRating == const $CopyWithPlaceholder()
          ? _value.minRating
          // ignore: cast_nullable_to_non_nullable
          : minRating as num?,
      minOnTimeRate: minOnTimeRate == const $CopyWithPlaceholder()
          ? _value.minOnTimeRate
          // ignore: cast_nullable_to_non_nullable
          : minOnTimeRate as num?,
      minStreak: minStreak == const $CopyWithPlaceholder()
          ? _value.minStreak
          // ignore: cast_nullable_to_non_nullable
          : minStreak as int?,
      minEarnings: minEarnings == const $CopyWithPlaceholder()
          ? _value.minEarnings
          // ignore: cast_nullable_to_non_nullable
          : minEarnings as num?,
    );
  }
}

extension $BadgeCriteriaCopyWith on BadgeCriteria {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeCriteria.copyWith(...)` or like so:`instanceOfBadgeCriteria.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeCriteriaCWProxy get copyWith => _$BadgeCriteriaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeCriteria _$BadgeCriteriaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BadgeCriteria', json, ($checkedConvert) {
      final val = BadgeCriteria(
        minOrders: $checkedConvert('minOrders', (v) => (v as num?)?.toInt()),
        minRating: $checkedConvert('minRating', (v) => v as num?),
        minOnTimeRate: $checkedConvert('minOnTimeRate', (v) => v as num?),
        minStreak: $checkedConvert('minStreak', (v) => (v as num?)?.toInt()),
        minEarnings: $checkedConvert('minEarnings', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$BadgeCriteriaToJson(BadgeCriteria instance) =>
    <String, dynamic>{
      'minOrders': ?instance.minOrders,
      'minRating': ?instance.minRating,
      'minOnTimeRate': ?instance.minOnTimeRate,
      'minStreak': ?instance.minStreak,
      'minEarnings': ?instance.minEarnings,
    };
