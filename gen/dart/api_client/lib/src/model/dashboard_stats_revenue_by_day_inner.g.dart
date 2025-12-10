// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_revenue_by_day_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatsRevenueByDayInnerCWProxy {
  DashboardStatsRevenueByDayInner date(String date);

  DashboardStatsRevenueByDayInner revenue(num revenue);

  DashboardStatsRevenueByDayInner orders(num orders);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsRevenueByDayInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsRevenueByDayInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsRevenueByDayInner call({String date, num revenue, num orders});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDashboardStatsRevenueByDayInner.copyWith(...)` or call `instanceOfDashboardStatsRevenueByDayInner.copyWith.fieldName(value)` for a single field.
class _$DashboardStatsRevenueByDayInnerCWProxyImpl
    implements _$DashboardStatsRevenueByDayInnerCWProxy {
  const _$DashboardStatsRevenueByDayInnerCWProxyImpl(this._value);

  final DashboardStatsRevenueByDayInner _value;

  @override
  DashboardStatsRevenueByDayInner date(String date) => call(date: date);

  @override
  DashboardStatsRevenueByDayInner revenue(num revenue) =>
      call(revenue: revenue);

  @override
  DashboardStatsRevenueByDayInner orders(num orders) => call(orders: orders);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsRevenueByDayInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsRevenueByDayInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsRevenueByDayInner call({
    Object? date = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
  }) {
    return DashboardStatsRevenueByDayInner(
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      revenue: revenue == const $CopyWithPlaceholder() || revenue == null
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as num,
      orders: orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as num,
    );
  }
}

extension $DashboardStatsRevenueByDayInnerCopyWith
    on DashboardStatsRevenueByDayInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDashboardStatsRevenueByDayInner.copyWith(...)` or `instanceOfDashboardStatsRevenueByDayInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatsRevenueByDayInnerCWProxy get copyWith =>
      _$DashboardStatsRevenueByDayInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsRevenueByDayInner _$DashboardStatsRevenueByDayInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardStatsRevenueByDayInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['date', 'revenue', 'orders']);
  final val = DashboardStatsRevenueByDayInner(
    date: $checkedConvert('date', (v) => v as String),
    revenue: $checkedConvert('revenue', (v) => v as num),
    orders: $checkedConvert('orders', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DashboardStatsRevenueByDayInnerToJson(
  DashboardStatsRevenueByDayInner instance,
) => <String, dynamic>{
  'date': instance.date,
  'revenue': instance.revenue,
  'orders': instance.orders,
};
