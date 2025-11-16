// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_leaderboard.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateLeaderboardCWProxy {
  UpdateLeaderboard userId(String? userId);

  UpdateLeaderboard driverId(String? driverId);

  UpdateLeaderboard merchantId(String? merchantId);

  UpdateLeaderboard category(UpdateLeaderboardCategoryEnum? category);

  UpdateLeaderboard period(UpdateLeaderboardPeriodEnum? period);

  UpdateLeaderboard rank(int? rank);

  UpdateLeaderboard score(int? score);

  UpdateLeaderboard periodStart(DateTime? periodStart);

  UpdateLeaderboard periodEnd(DateTime? periodEnd);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateLeaderboard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateLeaderboard(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateLeaderboard call({
    String? userId,
    String? driverId,
    String? merchantId,
    UpdateLeaderboardCategoryEnum? category,
    UpdateLeaderboardPeriodEnum? period,
    int? rank,
    int? score,
    DateTime? periodStart,
    DateTime? periodEnd,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateLeaderboard.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateLeaderboard.copyWith.fieldName(...)`
class _$UpdateLeaderboardCWProxyImpl implements _$UpdateLeaderboardCWProxy {
  const _$UpdateLeaderboardCWProxyImpl(this._value);

  final UpdateLeaderboard _value;

  @override
  UpdateLeaderboard userId(String? userId) => this(userId: userId);

  @override
  UpdateLeaderboard driverId(String? driverId) => this(driverId: driverId);

  @override
  UpdateLeaderboard merchantId(String? merchantId) =>
      this(merchantId: merchantId);

  @override
  UpdateLeaderboard category(UpdateLeaderboardCategoryEnum? category) =>
      this(category: category);

  @override
  UpdateLeaderboard period(UpdateLeaderboardPeriodEnum? period) =>
      this(period: period);

  @override
  UpdateLeaderboard rank(int? rank) => this(rank: rank);

  @override
  UpdateLeaderboard score(int? score) => this(score: score);

  @override
  UpdateLeaderboard periodStart(DateTime? periodStart) =>
      this(periodStart: periodStart);

  @override
  UpdateLeaderboard periodEnd(DateTime? periodEnd) =>
      this(periodEnd: periodEnd);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateLeaderboard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateLeaderboard(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateLeaderboard call({
    Object? userId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? period = const $CopyWithPlaceholder(),
    Object? rank = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? periodStart = const $CopyWithPlaceholder(),
    Object? periodEnd = const $CopyWithPlaceholder(),
  }) {
    return UpdateLeaderboard(
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String?,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as UpdateLeaderboardCategoryEnum?,
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as UpdateLeaderboardPeriodEnum?,
      rank: rank == const $CopyWithPlaceholder()
          ? _value.rank
          // ignore: cast_nullable_to_non_nullable
          : rank as int?,
      score: score == const $CopyWithPlaceholder()
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as int?,
      periodStart: periodStart == const $CopyWithPlaceholder()
          ? _value.periodStart
          // ignore: cast_nullable_to_non_nullable
          : periodStart as DateTime?,
      periodEnd: periodEnd == const $CopyWithPlaceholder()
          ? _value.periodEnd
          // ignore: cast_nullable_to_non_nullable
          : periodEnd as DateTime?,
    );
  }
}

extension $UpdateLeaderboardCopyWith on UpdateLeaderboard {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateLeaderboard.copyWith(...)` or like so:`instanceOfUpdateLeaderboard.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateLeaderboardCWProxy get copyWith =>
      _$UpdateLeaderboardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLeaderboard _$UpdateLeaderboardFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateLeaderboard', json, ($checkedConvert) {
      final val = UpdateLeaderboard(
        userId: $checkedConvert('userId', (v) => v as String?),
        driverId: $checkedConvert('driverId', (v) => v as String?),
        merchantId: $checkedConvert('merchantId', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) => $enumDecodeNullable(_$UpdateLeaderboardCategoryEnumEnumMap, v),
        ),
        period: $checkedConvert(
          'period',
          (v) => $enumDecodeNullable(_$UpdateLeaderboardPeriodEnumEnumMap, v),
        ),
        rank: $checkedConvert('rank', (v) => (v as num?)?.toInt()),
        score: $checkedConvert('score', (v) => (v as num?)?.toInt()),
        periodStart: $checkedConvert(
          'periodStart',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        periodEnd: $checkedConvert(
          'periodEnd',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UpdateLeaderboardToJson(UpdateLeaderboard instance) =>
    <String, dynamic>{
      'userId': ?instance.userId,
      'driverId': ?instance.driverId,
      'merchantId': ?instance.merchantId,
      'category': ?_$UpdateLeaderboardCategoryEnumEnumMap[instance.category],
      'period': ?_$UpdateLeaderboardPeriodEnumEnumMap[instance.period],
      'rank': ?instance.rank,
      'score': ?instance.score,
      'periodStart': ?instance.periodStart?.toIso8601String(),
      'periodEnd': ?instance.periodEnd?.toIso8601String(),
    };

const _$UpdateLeaderboardCategoryEnumEnumMap = {
  UpdateLeaderboardCategoryEnum.rating: 'rating',
  UpdateLeaderboardCategoryEnum.volume: 'volume',
  UpdateLeaderboardCategoryEnum.earnings: 'earnings',
  UpdateLeaderboardCategoryEnum.streak: 'streak',
  UpdateLeaderboardCategoryEnum.onTime: 'on-time',
  UpdateLeaderboardCategoryEnum.completionRate: 'completion-rate',
};

const _$UpdateLeaderboardPeriodEnumEnumMap = {
  UpdateLeaderboardPeriodEnum.daily: 'daily',
  UpdateLeaderboardPeriodEnum.weekly: 'weekly',
  UpdateLeaderboardPeriodEnum.monthly: 'monthly',
  UpdateLeaderboardPeriodEnum.quarterly: 'quarterly',
  UpdateLeaderboardPeriodEnum.yearly: 'yearly',
  UpdateLeaderboardPeriodEnum.allTime: 'all-time',
};
