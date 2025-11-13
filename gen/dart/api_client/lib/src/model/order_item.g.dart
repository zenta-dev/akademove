// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderItemCWProxy {
  OrderItem quantity(num quantity);

  OrderItem item(OrderItemItem item);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItem(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItem call({num quantity, OrderItemItem item});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderItem.copyWith.fieldName(...)`
class _$OrderItemCWProxyImpl implements _$OrderItemCWProxy {
  const _$OrderItemCWProxyImpl(this._value);

  final OrderItem _value;

  @override
  OrderItem quantity(num quantity) => this(quantity: quantity);

  @override
  OrderItem item(OrderItemItem item) => this(item: item);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItem(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItem call({
    Object? quantity = const $CopyWithPlaceholder(),
    Object? item = const $CopyWithPlaceholder(),
  }) {
    return OrderItem(
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as num,
      item: item == const $CopyWithPlaceholder()
          ? _value.item
          // ignore: cast_nullable_to_non_nullable
          : item as OrderItemItem,
    );
  }
}

extension $OrderItemCopyWith on OrderItem {
  /// Returns a callable class that can be used as follows: `instanceOfOrderItem.copyWith(...)` or like so:`instanceOfOrderItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderItemCWProxy get copyWith => _$OrderItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderItem', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['quantity', 'item']);
      final val = OrderItem(
        quantity: $checkedConvert('quantity', (v) => v as num),
        item: $checkedConvert(
          'item',
          (v) => OrderItemItem.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'quantity': instance.quantity,
  'item': instance.item.toJson(),
};
