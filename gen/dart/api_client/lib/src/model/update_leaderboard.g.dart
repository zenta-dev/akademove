// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_leaderboard.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateLeaderboardCWProxy {
  UpdateLeaderboard userId(String? userId);

  UpdateLeaderboard driverId(String? driverId);

  UpdateLeaderboard merchantId(String? merchantId);

  UpdateLeaderboard category(LeaderboardCategory? category);

  UpdateLeaderboard period(LeaderboardPeriod? period);

  UpdateLeaderboard rank(int? rank);

  UpdateLeaderboard score(int? score);

  UpdateLeaderboard periodStart(DateTime? periodStart);

  UpdateLeaderboard periodEnd(DateTime? periodEnd);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateLeaderboard(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateLeaderboard(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateLeaderboard call({
    String? userId,
    String? driverId,
    String? merchantId,
    LeaderboardCategory? category,
    LeaderboardPeriod? period,
    int? rank,
    int? score,
    DateTime? periodStart,
    DateTime? periodEnd,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateLeaderboard.copyWith(...)` or call `instanceOfUpdateLeaderboard.copyWith.fieldName(value)` for a single field.
class _$UpdateLeaderboardCWProxyImpl implements _$UpdateLeaderboardCWProxy {
  const _$UpdateLeaderboardCWProxyImpl(this._value);

  final UpdateLeaderboard _value;

  @override
  UpdateLeaderboard userId(String? userId) => call(userId: userId);

  @override
  UpdateLeaderboard driverId(String? driverId) => call(driverId: driverId);

  @override
  UpdateLeaderboard merchantId(String? merchantId) =>
      call(merchantId: merchantId);

  @override
  UpdateLeaderboard category(LeaderboardCategory? category) =>
      call(category: category);

  @override
  UpdateLeaderboard period(LeaderboardPeriod? period) => call(period: period);

  @override
  UpdateLeaderboard rank(int? rank) => call(rank: rank);

  @override
  UpdateLeaderboard score(int? score) => call(score: score);

  @override
  UpdateLeaderboard periodStart(DateTime? periodStart) =>
      call(periodStart: periodStart);

  @override
  UpdateLeaderboard periodEnd(DateTime? periodEnd) =>
      call(periodEnd: periodEnd);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateLeaderboard(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateLeaderboard(...).copyWith(id: 12, name: "My name")
  /// ```
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
          : category as LeaderboardCategory?,
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as LeaderboardPeriod?,
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateLeaderboard.copyWith(...)` or `instanceOfUpdateLeaderboard.copyWith.fieldName(...)`.
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
          (v) => $enumDecodeNullable(_$LeaderboardCategoryEnumMap, v),
        ),
        period: $checkedConvert(
          'period',
          (v) => $enumDecodeNullable(_$LeaderboardPeriodEnumMap, v),
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
      'category': ?_$LeaderboardCategoryEnumMap[instance.category],
      'period': ?_$LeaderboardPeriodEnumMap[instance.period],
      'rank': ?instance.rank,
      'score': ?instance.score,
      'periodStart': ?instance.periodStart?.toIso8601String(),
      'periodEnd': ?instance.periodEnd?.toIso8601String(),
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
