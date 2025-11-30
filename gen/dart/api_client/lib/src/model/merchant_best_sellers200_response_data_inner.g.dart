// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_best_sellers200_response_data_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantBestSellers200ResponseDataInnerCWProxy {
  MerchantBestSellers200ResponseDataInner menu(
    MerchantBestSellers200ResponseDataInnerMenu menu,
  );

  MerchantBestSellers200ResponseDataInner merchant(
    MerchantBestSellers200ResponseDataInnerMerchant merchant,
  );

  MerchantBestSellers200ResponseDataInner orderCount(num orderCount);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantBestSellers200ResponseDataInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantBestSellers200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantBestSellers200ResponseDataInner call({
    MerchantBestSellers200ResponseDataInnerMenu menu,
    MerchantBestSellers200ResponseDataInnerMerchant merchant,
    num orderCount,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantBestSellers200ResponseDataInner.copyWith(...)` or call `instanceOfMerchantBestSellers200ResponseDataInner.copyWith.fieldName(value)` for a single field.
class _$MerchantBestSellers200ResponseDataInnerCWProxyImpl
    implements _$MerchantBestSellers200ResponseDataInnerCWProxy {
  const _$MerchantBestSellers200ResponseDataInnerCWProxyImpl(this._value);

  final MerchantBestSellers200ResponseDataInner _value;

  @override
  MerchantBestSellers200ResponseDataInner menu(
    MerchantBestSellers200ResponseDataInnerMenu menu,
  ) => call(menu: menu);

  @override
  MerchantBestSellers200ResponseDataInner merchant(
    MerchantBestSellers200ResponseDataInnerMerchant merchant,
  ) => call(merchant: merchant);

  @override
  MerchantBestSellers200ResponseDataInner orderCount(num orderCount) =>
      call(orderCount: orderCount);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantBestSellers200ResponseDataInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantBestSellers200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantBestSellers200ResponseDataInner call({
    Object? menu = const $CopyWithPlaceholder(),
    Object? merchant = const $CopyWithPlaceholder(),
    Object? orderCount = const $CopyWithPlaceholder(),
  }) {
    return MerchantBestSellers200ResponseDataInner(
      menu: menu == const $CopyWithPlaceholder() || menu == null
          ? _value.menu
          // ignore: cast_nullable_to_non_nullable
          : menu as MerchantBestSellers200ResponseDataInnerMenu,
      merchant: merchant == const $CopyWithPlaceholder() || merchant == null
          ? _value.merchant
          // ignore: cast_nullable_to_non_nullable
          : merchant as MerchantBestSellers200ResponseDataInnerMerchant,
      orderCount:
          orderCount == const $CopyWithPlaceholder() || orderCount == null
          ? _value.orderCount
          // ignore: cast_nullable_to_non_nullable
          : orderCount as num,
    );
  }
}

extension $MerchantBestSellers200ResponseDataInnerCopyWith
    on MerchantBestSellers200ResponseDataInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantBestSellers200ResponseDataInner.copyWith(...)` or `instanceOfMerchantBestSellers200ResponseDataInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantBestSellers200ResponseDataInnerCWProxy get copyWith =>
      _$MerchantBestSellers200ResponseDataInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantBestSellers200ResponseDataInner
_$MerchantBestSellers200ResponseDataInnerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantBestSellers200ResponseDataInner', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['menu', 'merchant', 'orderCount']);
      final val = MerchantBestSellers200ResponseDataInner(
        menu: $checkedConvert(
          'menu',
          (v) => MerchantBestSellers200ResponseDataInnerMenu.fromJson(
            v as Map<String, dynamic>,
          ),
        ),
        merchant: $checkedConvert(
          'merchant',
          (v) => MerchantBestSellers200ResponseDataInnerMerchant.fromJson(
            v as Map<String, dynamic>,
          ),
        ),
        orderCount: $checkedConvert('orderCount', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$MerchantBestSellers200ResponseDataInnerToJson(
  MerchantBestSellers200ResponseDataInner instance,
) => <String, dynamic>{
  'menu': instance.menu.toJson(),
  'merchant': instance.merchant.toJson(),
  'orderCount': instance.orderCount,
};
