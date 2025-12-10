// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get_analytics200_response_data_earnings_by_day_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGetAnalytics200ResponseDataEarningsByDayInnerCWProxy {
  DriverGetAnalytics200ResponseDataEarningsByDayInner date(String date);

  DriverGetAnalytics200ResponseDataEarningsByDayInner earnings(num earnings);

  DriverGetAnalytics200ResponseDataEarningsByDayInner orders(num orders);

  DriverGetAnalytics200ResponseDataEarningsByDayInner commission(
    num commission,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetAnalytics200ResponseDataEarningsByDayInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetAnalytics200ResponseDataEarningsByDayInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetAnalytics200ResponseDataEarningsByDayInner call({
    String date,
    num earnings,
    num orders,
    num commission,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverGetAnalytics200ResponseDataEarningsByDayInner.copyWith(...)` or call `instanceOfDriverGetAnalytics200ResponseDataEarningsByDayInner.copyWith.fieldName(value)` for a single field.
class _$DriverGetAnalytics200ResponseDataEarningsByDayInnerCWProxyImpl
    implements _$DriverGetAnalytics200ResponseDataEarningsByDayInnerCWProxy {
  const _$DriverGetAnalytics200ResponseDataEarningsByDayInnerCWProxyImpl(
    this._value,
  );

  final DriverGetAnalytics200ResponseDataEarningsByDayInner _value;

  @override
  DriverGetAnalytics200ResponseDataEarningsByDayInner date(String date) =>
      call(date: date);

  @override
  DriverGetAnalytics200ResponseDataEarningsByDayInner earnings(num earnings) =>
      call(earnings: earnings);

  @override
  DriverGetAnalytics200ResponseDataEarningsByDayInner orders(num orders) =>
      call(orders: orders);

  @override
  DriverGetAnalytics200ResponseDataEarningsByDayInner commission(
    num commission,
  ) => call(commission: commission);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetAnalytics200ResponseDataEarningsByDayInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetAnalytics200ResponseDataEarningsByDayInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetAnalytics200ResponseDataEarningsByDayInner call({
    Object? date = const $CopyWithPlaceholder(),
    Object? earnings = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? commission = const $CopyWithPlaceholder(),
  }) {
    return DriverGetAnalytics200ResponseDataEarningsByDayInner(
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      earnings: earnings == const $CopyWithPlaceholder() || earnings == null
          ? _value.earnings
          // ignore: cast_nullable_to_non_nullable
          : earnings as num,
      orders: orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as num,
      commission:
          commission == const $CopyWithPlaceholder() || commission == null
          ? _value.commission
          // ignore: cast_nullable_to_non_nullable
          : commission as num,
    );
  }
}

extension $DriverGetAnalytics200ResponseDataEarningsByDayInnerCopyWith
    on DriverGetAnalytics200ResponseDataEarningsByDayInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverGetAnalytics200ResponseDataEarningsByDayInner.copyWith(...)` or `instanceOfDriverGetAnalytics200ResponseDataEarningsByDayInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGetAnalytics200ResponseDataEarningsByDayInnerCWProxy get copyWith =>
      _$DriverGetAnalytics200ResponseDataEarningsByDayInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGetAnalytics200ResponseDataEarningsByDayInner
_$DriverGetAnalytics200ResponseDataEarningsByDayInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DriverGetAnalytics200ResponseDataEarningsByDayInner',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['date', 'earnings', 'orders', 'commission'],
    );
    final val = DriverGetAnalytics200ResponseDataEarningsByDayInner(
      date: $checkedConvert('date', (v) => v as String),
      earnings: $checkedConvert('earnings', (v) => v as num),
      orders: $checkedConvert('orders', (v) => v as num),
      commission: $checkedConvert('commission', (v) => v as num),
    );
    return val;
  },
);

Map<String, dynamic>
_$DriverGetAnalytics200ResponseDataEarningsByDayInnerToJson(
  DriverGetAnalytics200ResponseDataEarningsByDayInner instance,
) => <String, dynamic>{
  'date': instance.date,
  'earnings': instance.earnings,
  'orders': instance.orders,
  'commission': instance.commission,
};
