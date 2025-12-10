//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant_menu.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'add_to_cart.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddToCart {
  /// Returns a new [AddToCart] instance.
  const AddToCart({required this.menu, this.quantity = 1, this.notes});
  @JsonKey(name: r'menu', required: true, includeIfNull: false)
  final MerchantMenu menu;

  // minimum: 1
  // maximum: 99
  @JsonKey(
    defaultValue: 1,
    name: r'quantity',
    required: false,
    includeIfNull: false,
  )
  final int? quantity;

  @JsonKey(name: r'notes', required: false, includeIfNull: false)
  final String? notes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddToCart &&
          other.menu == menu &&
          other.quantity == quantity &&
          other.notes == notes;

  @override
  int get hashCode =>
      menu.hashCode + quantity.hashCode + (notes == null ? 0 : notes.hashCode);

  factory AddToCart.fromJson(Map<String, dynamic> json) =>
      _$AddToCartFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
