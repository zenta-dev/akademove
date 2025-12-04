// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get_analytics200_response_data_earnings_by_type_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerCWProxy {
  DriverGetAnalytics200ResponseDataEarningsByTypeInner type(
    DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum type,
  );

  DriverGetAnalytics200ResponseDataEarningsByTypeInner orders(num orders);

  DriverGetAnalytics200ResponseDataEarningsByTypeInner earnings(num earnings);

  DriverGetAnalytics200ResponseDataEarningsByTypeInner commission(
    num commission,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetAnalytics200ResponseDataEarningsByTypeInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetAnalytics200ResponseDataEarningsByTypeInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetAnalytics200ResponseDataEarningsByTypeInner call({
    DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum type,
    num orders,
    num earnings,
    num commission,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverGetAnalytics200ResponseDataEarningsByTypeInner.copyWith(...)` or call `instanceOfDriverGetAnalytics200ResponseDataEarningsByTypeInner.copyWith.fieldName(value)` for a single field.
class _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerCWProxyImpl
    implements _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerCWProxy {
  const _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerCWProxyImpl(
    this._value,
  );

  final DriverGetAnalytics200ResponseDataEarningsByTypeInner _value;

  @override
  DriverGetAnalytics200ResponseDataEarningsByTypeInner type(
    DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum type,
  ) => call(type: type);

  @override
  DriverGetAnalytics200ResponseDataEarningsByTypeInner orders(num orders) =>
      call(orders: orders);

  @override
  DriverGetAnalytics200ResponseDataEarningsByTypeInner earnings(num earnings) =>
      call(earnings: earnings);

  @override
  DriverGetAnalytics200ResponseDataEarningsByTypeInner commission(
    num commission,
  ) => call(commission: commission);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetAnalytics200ResponseDataEarningsByTypeInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetAnalytics200ResponseDataEarningsByTypeInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetAnalytics200ResponseDataEarningsByTypeInner call({
    Object? type = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? earnings = const $CopyWithPlaceholder(),
    Object? commission = const $CopyWithPlaceholder(),
  }) {
    return DriverGetAnalytics200ResponseDataEarningsByTypeInner(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type
                as DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum,
      orders: orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as num,
      earnings: earnings == const $CopyWithPlaceholder() || earnings == null
          ? _value.earnings
          // ignore: cast_nullable_to_non_nullable
          : earnings as num,
      commission:
          commission == const $CopyWithPlaceholder() || commission == null
          ? _value.commission
          // ignore: cast_nullable_to_non_nullable
          : commission as num,
    );
  }
}

extension $DriverGetAnalytics200ResponseDataEarningsByTypeInnerCopyWith
    on DriverGetAnalytics200ResponseDataEarningsByTypeInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverGetAnalytics200ResponseDataEarningsByTypeInner.copyWith(...)` or `instanceOfDriverGetAnalytics200ResponseDataEarningsByTypeInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerCWProxy get copyWith =>
      _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGetAnalytics200ResponseDataEarningsByTypeInner
_$DriverGetAnalytics200ResponseDataEarningsByTypeInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DriverGetAnalytics200ResponseDataEarningsByTypeInner',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['type', 'orders', 'earnings', 'commission'],
    );
    final val = DriverGetAnalytics200ResponseDataEarningsByTypeInner(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(
          _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnumEnumMap,
          v,
        ),
      ),
      orders: $checkedConvert('orders', (v) => v as num),
      earnings: $checkedConvert('earnings', (v) => v as num),
      commission: $checkedConvert('commission', (v) => v as num),
    );
    return val;
  },
);

Map<String, dynamic>
_$DriverGetAnalytics200ResponseDataEarningsByTypeInnerToJson(
  DriverGetAnalytics200ResponseDataEarningsByTypeInner instance,
) => <String, dynamic>{
  'type':
      _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnumEnumMap[instance
          .type]!,
  'orders': instance.orders,
  'earnings': instance.earnings,
  'commission': instance.commission,
};

const _$DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnumEnumMap = {
  DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum.RIDE: 'RIDE',
  DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum.DELIVERY:
      'DELIVERY',
  DriverGetAnalytics200ResponseDataEarningsByTypeInnerTypeEnum.FOOD: 'FOOD',
};
