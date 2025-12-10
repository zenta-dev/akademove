// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartCWProxy {
  Cart merchantId(String merchantId);

  Cart merchantName(String merchantName);

  Cart items(List<CartItem> items);

  Cart totalItems(int totalItems);

  Cart subtotal(num subtotal);

  Cart lastUpdated(DateTime? lastUpdated);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Cart(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Cart(...).copyWith(id: 12, name: "My name")
  /// ```
  Cart call({
    String merchantId,
    String merchantName,
    List<CartItem> items,
    int totalItems,
    num subtotal,
    DateTime? lastUpdated,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCart.copyWith(...)` or call `instanceOfCart.copyWith.fieldName(value)` for a single field.
class _$CartCWProxyImpl implements _$CartCWProxy {
  const _$CartCWProxyImpl(this._value);

  final Cart _value;

  @override
  Cart merchantId(String merchantId) => call(merchantId: merchantId);

  @override
  Cart merchantName(String merchantName) => call(merchantName: merchantName);

  @override
  Cart items(List<CartItem> items) => call(items: items);

  @override
  Cart totalItems(int totalItems) => call(totalItems: totalItems);

  @override
  Cart subtotal(num subtotal) => call(subtotal: subtotal);

  @override
  Cart lastUpdated(DateTime? lastUpdated) => call(lastUpdated: lastUpdated);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Cart(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Cart(...).copyWith(id: 12, name: "My name")
  /// ```
  Cart call({
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? merchantName = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? totalItems = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? lastUpdated = const $CopyWithPlaceholder(),
  }) {
    return Cart(
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
      items: items == const $CopyWithPlaceholder() || items == null
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CartItem>,
      totalItems:
          totalItems == const $CopyWithPlaceholder() || totalItems == null
          ? _value.totalItems
          // ignore: cast_nullable_to_non_nullable
          : totalItems as int,
      subtotal: subtotal == const $CopyWithPlaceholder() || subtotal == null
          ? _value.subtotal
          // ignore: cast_nullable_to_non_nullable
          : subtotal as num,
      lastUpdated: lastUpdated == const $CopyWithPlaceholder()
          ? _value.lastUpdated
          // ignore: cast_nullable_to_non_nullable
          : lastUpdated as DateTime?,
    );
  }
}

extension $CartCopyWith on Cart {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCart.copyWith(...)` or `instanceOfCart.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CartCWProxy get copyWith => _$CartCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Cart', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'merchantId',
          'merchantName',
          'items',
          'totalItems',
          'subtotal',
          'lastUpdated',
        ],
      );
      final val = Cart(
        merchantId: $checkedConvert('merchantId', (v) => v as String),
        merchantName: $checkedConvert('merchantName', (v) => v as String),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        totalItems: $checkedConvert('totalItems', (v) => (v as num).toInt()),
        subtotal: $checkedConvert('subtotal', (v) => v as num),
        lastUpdated: $checkedConvert(
          'lastUpdated',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
  'merchantId': instance.merchantId,
  'merchantName': instance.merchantName,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'totalItems': instance.totalItems,
  'subtotal': instance.subtotal,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
};
