// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_items_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCreateRequestItemsInnerCWProxy {
  OrderCreateRequestItemsInner id(String id);

  OrderCreateRequestItemsInner itemId(String itemId);

  OrderCreateRequestItemsInner total(num total);

  OrderCreateRequestItemsInner item(OrderCreateRequestItemsInnerItem item);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestItemsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestItemsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestItemsInner call({
    String id,
    String itemId,
    num total,
    OrderCreateRequestItemsInnerItem item,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderCreateRequestItemsInner.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderCreateRequestItemsInner.copyWith.fieldName(...)`
class _$OrderCreateRequestItemsInnerCWProxyImpl
    implements _$OrderCreateRequestItemsInnerCWProxy {
  const _$OrderCreateRequestItemsInnerCWProxyImpl(this._value);

  final OrderCreateRequestItemsInner _value;

  @override
  OrderCreateRequestItemsInner id(String id) => this(id: id);

  @override
  OrderCreateRequestItemsInner itemId(String itemId) => this(itemId: itemId);

  @override
  OrderCreateRequestItemsInner total(num total) => this(total: total);

  @override
  OrderCreateRequestItemsInner item(OrderCreateRequestItemsInnerItem item) =>
      this(item: item);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestItemsInner(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestItemsInner(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestItemsInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? itemId = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? item = const $CopyWithPlaceholder(),
  }) {
    return OrderCreateRequestItemsInner(
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
          : item as OrderCreateRequestItemsInnerItem,
    );
  }
}

extension $OrderCreateRequestItemsInnerCopyWith
    on OrderCreateRequestItemsInner {
  /// Returns a callable class that can be used as follows: `instanceOfOrderCreateRequestItemsInner.copyWith(...)` or like so:`instanceOfOrderCreateRequestItemsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCreateRequestItemsInnerCWProxy get copyWith =>
      _$OrderCreateRequestItemsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateRequestItemsInner _$OrderCreateRequestItemsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderCreateRequestItemsInner', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'itemId', 'total', 'item']);
  final val = OrderCreateRequestItemsInner(
    id: $checkedConvert('id', (v) => v as String),
    itemId: $checkedConvert('itemId', (v) => v as String),
    total: $checkedConvert('total', (v) => v as num),
    item: $checkedConvert(
      'item',
      (v) =>
          OrderCreateRequestItemsInnerItem.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderCreateRequestItemsInnerToJson(
  OrderCreateRequestItemsInner instance,
) => <String, dynamic>{
  'id': instance.id,
  'itemId': instance.itemId,
  'total': instance.total,
  'item': instance.item.toJson(),
};
