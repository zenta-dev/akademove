// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderItemCWProxy {
  OrderItem total(num total);

  OrderItem item(OrderItemItem item);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItem(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItem call({num total, OrderItemItem item});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderItem.copyWith.fieldName(...)`
class _$OrderItemCWProxyImpl implements _$OrderItemCWProxy {
  const _$OrderItemCWProxyImpl(this._value);

  final OrderItem _value;

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
    Object? total = const $CopyWithPlaceholder(),
    Object? item = const $CopyWithPlaceholder(),
  }) {
    return OrderItem(
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
      $checkKeys(json, requiredKeys: const ['total', 'item']);
      final val = OrderItem(
        total: $checkedConvert('total', (v) => v as num),
        item: $checkedConvert(
          'item',
          (v) => OrderItemItem.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'total': instance.total,
  'item': instance.item.toJson(),
};
