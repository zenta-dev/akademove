// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaderboardCWProxy {
  Leaderboard id(String id);

  Leaderboard userId(String userId);

  Leaderboard driverId(String? driverId);

  Leaderboard merchantId(String? merchantId);

  Leaderboard category(LeaderboardCategoryEnum category);

  Leaderboard period(LeaderboardPeriodEnum period);

  Leaderboard rank(int rank);

  Leaderboard score(int score);

  Leaderboard periodStart(DateTime periodStart);

  Leaderboard periodEnd(DateTime periodEnd);

  Leaderboard createdAt(DateTime createdAt);

  Leaderboard updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Leaderboard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Leaderboard(...).copyWith(id: 12, name: "My name")
  /// ````
  Leaderboard call({
    String id,
    String userId,
    String? driverId,
    String? merchantId,
    LeaderboardCategoryEnum category,
    LeaderboardPeriodEnum period,
    int rank,
    int score,
    DateTime periodStart,
    DateTime periodEnd,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaderboard.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaderboard.copyWith.fieldName(...)`
class _$LeaderboardCWProxyImpl implements _$LeaderboardCWProxy {
  const _$LeaderboardCWProxyImpl(this._value);

  final Leaderboard _value;

  @override
  Leaderboard id(String id) => this(id: id);

  @override
  Leaderboard userId(String userId) => this(userId: userId);

  @override
  Leaderboard driverId(String? driverId) => this(driverId: driverId);

  @override
  Leaderboard merchantId(String? merchantId) => this(merchantId: merchantId);

  @override
  Leaderboard category(LeaderboardCategoryEnum category) =>
      this(category: category);

  @override
  Leaderboard period(LeaderboardPeriodEnum period) => this(period: period);

  @override
  Leaderboard rank(int rank) => this(rank: rank);

  @override
  Leaderboard score(int score) => this(score: score);

  @override
  Leaderboard periodStart(DateTime periodStart) =>
      this(periodStart: periodStart);

  @override
  Leaderboard periodEnd(DateTime periodEnd) => this(periodEnd: periodEnd);

  @override
  Leaderboard createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Leaderboard updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Leaderboard(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Leaderboard(...).copyWith(id: 12, name: "My name")
  /// ````
  Leaderboard call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? driverId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? period = const $CopyWithPlaceholder(),
    Object? rank = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? periodStart = const $CopyWithPlaceholder(),
    Object? periodEnd = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Leaderboard(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
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
          : category as LeaderboardCategoryEnum,
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as LeaderboardPeriodEnum,
      rank: rank == const $CopyWithPlaceholder()
          ? _value.rank
          // ignore: cast_nullable_to_non_nullable
          : rank as int,
      score: score == const $CopyWithPlaceholder()
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as int,
      periodStart: periodStart == const $CopyWithPlaceholder()
          ? _value.periodStart
          // ignore: cast_nullable_to_non_nullable
          : periodStart as DateTime,
      periodEnd: periodEnd == const $CopyWithPlaceholder()
          ? _value.periodEnd
          // ignore: cast_nullable_to_non_nullable
          : periodEnd as DateTime,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $LeaderboardCopyWith on Leaderboard {
  /// Returns a callable class that can be used as follows: `instanceOfLeaderboard.copyWith(...)` or like so:`instanceOfLeaderboard.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaderboardCWProxy get copyWith => _$LeaderboardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leaderboard _$LeaderboardFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Leaderboard', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'userId',
      'category',
      'period',
      'rank',
      'score',
      'periodStart',
      'periodEnd',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Leaderboard(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    driverId: $checkedConvert('driverId', (v) => v as String?),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
    category: $checkedConvert(
      'category',
      (v) => $enumDecode(_$LeaderboardCategoryEnumEnumMap, v),
    ),
    period: $checkedConvert(
      'period',
      (v) => $enumDecode(_$LeaderboardPeriodEnumEnumMap, v),
    ),
    rank: $checkedConvert('rank', (v) => (v as num).toInt()),
    score: $checkedConvert('score', (v) => (v as num).toInt()),
    periodStart: $checkedConvert(
      'periodStart',
      (v) => DateTime.parse(v as String),
    ),
    periodEnd: $checkedConvert('periodEnd', (v) => DateTime.parse(v as String)),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$LeaderboardToJson(Leaderboard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'driverId': ?instance.driverId,
      'merchantId': ?instance.merchantId,
      'category': _$LeaderboardCategoryEnumEnumMap[instance.category]!,
      'period': _$LeaderboardPeriodEnumEnumMap[instance.period]!,
      'rank': instance.rank,
      'score': instance.score,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$LeaderboardCategoryEnumEnumMap = {
  LeaderboardCategoryEnum.rating: 'rating',
  LeaderboardCategoryEnum.volume: 'volume',
  LeaderboardCategoryEnum.earnings: 'earnings',
  LeaderboardCategoryEnum.streak: 'streak',
  LeaderboardCategoryEnum.onTime: 'on-time',
  LeaderboardCategoryEnum.completionRate: 'completion-rate',
};

const _$LeaderboardPeriodEnumEnumMap = {
  LeaderboardPeriodEnum.daily: 'daily',
  LeaderboardPeriodEnum.weekly: 'weekly',
  LeaderboardPeriodEnum.monthly: 'monthly',
  LeaderboardPeriodEnum.quarterly: 'quarterly',
  LeaderboardPeriodEnum.yearly: 'yearly',
  LeaderboardPeriodEnum.allTime: 'all-time',
};
