//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'cart_response_stock_warnings_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CartResponseStockWarningsInner {
  /// Returns a new [CartResponseStockWarningsInner] instance.
  const CartResponseStockWarningsInner({
    required this.menuId,
    required this.menuName,
    required this.requestedQuantity,
    required this.availableStock,
  });
  @JsonKey(name: r'menuId', required: true, includeIfNull: false)
  final String menuId;

  @JsonKey(name: r'menuName', required: true, includeIfNull: false)
  final String menuName;

  @JsonKey(name: r'requestedQuantity', required: true, includeIfNull: false)
  final num requestedQuantity;

  @JsonKey(name: r'availableStock', required: true, includeIfNull: false)
  final num availableStock;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartResponseStockWarningsInner &&
          other.menuId == menuId &&
          other.menuName == menuName &&
          other.requestedQuantity == requestedQuantity &&
          other.availableStock == availableStock;

  @override
  int get hashCode =>
      menuId.hashCode +
      menuName.hashCode +
      requestedQuantity.hashCode +
      availableStock.hashCode;

  factory CartResponseStockWarningsInner.fromJson(Map<String, dynamic> json) =>
      _$CartResponseStockWarningsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseStockWarningsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
