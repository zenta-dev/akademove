// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_with_driver.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaderboardWithDriverCWProxy {
  LeaderboardWithDriver id(String id);

  LeaderboardWithDriver userId(String userId);

  LeaderboardWithDriver driverId(String? driverId);

  LeaderboardWithDriver merchantId(String? merchantId);

  LeaderboardWithDriver category(LeaderboardCategory category);

  LeaderboardWithDriver period(LeaderboardPeriod period);

  LeaderboardWithDriver rank(int rank);

  LeaderboardWithDriver score(int score);

  LeaderboardWithDriver periodStart(DateTime periodStart);

  LeaderboardWithDriver periodEnd(DateTime periodEnd);

  LeaderboardWithDriver createdAt(DateTime createdAt);

  LeaderboardWithDriver updatedAt(DateTime updatedAt);

  LeaderboardWithDriver driver(LeaderboardDriverInfo? driver);

  LeaderboardWithDriver previousRank(int? previousRank);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardWithDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardWithDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardWithDriver call({
    String id,
    String userId,
    String? driverId,
    String? merchantId,
    LeaderboardCategory category,
    LeaderboardPeriod period,
    int rank,
    int score,
    DateTime periodStart,
    DateTime periodEnd,
    DateTime createdAt,
    DateTime updatedAt,
    LeaderboardDriverInfo? driver,
    int? previousRank,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLeaderboardWithDriver.copyWith(...)` or call `instanceOfLeaderboardWithDriver.copyWith.fieldName(value)` for a single field.
class _$LeaderboardWithDriverCWProxyImpl
    implements _$LeaderboardWithDriverCWProxy {
  const _$LeaderboardWithDriverCWProxyImpl(this._value);

  final LeaderboardWithDriver _value;

  @override
  LeaderboardWithDriver id(String id) => call(id: id);

  @override
  LeaderboardWithDriver userId(String userId) => call(userId: userId);

  @override
  LeaderboardWithDriver driverId(String? driverId) => call(driverId: driverId);

  @override
  LeaderboardWithDriver merchantId(String? merchantId) =>
      call(merchantId: merchantId);

  @override
  LeaderboardWithDriver category(LeaderboardCategory category) =>
      call(category: category);

  @override
  LeaderboardWithDriver period(LeaderboardPeriod period) =>
      call(period: period);

  @override
  LeaderboardWithDriver rank(int rank) => call(rank: rank);

  @override
  LeaderboardWithDriver score(int score) => call(score: score);

  @override
  LeaderboardWithDriver periodStart(DateTime periodStart) =>
      call(periodStart: periodStart);

  @override
  LeaderboardWithDriver periodEnd(DateTime periodEnd) =>
      call(periodEnd: periodEnd);

  @override
  LeaderboardWithDriver createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  LeaderboardWithDriver updatedAt(DateTime updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  LeaderboardWithDriver driver(LeaderboardDriverInfo? driver) =>
      call(driver: driver);

  @override
  LeaderboardWithDriver previousRank(int? previousRank) =>
      call(previousRank: previousRank);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardWithDriver(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardWithDriver(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardWithDriver call({
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
    Object? driver = const $CopyWithPlaceholder(),
    Object? previousRank = const $CopyWithPlaceholder(),
  }) {
    return LeaderboardWithDriver(
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
          : category as LeaderboardCategory,
      period: period == const $CopyWithPlaceholder() || period == null
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as LeaderboardPeriod,
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
      driver: driver == const $CopyWithPlaceholder()
          ? _value.driver
          // ignore: cast_nullable_to_non_nullable
          : driver as LeaderboardDriverInfo?,
      previousRank: previousRank == const $CopyWithPlaceholder()
          ? _value.previousRank
          // ignore: cast_nullable_to_non_nullable
          : previousRank as int?,
    );
  }
}

extension $LeaderboardWithDriverCopyWith on LeaderboardWithDriver {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLeaderboardWithDriver.copyWith(...)` or `instanceOfLeaderboardWithDriver.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaderboardWithDriverCWProxy get copyWith =>
      _$LeaderboardWithDriverCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardWithDriver _$LeaderboardWithDriverFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LeaderboardWithDriver', json, ($checkedConvert) {
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
  final val = LeaderboardWithDriver(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    driverId: $checkedConvert('driverId', (v) => v as String?),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
    category: $checkedConvert(
      'category',
      (v) => $enumDecode(_$LeaderboardCategoryEnumMap, v),
    ),
    period: $checkedConvert(
      'period',
      (v) => $enumDecode(_$LeaderboardPeriodEnumMap, v),
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
    driver: $checkedConvert(
      'driver',
      (v) => v == null
          ? null
          : LeaderboardDriverInfo.fromJson(v as Map<String, dynamic>),
    ),
    previousRank: $checkedConvert('previousRank', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$LeaderboardWithDriverToJson(
  LeaderboardWithDriver instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'driverId': ?instance.driverId,
  'merchantId': ?instance.merchantId,
  'category': _$LeaderboardCategoryEnumMap[instance.category]!,
  'period': _$LeaderboardPeriodEnumMap[instance.period]!,
  'rank': instance.rank,
  'score': instance.score,
  'periodStart': instance.periodStart.toIso8601String(),
  'periodEnd': instance.periodEnd.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'driver': ?instance.driver?.toJson(),
  'previousRank': ?instance.previousRank,
};

const _$LeaderboardCategoryEnumMap = {
  LeaderboardCategory.RATING: 'RATING',
  LeaderboardCategory.VOLUME: 'VOLUME',
  LeaderboardCategory.EARNINGS: 'EARNINGS',
  LeaderboardCategory.STREAK: 'STREAK',
  LeaderboardCategory.ON_TIME: 'ON-TIME',
  LeaderboardCategory.COMPLETION_RATE: 'COMPLETION-RATE',
};

const _$LeaderboardPeriodEnumMap = {
  LeaderboardPeriod.DAILY: 'DAILY',
  LeaderboardPeriod.WEEKLY: 'WEEKLY',
  LeaderboardPeriod.MONTHLY: 'MONTHLY',
  LeaderboardPeriod.QUARTERLY: 'QUARTERLY',
  LeaderboardPeriod.YEARLY: 'YEARLY',
  LeaderboardPeriod.ALL_TIME: 'ALL-TIME',
};
