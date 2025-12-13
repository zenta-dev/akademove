// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_report_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommissionReportQueryCWProxy {
  CommissionReportQuery period(CommissionReportPeriod? period);

  CommissionReportQuery startDate(DateTime? startDate);

  CommissionReportQuery endDate(DateTime? endDate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CommissionReportQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CommissionReportQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  CommissionReportQuery call({
    CommissionReportPeriod? period,
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCommissionReportQuery.copyWith(...)` or call `instanceOfCommissionReportQuery.copyWith.fieldName(value)` for a single field.
class _$CommissionReportQueryCWProxyImpl
    implements _$CommissionReportQueryCWProxy {
  const _$CommissionReportQueryCWProxyImpl(this._value);

  final CommissionReportQuery _value;

  @override
  CommissionReportQuery period(CommissionReportPeriod? period) =>
      call(period: period);

  @override
  CommissionReportQuery startDate(DateTime? startDate) =>
      call(startDate: startDate);

  @override
  CommissionReportQuery endDate(DateTime? endDate) => call(endDate: endDate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CommissionReportQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CommissionReportQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  CommissionReportQuery call({
    Object? period = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
  }) {
    return CommissionReportQuery(
      period: period == const $CopyWithPlaceholder()
          ? _value.period
          // ignore: cast_nullable_to_non_nullable
          : period as CommissionReportPeriod?,
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime?,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime?,
    );
  }
}

extension $CommissionReportQueryCopyWith on CommissionReportQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCommissionReportQuery.copyWith(...)` or `instanceOfCommissionReportQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommissionReportQueryCWProxy get copyWith =>
      _$CommissionReportQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionReportQuery _$CommissionReportQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CommissionReportQuery', json, ($checkedConvert) {
  final val = CommissionReportQuery(
    period: $checkedConvert(
      'period',
      (v) =>
          $enumDecodeNullable(_$CommissionReportPeriodEnumMap, v) ??
          CommissionReportPeriod.daily,
    ),
    startDate: $checkedConvert(
      'startDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    endDate: $checkedConvert(
      'endDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$CommissionReportQueryToJson(
  CommissionReportQuery instance,
) => <String, dynamic>{
  'period': ?_$CommissionReportPeriodEnumMap[instance.period],
  'startDate': ?instance.startDate?.toIso8601String(),
  'endDate': ?instance.endDate?.toIso8601String(),
};

const _$CommissionReportPeriodEnumMap = {
  CommissionReportPeriod.daily: 'daily',
  CommissionReportPeriod.weekly: 'weekly',
  CommissionReportPeriod.monthly: 'monthly',
};
