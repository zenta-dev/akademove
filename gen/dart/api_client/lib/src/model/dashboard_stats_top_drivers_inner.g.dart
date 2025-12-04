// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_top_drivers_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStatsTopDriversInnerCWProxy {
  DashboardStatsTopDriversInner id(String id);

  DashboardStatsTopDriversInner name(String name);

  DashboardStatsTopDriversInner earnings(num earnings);

  DashboardStatsTopDriversInner orders(num orders);

  DashboardStatsTopDriversInner rating(num rating);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsTopDriversInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsTopDriversInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsTopDriversInner call({
    String id,
    String name,
    num earnings,
    num orders,
    num rating,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDashboardStatsTopDriversInner.copyWith(...)` or call `instanceOfDashboardStatsTopDriversInner.copyWith.fieldName(value)` for a single field.
class _$DashboardStatsTopDriversInnerCWProxyImpl
    implements _$DashboardStatsTopDriversInnerCWProxy {
  const _$DashboardStatsTopDriversInnerCWProxyImpl(this._value);

  final DashboardStatsTopDriversInner _value;

  @override
  DashboardStatsTopDriversInner id(String id) => call(id: id);

  @override
  DashboardStatsTopDriversInner name(String name) => call(name: name);

  @override
  DashboardStatsTopDriversInner earnings(num earnings) =>
      call(earnings: earnings);

  @override
  DashboardStatsTopDriversInner orders(num orders) => call(orders: orders);

  @override
  DashboardStatsTopDriversInner rating(num rating) => call(rating: rating);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DashboardStatsTopDriversInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DashboardStatsTopDriversInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DashboardStatsTopDriversInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? earnings = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
  }) {
    return DashboardStatsTopDriversInner(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      earnings: earnings == const $CopyWithPlaceholder() || earnings == null
          ? _value.earnings
          // ignore: cast_nullable_to_non_nullable
          : earnings as num,
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

extension $DashboardStatsTopDriversInnerCopyWith
    on DashboardStatsTopDriversInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDashboardStatsTopDriversInner.copyWith(...)` or `instanceOfDashboardStatsTopDriversInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStatsTopDriversInnerCWProxy get copyWith =>
      _$DashboardStatsTopDriversInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsTopDriversInner _$DashboardStatsTopDriversInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DashboardStatsTopDriversInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'earnings', 'orders', 'rating'],
  );
  final val = DashboardStatsTopDriversInner(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    earnings: $checkedConvert('earnings', (v) => v as num),
    orders: $checkedConvert('orders', (v) => v as num),
    rating: $checkedConvert('rating', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DashboardStatsTopDriversInnerToJson(
  DashboardStatsTopDriversInner instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'earnings': instance.earnings,
  'orders': instance.orders,
  'rating': instance.rating,
};
