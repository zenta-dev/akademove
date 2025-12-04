// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatsQueryCWProxy {
  DashboardStatsQuery startDate(DateTime? startDate);

  DashboardStatsQuery endDate(DateTime? endDate);

  DashboardStatsQuery period(DashboardStatsQueryPeriodEnum? period);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsQuery call({
    DateTime? startDate,
    DateTime? endDate,
    DashboardStatsQueryPeriodEnum? period,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDashboardStatsQuery.copyWith(...)` or call `instanceOfDashboardStatsQuery.copyWith.fieldName(value)` for a single field.
class _$DashboardStatsQueryCWProxyImpl implements _$DashboardStatsQueryCWProxy {
  const _$DashboardStatsQueryCWProxyImpl(this._value);

  final DashboardStatsQuery _value;

  @override
  DashboardStatsQuery startDate(DateTime? startDate) =>
      call(startDate: startDate);

  @override
  DashboardStatsQuery endDate(DateTime? endDate) => call(endDate: endDate);

  @override
  DashboardStatsQuery period(DashboardStatsQueryPeriodEnum? period) =>
      call(period: period);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsQuery call({
    Object? startDate = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
    Object? period = const $CopyWithPlaceholder(),
  }) {
    return DashboardStatsQuery(
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime?,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime?,
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as DashboardStatsQueryPeriodEnum?,
    );
  }
}

extension $DashboardStatsQueryCopyWith on DashboardStatsQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDashboardStatsQuery.copyWith(...)` or `instanceOfDashboardStatsQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatsQueryCWProxy get copyWith =>
      _$DashboardStatsQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsQuery _$DashboardStatsQueryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DashboardStatsQuery', json, ($checkedConvert) {
      final val = DashboardStatsQuery(
        startDate: $checkedConvert(
          'startDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        endDate: $checkedConvert(
          'endDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        period: $checkedConvert(
          'period',
          (v) => $enumDecodeNullable(_$DashboardStatsQueryPeriodEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DashboardStatsQueryToJson(
  DashboardStatsQuery instance,
) => <String, dynamic>{
  'startDate': ?instance.startDate?.toIso8601String(),
  'endDate': ?instance.endDate?.toIso8601String(),
  'period': ?_$DashboardStatsQueryPeriodEnumEnumMap[instance.period],
};

const _$DashboardStatsQueryPeriodEnumEnumMap = {
  DashboardStatsQueryPeriodEnum.today: 'today',
  DashboardStatsQueryPeriodEnum.week: 'week',
  DashboardStatsQueryPeriodEnum.month: 'month',
  DashboardStatsQueryPeriodEnum.year: 'year',
};
