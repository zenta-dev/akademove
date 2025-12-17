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

  OrderItemItem categoryId(String? categoryId);

  OrderItemItem price(num? price);

  OrderItemItem stock(int? stock);

  OrderItemItem soldStock(int? soldStock);

  OrderItemItem createdAt(DateTime? createdAt);

  OrderItemItem updatedAt(DateTime? updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderItemItem(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderItemItem(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderItemItem call({
    String? id,
    String? merchantId,
    String? name,
    String? image,
    String? category,
    String? categoryId,
    num? price,
    int? stock,
    int? soldStock,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderItemItem.copyWith(...)` or call `instanceOfOrderItemItem.copyWith.fieldName(value)` for a single field.
class _$OrderItemItemCWProxyImpl implements _$OrderItemItemCWProxy {
  const _$OrderItemItemCWProxyImpl(this._value);

  final OrderItemItem _value;

  @override
  OrderItemItem id(String? id) => call(id: id);

  @override
  OrderItemItem merchantId(String? merchantId) => call(merchantId: merchantId);

  @override
  OrderItemItem name(String? name) => call(name: name);

  @override
  OrderItemItem image(String? image) => call(image: image);

  @override
  OrderItemItem category(String? category) => call(category: category);

  @override
  OrderItemItem categoryId(String? categoryId) => call(categoryId: categoryId);

  @override
  OrderItemItem price(num? price) => call(price: price);

  @override
  OrderItemItem stock(int? stock) => call(stock: stock);

  @override
  OrderItemItem soldStock(int? soldStock) => call(soldStock: soldStock);

  @override
  OrderItemItem createdAt(DateTime? createdAt) => call(createdAt: createdAt);

  @override
  OrderItemItem updatedAt(DateTime? updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderItemItem(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderItemItem(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderItemItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? categoryId = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? stock = const $CopyWithPlaceholder(),
    Object? soldStock = const $CopyWithPlaceholder(),
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
      categoryId: categoryId == const $CopyWithPlaceholder()
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String?,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as num?,
      stock: stock == const $CopyWithPlaceholder()
          ? _value.stock
          // ignore: cast_nullable_to_non_nullable
          : stock as int?,
      soldStock: soldStock == const $CopyWithPlaceholder()
          ? _value.soldStock
          // ignore: cast_nullable_to_non_nullable
          : soldStock as int?,
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderItemItem.copyWith(...)` or `instanceOfOrderItemItem.copyWith.fieldName(...)`.
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
        categoryId: $checkedConvert('categoryId', (v) => v as String?),
        price: $checkedConvert('price', (v) => v as num?),
        stock: $checkedConvert('stock', (v) => (v as num?)?.toInt()),
        soldStock: $checkedConvert('soldStock', (v) => (v as num?)?.toInt()),
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
      'categoryId': ?instance.categoryId,
      'price': ?instance.price,
      'stock': ?instance.stock,
      'soldStock': ?instance.soldStock,
      'createdAt': ?instance.createdAt?.toIso8601String(),
      'updatedAt': ?instance.updatedAt?.toIso8601String(),
    };
