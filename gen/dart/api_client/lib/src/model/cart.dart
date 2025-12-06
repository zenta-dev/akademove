//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/cart_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'cart.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Cart {
  /// Returns a new [Cart] instance.
  const Cart({
    required this.merchantId,
    required this.merchantName,
    required this.items,
    required this.totalItems,
    required this.subtotal,
    required this.lastUpdated,
  });
  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;

  @JsonKey(name: r'merchantName', required: true, includeIfNull: false)
  final String merchantName;

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<CartItem> items;

  // minimum: 1
  // maximum: 9007199254740991
  @JsonKey(name: r'totalItems', required: true, includeIfNull: false)
  final int totalItems;

  @JsonKey(name: r'subtotal', required: true, includeIfNull: false)
  final num subtotal;

  @JsonKey(name: r'lastUpdated', required: true, includeIfNull: false)
  final DateTime lastUpdated;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cart &&
          other.merchantId == merchantId &&
          other.merchantName == merchantName &&
          other.items == items &&
          other.totalItems == totalItems &&
          other.subtotal == subtotal &&
          other.lastUpdated == lastUpdated;

  @override
  int get hashCode =>
      merchantId.hashCode +
      merchantName.hashCode +
      items.hashCode +
      totalItems.hashCode +
      subtotal.hashCode +
      lastUpdated.hashCode;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
