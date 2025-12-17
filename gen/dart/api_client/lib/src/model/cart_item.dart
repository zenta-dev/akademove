//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'cart_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CartItem {
  /// Returns a new [CartItem] instance.
  const CartItem({
    required this.menuId,
    required this.merchantId,
    required this.merchantName,
    required this.menuName,
    required this.menuImage,
    required this.unitPrice,
    required this.quantity,
    this.notes,
    this.stock,
  });
  @JsonKey(name: r'menuId', required: true, includeIfNull: false)
  final String menuId;

  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;

  @JsonKey(name: r'merchantName', required: true, includeIfNull: false)
  final String merchantName;

  @JsonKey(name: r'menuName', required: true, includeIfNull: false)
  final String menuName;

  @JsonKey(name: r'menuImage', required: true, includeIfNull: true)
  final String? menuImage;

  @JsonKey(name: r'unitPrice', required: true, includeIfNull: false)
  final num unitPrice;

  // minimum: 1
  // maximum: 99
  @JsonKey(name: r'quantity', required: true, includeIfNull: false)
  final int quantity;

  @JsonKey(name: r'notes', required: false, includeIfNull: false)
  final String? notes;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'stock', required: false, includeIfNull: false)
  final int? stock;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          other.menuId == menuId &&
          other.merchantId == merchantId &&
          other.merchantName == merchantName &&
          other.menuName == menuName &&
          other.menuImage == menuImage &&
          other.unitPrice == unitPrice &&
          other.quantity == quantity &&
          other.notes == notes &&
          other.stock == stock;

  @override
  int get hashCode =>
      menuId.hashCode +
      merchantId.hashCode +
      merchantName.hashCode +
      menuName.hashCode +
      (menuImage == null ? 0 : menuImage.hashCode) +
      unitPrice.hashCode +
      quantity.hashCode +
      (notes == null ? 0 : notes.hashCode) +
      stock.hashCode;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
