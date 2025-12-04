// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_orders_by_type_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatsOrdersByTypeInnerCWProxy {
  DashboardStatsOrdersByTypeInner type(String type);

  DashboardStatsOrdersByTypeInner orders(num orders);

  DashboardStatsOrdersByTypeInner revenue(num revenue);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsOrdersByTypeInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsOrdersByTypeInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsOrdersByTypeInner call({String type, num orders, num revenue});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDashboardStatsOrdersByTypeInner.copyWith(...)` or call `instanceOfDashboardStatsOrdersByTypeInner.copyWith.fieldName(value)` for a single field.
class _$DashboardStatsOrdersByTypeInnerCWProxyImpl
    implements _$DashboardStatsOrdersByTypeInnerCWProxy {
  const _$DashboardStatsOrdersByTypeInnerCWProxyImpl(this._value);

  final DashboardStatsOrdersByTypeInner _value;

  @override
  DashboardStatsOrdersByTypeInner type(String type) => call(type: type);

  @override
  DashboardStatsOrdersByTypeInner orders(num orders) => call(orders: orders);

  @override
  DashboardStatsOrdersByTypeInner revenue(num revenue) =>
      call(revenue: revenue);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsOrdersByTypeInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsOrdersByTypeInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsOrdersByTypeInner call({
    Object? type = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
  }) {
    return DashboardStatsOrdersByTypeInner(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
      orders: orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as num,
      revenue: revenue == const $CopyWithPlaceholder() || revenue == null
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as num,
    );
  }
}

extension $DashboardStatsOrdersByTypeInnerCopyWith
    on DashboardStatsOrdersByTypeInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDashboardStatsOrdersByTypeInner.copyWith(...)` or `instanceOfDashboardStatsOrdersByTypeInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatsOrdersByTypeInnerCWProxy get copyWith =>
      _$DashboardStatsOrdersByTypeInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsOrdersByTypeInner _$DashboardStatsOrdersByTypeInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardStatsOrdersByTypeInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['type', 'orders', 'revenue']);
  final val = DashboardStatsOrdersByTypeInner(
    type: $checkedConvert('type', (v) => v as String),
    orders: $checkedConvert('orders', (v) => v as num),
    revenue: $checkedConvert('revenue', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DashboardStatsOrdersByTypeInnerToJson(
  DashboardStatsOrdersByTypeInner instance,
) => <String, dynamic>{
  'type': instance.type,
  'orders': instance.orders,
  'revenue': instance.revenue,
};
