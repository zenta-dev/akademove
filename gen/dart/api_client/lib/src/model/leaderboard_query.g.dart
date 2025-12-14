// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaderboardQueryCWProxy {
  LeaderboardQuery category(LeaderboardCategory? category);

  LeaderboardQuery period(LeaderboardPeriod? period);

  LeaderboardQuery limit(int? limit);

  LeaderboardQuery cursor(String? cursor);

  LeaderboardQuery page(int? page);

  LeaderboardQuery sortBy(String? sortBy);

  LeaderboardQuery order(LeaderboardQueryOrderEnum? order);

  LeaderboardQuery includeDriver(bool? includeDriver);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardQuery call({
    LeaderboardCategory? category,
    LeaderboardPeriod? period,
    int? limit,
    String? cursor,
    int? page,
    String? sortBy,
    LeaderboardQueryOrderEnum? order,
    bool? includeDriver,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLeaderboardQuery.copyWith(...)` or call `instanceOfLeaderboardQuery.copyWith.fieldName(value)` for a single field.
class _$LeaderboardQueryCWProxyImpl implements _$LeaderboardQueryCWProxy {
  const _$LeaderboardQueryCWProxyImpl(this._value);

  final LeaderboardQuery _value;

  @override
  LeaderboardQuery category(LeaderboardCategory? category) =>
      call(category: category);

  @override
  LeaderboardQuery period(LeaderboardPeriod? period) => call(period: period);

  @override
  LeaderboardQuery limit(int? limit) => call(limit: limit);

  @override
  LeaderboardQuery cursor(String? cursor) => call(cursor: cursor);

  @override
  LeaderboardQuery page(int? page) => call(page: page);

  @override
  LeaderboardQuery sortBy(String? sortBy) => call(sortBy: sortBy);

  @override
  LeaderboardQuery order(LeaderboardQueryOrderEnum? order) =>
      call(order: order);

  @override
  LeaderboardQuery includeDriver(bool? includeDriver) =>
      call(includeDriver: includeDriver);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LeaderboardQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LeaderboardQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  LeaderboardQuery call({
    Object? category = const $CopyWithPlaceholder(),
    Object? period = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? cursor = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? sortBy = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
    Object? includeDriver = const $CopyWithPlaceholder(),
  }) {
    return LeaderboardQuery(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as LeaderboardCategory?,
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as LeaderboardPeriod?,
      limit: limit == const $CopyWithPlaceholder()
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as int?,
      cursor: cursor == const $CopyWithPlaceholder()
          ? _value.cursor
          // ignore: cast_nullable_to_non_nullable
          : cursor as String?,
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int?,
      sortBy: sortBy == const $CopyWithPlaceholder()
          ? _value.sortBy
          // ignore: cast_nullable_to_non_nullable
          : sortBy as String?,
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as LeaderboardQueryOrderEnum?,
      includeDriver: includeDriver == const $CopyWithPlaceholder()
          ? _value.includeDriver
          // ignore: cast_nullable_to_non_nullable
          : includeDriver as bool?,
    );
  }
}

extension $LeaderboardQueryCopyWith on LeaderboardQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLeaderboardQuery.copyWith(...)` or `instanceOfLeaderboardQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaderboardQueryCWProxy get copyWith => _$LeaderboardQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardQuery _$LeaderboardQueryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LeaderboardQuery', json, ($checkedConvert) {
      final val = LeaderboardQuery(
        category: $checkedConvert(
          'category',
          (v) => $enumDecodeNullable(_$LeaderboardCategoryEnumMap, v),
        ),
        period: $checkedConvert(
          'period',
          (v) => $enumDecodeNullable(_$LeaderboardPeriodEnumMap, v),
        ),
        limit: $checkedConvert('limit', (v) => (v as num?)?.toInt()),
        cursor: $checkedConvert('cursor', (v) => v as String?),
        page: $checkedConvert('page', (v) => (v as num?)?.toInt()),
        sortBy: $checkedConvert('sortBy', (v) => v as String?),
        order: $checkedConvert(
          'order',
          (v) => $enumDecodeNullable(_$LeaderboardQueryOrderEnumEnumMap, v),
        ),
        includeDriver: $checkedConvert('includeDriver', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$LeaderboardQueryToJson(LeaderboardQuery instance) =>
    <String, dynamic>{
      'category': ?_$LeaderboardCategoryEnumMap[instance.category],
      'period': ?_$LeaderboardPeriodEnumMap[instance.period],
      'limit': ?instance.limit,
      'cursor': ?instance.cursor,
      'page': ?instance.page,
      'sortBy': ?instance.sortBy,
      'order': ?_$LeaderboardQueryOrderEnumEnumMap[instance.order],
      'includeDriver': ?instance.includeDriver,
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

const _$LeaderboardQueryOrderEnumEnumMap = {
  LeaderboardQueryOrderEnum.asc: 'asc',
  LeaderboardQueryOrderEnum.desc: 'desc',
};
