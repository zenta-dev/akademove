// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_analytics200_response_data_top_selling_items_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantAnalytics200ResponseDataTopSellingItemsInnerCWProxy {
  MerchantAnalytics200ResponseDataTopSellingItemsInner menuId(String menuId);

  MerchantAnalytics200ResponseDataTopSellingItemsInner menuName(String menuName);

  MerchantAnalytics200ResponseDataTopSellingItemsInner menuImage(String? menuImage);

  MerchantAnalytics200ResponseDataTopSellingItemsInner totalOrders(num totalOrders);

  MerchantAnalytics200ResponseDataTopSellingItemsInner totalRevenue(num totalRevenue);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantAnalytics200ResponseDataTopSellingItemsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantAnalytics200ResponseDataTopSellingItemsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantAnalytics200ResponseDataTopSellingItemsInner call({
    String menuId,
    String menuName,
    String? menuImage,
    num totalOrders,
    num totalRevenue,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantAnalytics200ResponseDataTopSellingItemsInner.copyWith(...)` or call `instanceOfMerchantAnalytics200ResponseDataTopSellingItemsInner.copyWith.fieldName(value)` for a single field.
class _$MerchantAnalytics200ResponseDataTopSellingItemsInnerCWProxyImpl
    implements _$MerchantAnalytics200ResponseDataTopSellingItemsInnerCWProxy {
  const _$MerchantAnalytics200ResponseDataTopSellingItemsInnerCWProxyImpl(this._value);

  final MerchantAnalytics200ResponseDataTopSellingItemsInner _value;

  @override
  MerchantAnalytics200ResponseDataTopSellingItemsInner menuId(String menuId) => call(menuId: menuId);

  @override
  MerchantAnalytics200ResponseDataTopSellingItemsInner menuName(String menuName) => call(menuName: menuName);

  @override
  MerchantAnalytics200ResponseDataTopSellingItemsInner menuImage(String? menuImage) => call(menuImage: menuImage);

  @override
  MerchantAnalytics200ResponseDataTopSellingItemsInner totalOrders(num totalOrders) => call(totalOrders: totalOrders);

  @override
  MerchantAnalytics200ResponseDataTopSellingItemsInner totalRevenue(num totalRevenue) =>
      call(totalRevenue: totalRevenue);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantAnalytics200ResponseDataTopSellingItemsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantAnalytics200ResponseDataTopSellingItemsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantAnalytics200ResponseDataTopSellingItemsInner call({
    Object? menuId = const $CopyWithPlaceholder(),
    Object? menuName = const $CopyWithPlaceholder(),
    Object? menuImage = const $CopyWithPlaceholder(),
    Object? totalOrders = const $CopyWithPlaceholder(),
    Object? totalRevenue = const $CopyWithPlaceholder(),
  }) {
    return MerchantAnalytics200ResponseDataTopSellingItemsInner(
      menuId: menuId == const $CopyWithPlaceholder() || menuId == null
          ? _value.menuId
          // ignore: cast_nullable_to_non_nullable
          : menuId as String,
      menuName: menuName == const $CopyWithPlaceholder() || menuName == null
          ? _value.menuName
          // ignore: cast_nullable_to_non_nullable
          : menuName as String,
      menuImage: menuImage == const $CopyWithPlaceholder()
          ? _value.menuImage
          // ignore: cast_nullable_to_non_nullable
          : menuImage as String?,
      totalOrders: totalOrders == const $CopyWithPlaceholder() || totalOrders == null
          ? _value.totalOrders
          // ignore: cast_nullable_to_non_nullable
          : totalOrders as num,
      totalRevenue: totalRevenue == const $CopyWithPlaceholder() || totalRevenue == null
          ? _value.totalRevenue
          // ignore: cast_nullable_to_non_nullable
          : totalRevenue as num,
    );
  }
}

extension $MerchantAnalytics200ResponseDataTopSellingItemsInnerCopyWith
    on MerchantAnalytics200ResponseDataTopSellingItemsInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantAnalytics200ResponseDataTopSellingItemsInner.copyWith(...)` or `instanceOfMerchantAnalytics200ResponseDataTopSellingItemsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantAnalytics200ResponseDataTopSellingItemsInnerCWProxy get copyWith =>
      _$MerchantAnalytics200ResponseDataTopSellingItemsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantAnalytics200ResponseDataTopSellingItemsInner _$MerchantAnalytics200ResponseDataTopSellingItemsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantAnalytics200ResponseDataTopSellingItemsInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['menuId', 'menuName', 'totalOrders', 'totalRevenue']);
  final val = MerchantAnalytics200ResponseDataTopSellingItemsInner(
    menuId: $checkedConvert('menuId', (v) => v as String),
    menuName: $checkedConvert('menuName', (v) => v as String),
    menuImage: $checkedConvert('menuImage', (v) => v as String?),
    totalOrders: $checkedConvert('totalOrders', (v) => v as num),
    totalRevenue: $checkedConvert('totalRevenue', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$MerchantAnalytics200ResponseDataTopSellingItemsInnerToJson(
  MerchantAnalytics200ResponseDataTopSellingItemsInner instance,
) => <String, dynamic>{
  'menuId': instance.menuId,
  'menuName': instance.menuName,
  'menuImage': ?instance.menuImage,
  'totalOrders': instance.totalOrders,
  'totalRevenue': instance.totalRevenue,
};
