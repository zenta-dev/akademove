// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_orders_by_day_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatsOrdersByDayInnerCWProxy {
  DashboardStatsOrdersByDayInner date(String date);

  DashboardStatsOrdersByDayInner total(num total);

  DashboardStatsOrdersByDayInner completed(num completed);

  DashboardStatsOrdersByDayInner cancelled(num cancelled);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsOrdersByDayInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsOrdersByDayInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsOrdersByDayInner call({
    String date,
    num total,
    num completed,
    num cancelled,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDashboardStatsOrdersByDayInner.copyWith(...)` or call `instanceOfDashboardStatsOrdersByDayInner.copyWith.fieldName(value)` for a single field.
class _$DashboardStatsOrdersByDayInnerCWProxyImpl
    implements _$DashboardStatsOrdersByDayInnerCWProxy {
  const _$DashboardStatsOrdersByDayInnerCWProxyImpl(this._value);

  final DashboardStatsOrdersByDayInner _value;

  @override
  DashboardStatsOrdersByDayInner date(String date) => call(date: date);

  @override
  DashboardStatsOrdersByDayInner total(num total) => call(total: total);

  @override
  DashboardStatsOrdersByDayInner completed(num completed) =>
      call(completed: completed);

  @override
  DashboardStatsOrdersByDayInner cancelled(num cancelled) =>
      call(cancelled: cancelled);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsOrdersByDayInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsOrdersByDayInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsOrdersByDayInner call({
    Object? date = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? completed = const $CopyWithPlaceholder(),
    Object? cancelled = const $CopyWithPlaceholder(),
  }) {
    return DashboardStatsOrdersByDayInner(
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
      completed: completed == const $CopyWithPlaceholder() || completed == null
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as num,
      cancelled: cancelled == const $CopyWithPlaceholder() || cancelled == null
          ? _value.cancelled
          // ignore: cast_nullable_to_non_nullable
          : cancelled as num,
    );
  }
}

extension $DashboardStatsOrdersByDayInnerCopyWith
    on DashboardStatsOrdersByDayInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDashboardStatsOrdersByDayInner.copyWith(...)` or `instanceOfDashboardStatsOrdersByDayInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatsOrdersByDayInnerCWProxy get copyWith =>
      _$DashboardStatsOrdersByDayInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsOrdersByDayInner _$DashboardStatsOrdersByDayInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardStatsOrdersByDayInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['date', 'total', 'completed', 'cancelled'],
  );
  final val = DashboardStatsOrdersByDayInner(
    date: $checkedConvert('date', (v) => v as String),
    total: $checkedConvert('total', (v) => v as num),
    completed: $checkedConvert('completed', (v) => v as num),
    cancelled: $checkedConvert('cancelled', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DashboardStatsOrdersByDayInnerToJson(
  DashboardStatsOrdersByDayInner instance,
) => <String, dynamic>{
  'date': instance.date,
  'total': instance.total,
  'completed': instance.completed,
  'cancelled': instance.cancelled,
};
