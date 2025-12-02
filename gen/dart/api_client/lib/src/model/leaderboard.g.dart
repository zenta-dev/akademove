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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Leaderboard(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Leaderboard(...).copyWith(id: 12, name: "My name")
  /// ```
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

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLeaderboard.copyWith(...)` or call `instanceOfLeaderboard.copyWith.fieldName(value)` for a single field.
class _$LeaderboardCWProxyImpl implements _$LeaderboardCWProxy {
  const _$LeaderboardCWProxyImpl(this._value);

  final Leaderboard _value;

  @override
  Leaderboard id(String id) => call(id: id);

  @override
  Leaderboard userId(String userId) => call(userId: userId);

  @override
  Leaderboard driverId(String? driverId) => call(driverId: driverId);

  @override
  Leaderboard merchantId(String? merchantId) => call(merchantId: merchantId);

  @override
  Leaderboard category(LeaderboardCategoryEnum category) =>
      call(category: category);

  @override
  Leaderboard period(LeaderboardPeriodEnum period) => call(period: period);

  @override
  Leaderboard rank(int rank) => call(rank: rank);

  @override
  Leaderboard score(int score) => call(score: score);

  @override
  Leaderboard periodStart(DateTime periodStart) =>
      call(periodStart: periodStart);

  @override
  Leaderboard periodEnd(DateTime periodEnd) => call(periodEnd: periodEnd);

  @override
  Leaderboard createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  Leaderboard updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Leaderboard(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Leaderboard(...).copyWith(id: 12, name: "My name")
  /// ```
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
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
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
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as LeaderboardCategoryEnum,
      period: period == const $CopyWithPlaceholder() || period == null
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as LeaderboardPeriodEnum,
      rank: rank == const $CopyWithPlaceholder() || rank == null
          ? _value.rank
          // ignore: cast_nullable_to_non_nullable
          : rank as int,
      score: score == const $CopyWithPlaceholder() || score == null
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as int,
      periodStart:
          periodStart == const $CopyWithPlaceholder() || periodStart == null
          ? _value.periodStart
          // ignore: cast_nullable_to_non_nullable
          : periodStart as DateTime,
      periodEnd: periodEnd == const $CopyWithPlaceholder() || periodEnd == null
          ? _value.periodEnd
          // ignore: cast_nullable_to_non_nullable
          : periodEnd as DateTime,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $LeaderboardCopyWith on Leaderboard {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLeaderboard.copyWith(...)` or `instanceOfLeaderboard.copyWith.fieldName(...)`.
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
  LeaderboardCategoryEnum.RATING: 'RATING',
  LeaderboardCategoryEnum.VOLUME: 'VOLUME',
  LeaderboardCategoryEnum.EARNINGS: 'EARNINGS',
  LeaderboardCategoryEnum.STREAK: 'STREAK',
  LeaderboardCategoryEnum.ON_TIME: 'ON-TIME',
  LeaderboardCategoryEnum.COMPLETION_RATE: 'COMPLETION-RATE',
};

const _$LeaderboardPeriodEnumEnumMap = {
  LeaderboardPeriodEnum.DAILY: 'DAILY',
  LeaderboardPeriodEnum.WEEKLY: 'WEEKLY',
  LeaderboardPeriodEnum.MONTHLY: 'MONTHLY',
  LeaderboardPeriodEnum.QUARTERLY: 'QUARTERLY',
  LeaderboardPeriodEnum.YEARLY: 'YEARLY',
  LeaderboardPeriodEnum.ALL_TIME: 'ALL-TIME',
};
