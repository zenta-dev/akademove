// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderItemCWProxy {
  OrderItem id(String id);

  OrderItem itemId(String itemId);

  OrderItem total(num total);

  OrderItem item(OrderItemItem item);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItem(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItem call({String id, String itemId, num total, OrderItemItem item});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderItem.copyWith.fieldName(...)`
class _$OrderItemCWProxyImpl implements _$OrderItemCWProxy {
  const _$OrderItemCWProxyImpl(this._value);

  final OrderItem _value;

  @override
  OrderItem id(String id) => this(id: id);

  @override
  OrderItem itemId(String itemId) => this(itemId: itemId);

  @override
  OrderItem total(num total) => this(total: total);

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
    Object? id = const $CopyWithPlaceholder(),
    Object? itemId = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? item = const $CopyWithPlaceholder(),
  }) {
    return OrderItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      itemId: itemId == const $CopyWithPlaceholder()
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as num,
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
      $checkKeys(json, requiredKeys: const ['id', 'itemId', 'total', 'item']);
      final val = OrderItem(
        id: $checkedConvert('id', (v) => v as String),
        itemId: $checkedConvert('itemId', (v) => v as String),
        total: $checkedConvert('total', (v) => v as num),
        item: $checkedConvert(
          'item',
          (v) => OrderItemItem.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'id': instance.id,
  'itemId': instance.itemId,
  'total': instance.total,
  'item': instance.item.toJson(),
};
