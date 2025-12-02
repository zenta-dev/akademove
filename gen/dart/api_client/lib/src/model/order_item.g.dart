// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderItemCWProxy {
  OrderItem quantity(num quantity);

  OrderItem item(OrderItemItem item);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderItem(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderItem(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderItem call({num quantity, OrderItemItem item});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderItem.copyWith(...)` or call `instanceOfOrderItem.copyWith.fieldName(value)` for a single field.
class _$OrderItemCWProxyImpl implements _$OrderItemCWProxy {
  const _$OrderItemCWProxyImpl(this._value);

  final OrderItem _value;

  @override
  OrderItem quantity(num quantity) => call(quantity: quantity);

  @override
  OrderItem item(OrderItemItem item) => call(item: item);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderItem(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderItem(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderItem call({Object? quantity = const $CopyWithPlaceholder(), Object? item = const $CopyWithPlaceholder()}) {
    return OrderItem(
      quantity: quantity == const $CopyWithPlaceholder() || quantity == null
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as num,
      item: item == const $CopyWithPlaceholder() || item == null
          ? _value.item
          // ignore: cast_nullable_to_non_nullable
          : item as OrderItemItem,
    );
  }
}

extension $OrderItemCopyWith on OrderItem {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderItem.copyWith(...)` or `instanceOfOrderItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderItemCWProxy get copyWith => _$OrderItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => $checkedCreate('OrderItem', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['quantity', 'item']);
  final val = OrderItem(
    quantity: $checkedConvert('quantity', (v) => v as num),
    item: $checkedConvert('item', (v) => OrderItemItem.fromJson(v as Map<String, dynamic>)),
  );
  return val;
});

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'quantity': instance.quantity,
  'item': instance.item.toJson(),
};
