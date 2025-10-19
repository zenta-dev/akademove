// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderItemItemCWProxy {
  OrderItemItem id(String? id);

  OrderItemItem merchantId(String? merchantId);

  OrderItemItem name(String? name);

  OrderItemItem image(String? image);

  OrderItemItem category(String? category);

  OrderItemItem price(num? price);

  OrderItemItem stock(int? stock);

  OrderItemItem createdAt(DateTime? createdAt);

  OrderItemItem updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItemItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItemItem(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItemItem call({
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderItemItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderItemItem.copyWith.fieldName(...)`
class _$OrderItemItemCWProxyImpl implements _$OrderItemItemCWProxy {
  const _$OrderItemItemCWProxyImpl(this._value);

  final OrderItemItem _value;

  @override
  OrderItemItem id(String? id) => this(id: id);

  @override
  OrderItemItem merchantId(String? merchantId) => this(merchantId: merchantId);

  @override
  OrderItemItem name(String? name) => this(name: name);

  @override
  OrderItemItem image(String? image) => this(image: image);

  @override
  OrderItemItem category(String? category) => this(category: category);

  @override
  OrderItemItem price(num? price) => this(price: price);

  @override
  OrderItemItem stock(int? stock) => this(stock: stock);

  @override
  OrderItemItem createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  OrderItemItem updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItemItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItemItem(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItemItem call({
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
    return OrderItemItem(
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

extension $OrderItemItemCopyWith on OrderItemItem {
  /// Returns a callable class that can be used as follows: `instanceOfOrderItemItem.copyWith(...)` or like so:`instanceOfOrderItemItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderItemItemCWProxy get copyWith => _$OrderItemItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemItem _$OrderItemItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderItemItem', json, ($checkedConvert) {
      final val = OrderItemItem(
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

Map<String, dynamic> _$OrderItemItemToJson(OrderItemItem instance) =>
    <String, dynamic>{
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
