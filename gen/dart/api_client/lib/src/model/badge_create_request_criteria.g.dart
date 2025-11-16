// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_create_request_criteria.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeCreateRequestCriteriaCWProxy {
  BadgeCreateRequestCriteria minOrders(int? minOrders);

  BadgeCreateRequestCriteria minRating(num? minRating);

  BadgeCreateRequestCriteria minOnTimeRate(num? minOnTimeRate);

  BadgeCreateRequestCriteria minStreak(int? minStreak);

  BadgeCreateRequestCriteria minEarnings(num? minEarnings);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeCreateRequestCriteria(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeCreateRequestCriteria(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeCreateRequestCriteria call({
    int? minOrders,
    num? minRating,
    num? minOnTimeRate,
    int? minStreak,
    num? minEarnings,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeCreateRequestCriteria.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeCreateRequestCriteria.copyWith.fieldName(...)`
class _$BadgeCreateRequestCriteriaCWProxyImpl
    implements _$BadgeCreateRequestCriteriaCWProxy {
  const _$BadgeCreateRequestCriteriaCWProxyImpl(this._value);

  final BadgeCreateRequestCriteria _value;

  @override
  BadgeCreateRequestCriteria minOrders(int? minOrders) =>
      this(minOrders: minOrders);

  @override
  BadgeCreateRequestCriteria minRating(num? minRating) =>
      this(minRating: minRating);

  @override
  BadgeCreateRequestCriteria minOnTimeRate(num? minOnTimeRate) =>
      this(minOnTimeRate: minOnTimeRate);

  @override
  BadgeCreateRequestCriteria minStreak(int? minStreak) =>
      this(minStreak: minStreak);

  @override
  BadgeCreateRequestCriteria minEarnings(num? minEarnings) =>
      this(minEarnings: minEarnings);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeCreateRequestCriteria(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeCreateRequestCriteria(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeCreateRequestCriteria call({
    Object? minOrders = const $CopyWithPlaceholder(),
    Object? minRating = const $CopyWithPlaceholder(),
    Object? minOnTimeRate = const $CopyWithPlaceholder(),
    Object? minStreak = const $CopyWithPlaceholder(),
    Object? minEarnings = const $CopyWithPlaceholder(),
  }) {
    return BadgeCreateRequestCriteria(
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

extension $BadgeCreateRequestCriteriaCopyWith on BadgeCreateRequestCriteria {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeCreateRequestCriteria.copyWith(...)` or like so:`instanceOfBadgeCreateRequestCriteria.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeCreateRequestCriteriaCWProxy get copyWith =>
      _$BadgeCreateRequestCriteriaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeCreateRequestCriteria _$BadgeCreateRequestCriteriaFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeCreateRequestCriteria', json, ($checkedConvert) {
  final val = BadgeCreateRequestCriteria(
    minOrders: $checkedConvert('minOrders', (v) => (v as num?)?.toInt()),
    minRating: $checkedConvert('minRating', (v) => v as num?),
    minOnTimeRate: $checkedConvert('minOnTimeRate', (v) => v as num?),
    minStreak: $checkedConvert('minStreak', (v) => (v as num?)?.toInt()),
    minEarnings: $checkedConvert('minEarnings', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$BadgeCreateRequestCriteriaToJson(
  BadgeCreateRequestCriteria instance,
) => <String, dynamic>{
  'minOrders': ?instance.minOrders,
  'minRating': ?instance.minRating,
  'minOnTimeRate': ?instance.minOnTimeRate,
  'minStreak': ?instance.minStreak,
  'minEarnings': ?instance.minEarnings,
};
