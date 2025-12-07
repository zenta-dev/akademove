//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_item_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderItem {
  /// Returns a new [OrderItem] instance.
  const OrderItem({
    required this.quantity,
    required this.item,
  });
  @JsonKey(name: r'quantity', required: true, includeIfNull: false)
  final num quantity;
  
  @JsonKey(name: r'item', required: true, includeIfNull: false)
  final OrderItemItem item;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderItem &&
    other.quantity == quantity &&
    other.item == item;

  @override
  int get hashCode =>
      quantity.hashCode +
      item.hashCode;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

