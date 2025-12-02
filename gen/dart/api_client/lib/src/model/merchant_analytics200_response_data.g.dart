// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_analytics200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantAnalytics200ResponseDataCWProxy {
  MerchantAnalytics200ResponseData totalOrders(num totalOrders);

  MerchantAnalytics200ResponseData totalRevenue(num totalRevenue);

  MerchantAnalytics200ResponseData totalCommission(num totalCommission);

  MerchantAnalytics200ResponseData completedOrders(num completedOrders);

  MerchantAnalytics200ResponseData cancelledOrders(num cancelledOrders);

  MerchantAnalytics200ResponseData averageOrderValue(num averageOrderValue);

  MerchantAnalytics200ResponseData topSellingItems(
    List<MerchantAnalytics200ResponseDataTopSellingItemsInner> topSellingItems,
  );

  MerchantAnalytics200ResponseData revenueByDay(
    List<MerchantAnalytics200ResponseDataRevenueByDayInner> revenueByDay,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantAnalytics200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantAnalytics200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantAnalytics200ResponseData call({
    num totalOrders,
    num totalRevenue,
    num totalCommission,
    num completedOrders,
    num cancelledOrders,
    num averageOrderValue,
    List<MerchantAnalytics200ResponseDataTopSellingItemsInner> topSellingItems,
    List<MerchantAnalytics200ResponseDataRevenueByDayInner> revenueByDay,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantAnalytics200ResponseData.copyWith(...)` or call `instanceOfMerchantAnalytics200ResponseData.copyWith.fieldName(value)` for a single field.
class _$MerchantAnalytics200ResponseDataCWProxyImpl
    implements _$MerchantAnalytics200ResponseDataCWProxy {
  const _$MerchantAnalytics200ResponseDataCWProxyImpl(this._value);

  final MerchantAnalytics200ResponseData _value;

  @override
  MerchantAnalytics200ResponseData totalOrders(num totalOrders) =>
      call(totalOrders: totalOrders);

  @override
  MerchantAnalytics200ResponseData totalRevenue(num totalRevenue) =>
      call(totalRevenue: totalRevenue);

  @override
  MerchantAnalytics200ResponseData totalCommission(num totalCommission) =>
      call(totalCommission: totalCommission);

  @override
  MerchantAnalytics200ResponseData completedOrders(num completedOrders) =>
      call(completedOrders: completedOrders);

  @override
  MerchantAnalytics200ResponseData cancelledOrders(num cancelledOrders) =>
      call(cancelledOrders: cancelledOrders);

  @override
  MerchantAnalytics200ResponseData averageOrderValue(num averageOrderValue) =>
      call(averageOrderValue: averageOrderValue);

  @override
  MerchantAnalytics200ResponseData topSellingItems(
    List<MerchantAnalytics200ResponseDataTopSellingItemsInner> topSellingItems,
  ) => call(topSellingItems: topSellingItems);

  @override
  MerchantAnalytics200ResponseData revenueByDay(
    List<MerchantAnalytics200ResponseDataRevenueByDayInner> revenueByDay,
  ) => call(revenueByDay: revenueByDay);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantAnalytics200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantAnalytics200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantAnalytics200ResponseData call({
    Object? totalOrders = const $CopyWithPlaceholder(),
    Object? totalRevenue = const $CopyWithPlaceholder(),
    Object? totalCommission = const $CopyWithPlaceholder(),
    Object? completedOrders = const $CopyWithPlaceholder(),
    Object? cancelledOrders = const $CopyWithPlaceholder(),
    Object? averageOrderValue = const $CopyWithPlaceholder(),
    Object? topSellingItems = const $CopyWithPlaceholder(),
    Object? revenueByDay = const $CopyWithPlaceholder(),
  }) {
    return MerchantAnalytics200ResponseData(
      totalOrders:
          totalOrders == const $CopyWithPlaceholder() || totalOrders == null
          ? _value.totalOrders
          // ignore: cast_nullable_to_non_nullable
          : totalOrders as num,
      totalRevenue:
          totalRevenue == const $CopyWithPlaceholder() || totalRevenue == null
          ? _value.totalRevenue
          // ignore: cast_nullable_to_non_nullable
          : totalRevenue as num,
      totalCommission:
          totalCommission == const $CopyWithPlaceholder() ||
              totalCommission == null
          ? _value.totalCommission
          // ignore: cast_nullable_to_non_nullable
          : totalCommission as num,
      completedOrders:
          completedOrders == const $CopyWithPlaceholder() ||
              completedOrders == null
          ? _value.completedOrders
          // ignore: cast_nullable_to_non_nullable
          : completedOrders as num,
      cancelledOrders:
          cancelledOrders == const $CopyWithPlaceholder() ||
              cancelledOrders == null
          ? _value.cancelledOrders
          // ignore: cast_nullable_to_non_nullable
          : cancelledOrders as num,
      averageOrderValue:
          averageOrderValue == const $CopyWithPlaceholder() ||
              averageOrderValue == null
          ? _value.averageOrderValue
          // ignore: cast_nullable_to_non_nullable
          : averageOrderValue as num,
      topSellingItems:
          topSellingItems == const $CopyWithPlaceholder() ||
              topSellingItems == null
          ? _value.topSellingItems
          // ignore: cast_nullable_to_non_nullable
          : topSellingItems
                as List<MerchantAnalytics200ResponseDataTopSellingItemsInner>,
      revenueByDay:
          revenueByDay == const $CopyWithPlaceholder() || revenueByDay == null
          ? _value.revenueByDay
          // ignore: cast_nullable_to_non_nullable
          : revenueByDay
                as List<MerchantAnalytics200ResponseDataRevenueByDayInner>,
    );
  }
}

extension $MerchantAnalytics200ResponseDataCopyWith
    on MerchantAnalytics200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantAnalytics200ResponseData.copyWith(...)` or `instanceOfMerchantAnalytics200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantAnalytics200ResponseDataCWProxy get copyWith =>
      _$MerchantAnalytics200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantAnalytics200ResponseData _$MerchantAnalytics200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantAnalytics200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const [
      'totalOrders',
      'totalRevenue',
      'totalCommission',
      'completedOrders',
      'cancelledOrders',
      'averageOrderValue',
      'topSellingItems',
      'revenueByDay',
    ],
  );
  final val = MerchantAnalytics200ResponseData(
    totalOrders: $checkedConvert('totalOrders', (v) => v as num),
    totalRevenue: $checkedConvert('totalRevenue', (v) => v as num),
    totalCommission: $checkedConvert('totalCommission', (v) => v as num),
    completedOrders: $checkedConvert('completedOrders', (v) => v as num),
    cancelledOrders: $checkedConvert('cancelledOrders', (v) => v as num),
    averageOrderValue: $checkedConvert('averageOrderValue', (v) => v as num),
    topSellingItems: $checkedConvert(
      'topSellingItems',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                MerchantAnalytics200ResponseDataTopSellingItemsInner.fromJson(
                  e as Map<String, dynamic>,
                ),
          )
          .toList(),
    ),
    revenueByDay: $checkedConvert(
      'revenueByDay',
      (v) => (v as List<dynamic>)
          .map(
            (e) => MerchantAnalytics200ResponseDataRevenueByDayInner.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$MerchantAnalytics200ResponseDataToJson(
  MerchantAnalytics200ResponseData instance,
) => <String, dynamic>{
  'totalOrders': instance.totalOrders,
  'totalRevenue': instance.totalRevenue,
  'totalCommission': instance.totalCommission,
  'completedOrders': instance.completedOrders,
  'cancelledOrders': instance.cancelledOrders,
  'averageOrderValue': instance.averageOrderValue,
  'topSellingItems': instance.topSellingItems.map((e) => e.toJson()).toList(),
  'revenueByDay': instance.revenueByDay.map((e) => e.toJson()).toList(),
};
