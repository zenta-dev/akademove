// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_menu.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantMenuCWProxy {
  MerchantMenu id(String id);

  MerchantMenu merchantId(String merchantId);

  MerchantMenu name(String name);

  MerchantMenu image(String? image);

  MerchantMenu category(String? category);

  MerchantMenu price(num price);

  MerchantMenu stock(int stock);

  MerchantMenu createdAt(DateTime createdAt);

  MerchantMenu updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantMenu(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantMenu(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantMenu call({
    String id,
    String merchantId,
    String name,
    String? image,
    String? category,
    num price,
    int stock,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMerchantMenu.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMerchantMenu.copyWith.fieldName(...)`
class _$MerchantMenuCWProxyImpl implements _$MerchantMenuCWProxy {
  const _$MerchantMenuCWProxyImpl(this._value);

  final MerchantMenu _value;

  @override
  MerchantMenu id(String id) => this(id: id);

  @override
  MerchantMenu merchantId(String merchantId) => this(merchantId: merchantId);

  @override
  MerchantMenu name(String name) => this(name: name);

  @override
  MerchantMenu image(String? image) => this(image: image);

  @override
  MerchantMenu category(String? category) => this(category: category);

  @override
  MerchantMenu price(num price) => this(price: price);

  @override
  MerchantMenu stock(int stock) => this(stock: stock);

  @override
  MerchantMenu createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  MerchantMenu updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MerchantMenu(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MerchantMenu(...).copyWith(id: 12, name: "My name")
  /// ````
  MerchantMenu call({
    Object? id = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? stock = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return MerchantMenu(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String?,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as num,
      stock: stock == const $CopyWithPlaceholder()
          ? _value.stock
          // ignore: cast_nullable_to_non_nullable
          : stock as int,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $MerchantMenuCopyWith on MerchantMenu {
  /// Returns a callable class that can be used as follows: `instanceOfMerchantMenu.copyWith(...)` or like so:`instanceOfMerchantMenu.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantMenuCWProxy get copyWith => _$MerchantMenuCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantMenu _$MerchantMenuFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantMenu', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'merchantId',
      'name',
      'price',
      'stock',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = MerchantMenu(
    id: $checkedConvert('id', (v) => v as String),
    merchantId: $checkedConvert('merchantId', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    image: $checkedConvert('image', (v) => v as String?),
    category: $checkedConvert('category', (v) => v as String?),
    price: $checkedConvert('price', (v) => v as num),
    stock: $checkedConvert('stock', (v) => (v as num).toInt()),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$MerchantMenuToJson(MerchantMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchantId': instance.merchantId,
      'name': instance.name,
      'image': ?instance.image,
      'category': ?instance.category,
      'price': instance.price,
      'stock': instance.stock,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
