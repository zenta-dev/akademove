// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartItemCWProxy {
  CartItem menuId(String menuId);

  CartItem merchantId(String merchantId);

  CartItem merchantName(String merchantName);

  CartItem menuName(String menuName);

  CartItem menuImage(String? menuImage);

  CartItem unitPrice(num unitPrice);

  CartItem quantity(int quantity);

  CartItem notes(String? notes);

  CartItem stock(int? stock);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CartItem(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartItem(...).copyWith(id: 12, name: "My name")
  /// ```
  CartItem call({
    String menuId,
    String merchantId,
    String merchantName,
    String menuName,
    String? menuImage,
    num unitPrice,
    int quantity,
    String? notes,
    int? stock,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCartItem.copyWith(...)` or call `instanceOfCartItem.copyWith.fieldName(value)` for a single field.
class _$CartItemCWProxyImpl implements _$CartItemCWProxy {
  const _$CartItemCWProxyImpl(this._value);

  final CartItem _value;

  @override
  CartItem menuId(String menuId) => call(menuId: menuId);

  @override
  CartItem merchantId(String merchantId) => call(merchantId: merchantId);

  @override
  CartItem merchantName(String merchantName) =>
      call(merchantName: merchantName);

  @override
  CartItem menuName(String menuName) => call(menuName: menuName);

  @override
  CartItem menuImage(String? menuImage) => call(menuImage: menuImage);

  @override
  CartItem unitPrice(num unitPrice) => call(unitPrice: unitPrice);

  @override
  CartItem quantity(int quantity) => call(quantity: quantity);

  @override
  CartItem notes(String? notes) => call(notes: notes);

  @override
  CartItem stock(int? stock) => call(stock: stock);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CartItem(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartItem(...).copyWith(id: 12, name: "My name")
  /// ```
  CartItem call({
    Object? menuId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? merchantName = const $CopyWithPlaceholder(),
    Object? menuName = const $CopyWithPlaceholder(),
    Object? menuImage = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? stock = const $CopyWithPlaceholder(),
  }) {
    return CartItem(
      menuId: menuId == const $CopyWithPlaceholder() || menuId == null
          ? _value.menuId
          // ignore: cast_nullable_to_non_nullable
          : menuId as String,
      merchantId:
          merchantId == const $CopyWithPlaceholder() || merchantId == null
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String,
      merchantName:
          merchantName == const $CopyWithPlaceholder() || merchantName == null
          ? _value.merchantName
          // ignore: cast_nullable_to_non_nullable
          : merchantName as String,
      menuName: menuName == const $CopyWithPlaceholder() || menuName == null
          ? _value.menuName
          // ignore: cast_nullable_to_non_nullable
          : menuName as String,
      menuImage: menuImage == const $CopyWithPlaceholder()
          ? _value.menuImage
          // ignore: cast_nullable_to_non_nullable
          : menuImage as String?,
      unitPrice: unitPrice == const $CopyWithPlaceholder() || unitPrice == null
          ? _value.unitPrice
          // ignore: cast_nullable_to_non_nullable
          : unitPrice as num,
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      stock: stock == const $CopyWithPlaceholder()
          ? _value.stock
          // ignore: cast_nullable_to_non_nullable
          : stock as int?,
    );
  }
}

extension $CartItemCopyWith on CartItem {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCartItem.copyWith(...)` or `instanceOfCartItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CartItemCWProxy get copyWith => _$CartItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CartItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'menuId',
          'merchantId',
          'merchantName',
          'menuName',
          'menuImage',
          'unitPrice',
          'quantity',
          'notes',
        ],
      );
      final val = CartItem(
        menuId: $checkedConvert('menuId', (v) => v as String),
        merchantId: $checkedConvert('merchantId', (v) => v as String),
        merchantName: $checkedConvert('merchantName', (v) => v as String),
        menuName: $checkedConvert('menuName', (v) => v as String),
        menuImage: $checkedConvert('menuImage', (v) => v as String?),
        unitPrice: $checkedConvert('unitPrice', (v) => v as num),
        quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
        notes: $checkedConvert('notes', (v) => v as String?),
        stock: $checkedConvert('stock', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'menuId': instance.menuId,
  'merchantId': instance.merchantId,
  'merchantName': instance.merchantName,
  'menuName': instance.menuName,
  'menuImage': instance.menuImage,
  'unitPrice': instance.unitPrice,
  'quantity': instance.quantity,
  'notes': instance.notes,
  'stock': ?instance.stock,
};
