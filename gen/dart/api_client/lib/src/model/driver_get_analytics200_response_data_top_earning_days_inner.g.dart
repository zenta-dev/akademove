// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get_analytics200_response_data_top_earning_days_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGetAnalytics200ResponseDataTopEarningDaysInnerCWProxy {
  DriverGetAnalytics200ResponseDataTopEarningDaysInner date(String? date);

  DriverGetAnalytics200ResponseDataTopEarningDaysInner earnings(num earnings);

  DriverGetAnalytics200ResponseDataTopEarningDaysInner orders(num orders);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetAnalytics200ResponseDataTopEarningDaysInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetAnalytics200ResponseDataTopEarningDaysInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetAnalytics200ResponseDataTopEarningDaysInner call({
    String? date,
    num earnings,
    num orders,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverGetAnalytics200ResponseDataTopEarningDaysInner.copyWith(...)` or call `instanceOfDriverGetAnalytics200ResponseDataTopEarningDaysInner.copyWith.fieldName(value)` for a single field.
class _$DriverGetAnalytics200ResponseDataTopEarningDaysInnerCWProxyImpl
    implements _$DriverGetAnalytics200ResponseDataTopEarningDaysInnerCWProxy {
  const _$DriverGetAnalytics200ResponseDataTopEarningDaysInnerCWProxyImpl(
    this._value,
  );

  final DriverGetAnalytics200ResponseDataTopEarningDaysInner _value;

  @override
  DriverGetAnalytics200ResponseDataTopEarningDaysInner date(String? date) =>
      call(date: date);

  @override
  DriverGetAnalytics200ResponseDataTopEarningDaysInner earnings(num earnings) =>
      call(earnings: earnings);

  @override
  DriverGetAnalytics200ResponseDataTopEarningDaysInner orders(num orders) =>
      call(orders: orders);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetAnalytics200ResponseDataTopEarningDaysInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetAnalytics200ResponseDataTopEarningDaysInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetAnalytics200ResponseDataTopEarningDaysInner call({
    Object? date = const $CopyWithPlaceholder(),
    Object? earnings = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
  }) {
    return DriverGetAnalytics200ResponseDataTopEarningDaysInner(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String?,
      earnings: earnings == const $CopyWithPlaceholder() || earnings == null
          ? _value.earnings
          // ignore: cast_nullable_to_non_nullable
          : earnings as num,
      orders: orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as num,
    );
  }
}

extension $DriverGetAnalytics200ResponseDataTopEarningDaysInnerCopyWith
    on DriverGetAnalytics200ResponseDataTopEarningDaysInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverGetAnalytics200ResponseDataTopEarningDaysInner.copyWith(...)` or `instanceOfDriverGetAnalytics200ResponseDataTopEarningDaysInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGetAnalytics200ResponseDataTopEarningDaysInnerCWProxy get copyWith =>
      _$DriverGetAnalytics200ResponseDataTopEarningDaysInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGetAnalytics200ResponseDataTopEarningDaysInner
_$DriverGetAnalytics200ResponseDataTopEarningDaysInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DriverGetAnalytics200ResponseDataTopEarningDaysInner',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['date', 'earnings', 'orders']);
    final val = DriverGetAnalytics200ResponseDataTopEarningDaysInner(
      date: $checkedConvert('date', (v) => v as String?),
      earnings: $checkedConvert('earnings', (v) => v as num),
      orders: $checkedConvert('orders', (v) => v as num),
    );
    return val;
  },
);

Map<String, dynamic>
_$DriverGetAnalytics200ResponseDataTopEarningDaysInnerToJson(
  DriverGetAnalytics200ResponseDataTopEarningDaysInner instance,
) => <String, dynamic>{
  'date': instance.date,
  'earnings': instance.earnings,
  'orders': instance.orders,
};
