//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/cart.dart';
import 'package:api_client/src/model/cart_response_stock_warnings_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'cart_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CartResponse {
  /// Returns a new [CartResponse] instance.
  const CartResponse({required this.cart, this.stockWarnings});
  @JsonKey(name: r'cart', required: true, includeIfNull: true)
  final Cart? cart;

  @JsonKey(name: r'stockWarnings', required: false, includeIfNull: false)
  final List<CartResponseStockWarningsInner>? stockWarnings;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartResponse &&
          other.cart == cart &&
          other.stockWarnings == stockWarnings;

  @override
  int get hashCode =>
      (cart == null ? 0 : cart.hashCode) + stockWarnings.hashCode;

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
