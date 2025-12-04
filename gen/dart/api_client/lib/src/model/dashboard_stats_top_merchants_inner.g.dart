// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_top_merchants_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatsTopMerchantsInnerCWProxy {
  DashboardStatsTopMerchantsInner id(String id);

  DashboardStatsTopMerchantsInner name(String name);

  DashboardStatsTopMerchantsInner revenue(num revenue);

  DashboardStatsTopMerchantsInner orders(num orders);

  DashboardStatsTopMerchantsInner rating(num rating);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsTopMerchantsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsTopMerchantsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsTopMerchantsInner call({
    String id,
    String name,
    num revenue,
    num orders,
    num rating,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDashboardStatsTopMerchantsInner.copyWith(...)` or call `instanceOfDashboardStatsTopMerchantsInner.copyWith.fieldName(value)` for a single field.
class _$DashboardStatsTopMerchantsInnerCWProxyImpl
    implements _$DashboardStatsTopMerchantsInnerCWProxy {
  const _$DashboardStatsTopMerchantsInnerCWProxyImpl(this._value);

  final DashboardStatsTopMerchantsInner _value;

  @override
  DashboardStatsTopMerchantsInner id(String id) => call(id: id);

  @override
  DashboardStatsTopMerchantsInner name(String name) => call(name: name);

  @override
  DashboardStatsTopMerchantsInner revenue(num revenue) =>
      call(revenue: revenue);

  @override
  DashboardStatsTopMerchantsInner orders(num orders) => call(orders: orders);

  @override
  DashboardStatsTopMerchantsInner rating(num rating) => call(rating: rating);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsTopMerchantsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsTopMerchantsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsTopMerchantsInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
  }) {
    return DashboardStatsTopMerchantsInner(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      revenue: revenue == const $CopyWithPlaceholder() || revenue == null
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as num,
      orders: orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as num,
      rating: rating == const $CopyWithPlaceholder() || rating == null
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as num,
    );
  }
}

extension $DashboardStatsTopMerchantsInnerCopyWith
    on DashboardStatsTopMerchantsInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDashboardStatsTopMerchantsInner.copyWith(...)` or `instanceOfDashboardStatsTopMerchantsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatsTopMerchantsInnerCWProxy get copyWith =>
      _$DashboardStatsTopMerchantsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsTopMerchantsInner _$DashboardStatsTopMerchantsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardStatsTopMerchantsInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'revenue', 'orders', 'rating'],
  );
  final val = DashboardStatsTopMerchantsInner(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    revenue: $checkedConvert('revenue', (v) => v as num),
    orders: $checkedConvert('orders', (v) => v as num),
    rating: $checkedConvert('rating', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DashboardStatsTopMerchantsInnerToJson(
  DashboardStatsTopMerchantsInner instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'revenue': instance.revenue,
  'orders': instance.orders,
  'rating': instance.rating,
};
