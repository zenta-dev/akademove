// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_analytics200_response_data_revenue_by_day_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantAnalytics200ResponseDataRevenueByDayInnerCWProxy {
  MerchantAnalytics200ResponseDataRevenueByDayInner date(String date);

  MerchantAnalytics200ResponseDataRevenueByDayInner revenue(num revenue);

  MerchantAnalytics200ResponseDataRevenueByDayInner orders(num orders);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantAnalytics200ResponseDataRevenueByDayInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantAnalytics200ResponseDataRevenueByDayInner(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantAnalytics200ResponseDataRevenueByDayInner call({
    String date,
    num revenue,
    num orders,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantAnalytics200ResponseDataRevenueByDayInner.copyWith(...)` or call `instanceOfMerchantAnalytics200ResponseDataRevenueByDayInner.copyWith.fieldName(value)` for a single field.
class _$MerchantAnalytics200ResponseDataRevenueByDayInnerCWProxyImpl
    implements _$MerchantAnalytics200ResponseDataRevenueByDayInnerCWProxy {
  const _$MerchantAnalytics200ResponseDataRevenueByDayInnerCWProxyImpl(
    this._value,
  );

  final MerchantAnalytics200ResponseDataRevenueByDayInner _value;

  @override
  MerchantAnalytics200ResponseDataRevenueByDayInner date(String date) =>
      call(date: date);

  @override
  MerchantAnalytics200ResponseDataRevenueByDayInner revenue(num revenue) =>
      call(revenue: revenue);

  @override
  MerchantAnalytics200ResponseDataRevenueByDayInner orders(num orders) =>
      call(orders: orders);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantAnalytics200ResponseDataRevenueByDayInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantAnalytics200ResponseDataRevenueByDayInner(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantAnalytics200ResponseDataRevenueByDayInner call({
    Object? date = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
  }) {
    return MerchantAnalytics200ResponseDataRevenueByDayInner(
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

extension $MerchantAnalytics200ResponseDataRevenueByDayInnerCopyWith
    on MerchantAnalytics200ResponseDataRevenueByDayInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantAnalytics200ResponseDataRevenueByDayInner.copyWith(...)` or `instanceOfMerchantAnalytics200ResponseDataRevenueByDayInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantAnalytics200ResponseDataRevenueByDayInnerCWProxy get copyWith =>
      _$MerchantAnalytics200ResponseDataRevenueByDayInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantAnalytics200ResponseDataRevenueByDayInner
_$MerchantAnalytics200ResponseDataRevenueByDayInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantAnalytics200ResponseDataRevenueByDayInner', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['date', 'revenue', 'orders']);
  final val = MerchantAnalytics200ResponseDataRevenueByDayInner(
    date: $checkedConvert('date', (v) => v as String),
    revenue: $checkedConvert('revenue', (v) => v as num),
    orders: $checkedConvert('orders', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$MerchantAnalytics200ResponseDataRevenueByDayInnerToJson(
  MerchantAnalytics200ResponseDataRevenueByDayInner instance,
) => <String, dynamic>{
  'date': instance.date,
  'revenue': instance.revenue,
  'orders': instance.orders,
};
