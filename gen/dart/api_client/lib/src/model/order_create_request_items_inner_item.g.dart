// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_items_inner_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCreateRequestItemsInnerItemCWProxy {
  OrderCreateRequestItemsInnerItem id(String? id);

  OrderCreateRequestItemsInnerItem merchantId(String? merchantId);

  OrderCreateRequestItemsInnerItem name(String? name);

  OrderCreateRequestItemsInnerItem image(String? image);

  OrderCreateRequestItemsInnerItem category(String? category);

  OrderCreateRequestItemsInnerItem price(num? price);

  OrderCreateRequestItemsInnerItem stock(int? stock);

  OrderCreateRequestItemsInnerItem createdAt(DateTime? createdAt);

  OrderCreateRequestItemsInnerItem updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestItemsInnerItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestItemsInnerItem(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestItemsInnerItem call({
    String? id,
    String? merchantId,
    String? name,
    String? image,
    String? category,
    num? price,
    int? stock,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderCreateRequestItemsInnerItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderCreateRequestItemsInnerItem.copyWith.fieldName(...)`
class _$OrderCreateRequestItemsInnerItemCWProxyImpl
    implements _$OrderCreateRequestItemsInnerItemCWProxy {
  const _$OrderCreateRequestItemsInnerItemCWProxyImpl(this._value);

  final OrderCreateRequestItemsInnerItem _value;

  @override
  OrderCreateRequestItemsInnerItem id(String? id) => this(id: id);

  @override
  OrderCreateRequestItemsInnerItem merchantId(String? merchantId) =>
      this(merchantId: merchantId);

  @override
  OrderCreateRequestItemsInnerItem name(String? name) => this(name: name);

  @override
  OrderCreateRequestItemsInnerItem image(String? image) => this(image: image);

  @override
  OrderCreateRequestItemsInnerItem category(String? category) =>
      this(category: category);

  @override
  OrderCreateRequestItemsInnerItem price(num? price) => this(price: price);

  @override
  OrderCreateRequestItemsInnerItem stock(int? stock) => this(stock: stock);

  @override
  OrderCreateRequestItemsInnerItem createdAt(DateTime? createdAt) =>
      this(createdAt: createdAt);

  @override
  OrderCreateRequestItemsInnerItem updatedAt(DateTime? updatedAt) =>
      this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestItemsInnerItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestItemsInnerItem(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestItemsInnerItem call({
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
    return OrderCreateRequestItemsInnerItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
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
          : price as num?,
      stock: stock == const $CopyWithPlaceholder()
          ? _value.stock
          // ignore: cast_nullable_to_non_nullable
          : stock as int?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $OrderCreateRequestItemsInnerItemCopyWith
    on OrderCreateRequestItemsInnerItem {
  /// Returns a callable class that can be used as follows: `instanceOfOrderCreateRequestItemsInnerItem.copyWith(...)` or like so:`instanceOfOrderCreateRequestItemsInnerItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCreateRequestItemsInnerItemCWProxy get copyWith =>
      _$OrderCreateRequestItemsInnerItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateRequestItemsInnerItem _$OrderCreateRequestItemsInnerItemFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('OrderCreateRequestItemsInnerItem', json, ($checkedConvert) {
      final val = OrderCreateRequestItemsInnerItem(
        id: $checkedConvert('id', (v) => v as String?),
        merchantId: $checkedConvert('merchantId', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        image: $checkedConvert('image', (v) => v as String?),
        category: $checkedConvert('category', (v) => v as String?),
        price: $checkedConvert('price', (v) => v as num?),
        stock: $checkedConvert('stock', (v) => (v as num?)?.toInt()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderCreateRequestItemsInnerItemToJson(
  OrderCreateRequestItemsInnerItem instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'merchantId': ?instance.merchantId,
  'name': ?instance.name,
  'image': ?instance.image,
  'category': ?instance.category,
  'price': ?instance.price,
  'stock': ?instance.stock,
  'createdAt': ?instance.createdAt?.toIso8601String(),
  'updatedAt': ?instance.updatedAt?.toIso8601String(),
};
