// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_leaderboard.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertLeaderboardCWProxy {
  InsertLeaderboard userId(String userId);

  InsertLeaderboard driverId(String? driverId);

  InsertLeaderboard merchantId(String? merchantId);

  InsertLeaderboard category(InsertLeaderboardCategoryEnum category);

  InsertLeaderboard period(InsertLeaderboardPeriodEnum period);

  InsertLeaderboard rank(int rank);

  InsertLeaderboard score(int score);

  InsertLeaderboard periodStart(DateTime periodStart);

  InsertLeaderboard periodEnd(DateTime periodEnd);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertLeaderboard(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertLeaderboard(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertLeaderboard call({
    String userId,
    String? driverId,
    String? merchantId,
    InsertLeaderboardCategoryEnum category,
    InsertLeaderboardPeriodEnum period,
    int rank,
    int score,
    DateTime periodStart,
    DateTime periodEnd,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertLeaderboard.copyWith(...)` or call `instanceOfInsertLeaderboard.copyWith.fieldName(value)` for a single field.
class _$InsertLeaderboardCWProxyImpl implements _$InsertLeaderboardCWProxy {
  const _$InsertLeaderboardCWProxyImpl(this._value);

  final InsertLeaderboard _value;

  @override
  InsertLeaderboard userId(String userId) => call(userId: userId);

  @override
  InsertLeaderboard driverId(String? driverId) => call(driverId: driverId);

  @override
  InsertLeaderboard merchantId(String? merchantId) =>
      call(merchantId: merchantId);

  @override
  InsertLeaderboard category(InsertLeaderboardCategoryEnum category) =>
      call(category: category);

  @override
  InsertLeaderboard period(InsertLeaderboardPeriodEnum period) =>
      call(period: period);

  @override
  InsertLeaderboard rank(int rank) => call(rank: rank);

  @override
  InsertLeaderboard score(int score) => call(score: score);

  @override
  InsertLeaderboard periodStart(DateTime periodStart) =>
      call(periodStart: periodStart);

  @override
  InsertLeaderboard periodEnd(DateTime periodEnd) => call(periodEnd: periodEnd);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertLeaderboard(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertLeaderboard(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertLeaderboard call({
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
    return InsertLeaderboard(
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
          : category as InsertLeaderboardCategoryEnum,
      period: period == const $CopyWithPlaceholder() || period == null
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as InsertLeaderboardPeriodEnum,
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
    );
  }
}

extension $InsertLeaderboardCopyWith on InsertLeaderboard {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertLeaderboard.copyWith(...)` or `instanceOfInsertLeaderboard.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertLeaderboardCWProxy get copyWith =>
      _$InsertLeaderboardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertLeaderboard _$InsertLeaderboardFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertLeaderboard', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'userId',
          'category',
          'period',
          'rank',
          'score',
          'periodStart',
          'periodEnd',
        ],
      );
      final val = InsertLeaderboard(
        userId: $checkedConvert('userId', (v) => v as String),
        driverId: $checkedConvert('driverId', (v) => v as String?),
        merchantId: $checkedConvert('merchantId', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$InsertLeaderboardCategoryEnumEnumMap, v),
        ),
        period: $checkedConvert(
          'period',
          (v) => $enumDecode(_$InsertLeaderboardPeriodEnumEnumMap, v),
        ),
        rank: $checkedConvert('rank', (v) => (v as num).toInt()),
        score: $checkedConvert('score', (v) => (v as num).toInt()),
        periodStart: $checkedConvert(
          'periodStart',
          (v) => DateTime.parse(v as String),
        ),
        periodEnd: $checkedConvert(
          'periodEnd',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$InsertLeaderboardToJson(InsertLeaderboard instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'driverId': ?instance.driverId,
      'merchantId': ?instance.merchantId,
      'category': _$InsertLeaderboardCategoryEnumEnumMap[instance.category]!,
      'period': _$InsertLeaderboardPeriodEnumEnumMap[instance.period]!,
      'rank': instance.rank,
      'score': instance.score,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
    };

const _$InsertLeaderboardCategoryEnumEnumMap = {
  InsertLeaderboardCategoryEnum.rating: 'rating',
  InsertLeaderboardCategoryEnum.volume: 'volume',
  InsertLeaderboardCategoryEnum.earnings: 'earnings',
  InsertLeaderboardCategoryEnum.streak: 'streak',
  InsertLeaderboardCategoryEnum.onTime: 'on-time',
  InsertLeaderboardCategoryEnum.completionRate: 'completion-rate',
};

const _$InsertLeaderboardPeriodEnumEnumMap = {
  InsertLeaderboardPeriodEnum.daily: 'daily',
  InsertLeaderboardPeriodEnum.weekly: 'weekly',
  InsertLeaderboardPeriodEnum.monthly: 'monthly',
  InsertLeaderboardPeriodEnum.quarterly: 'quarterly',
  InsertLeaderboardPeriodEnum.yearly: 'yearly',
  InsertLeaderboardPeriodEnum.allTime: 'all-time',
};
