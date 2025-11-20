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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeCriteria(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeCriteria(...).copyWith(id: 12, name: "My name")
  /// ```
  BadgeCriteria call({
    int? minOrders,
    num? minRating,
    num? minOnTimeRate,
    int? minStreak,
    num? minEarnings,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBadgeCriteria.copyWith(...)` or call `instanceOfBadgeCriteria.copyWith.fieldName(value)` for a single field.
class _$BadgeCriteriaCWProxyImpl implements _$BadgeCriteriaCWProxy {
  const _$BadgeCriteriaCWProxyImpl(this._value);

  final BadgeCriteria _value;

  @override
  BadgeCriteria minOrders(int? minOrders) => call(minOrders: minOrders);

  @override
  BadgeCriteria minRating(num? minRating) => call(minRating: minRating);

  @override
  BadgeCriteria minOnTimeRate(num? minOnTimeRate) =>
      call(minOnTimeRate: minOnTimeRate);

  @override
  BadgeCriteria minStreak(int? minStreak) => call(minStreak: minStreak);

  @override
  BadgeCriteria minEarnings(num? minEarnings) => call(minEarnings: minEarnings);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BadgeCriteria(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BadgeCriteria(...).copyWith(id: 12, name: "My name")
  /// ```
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBadgeCriteria.copyWith(...)` or `instanceOfBadgeCriteria.copyWith.fieldName(...)`.
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
