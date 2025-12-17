//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'add_to_cart_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddToCartRequest {
  /// Returns a new [AddToCartRequest] instance.
  const AddToCartRequest({
    required this.menuId,
    this.quantity = 1,
    this.notes,
    this.replaceIfConflict = false,
  });
  @JsonKey(name: r'menuId', required: true, includeIfNull: false)
  final String menuId;

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

  @JsonKey(
    defaultValue: false,
    name: r'replaceIfConflict',
    required: false,
    includeIfNull: false,
  )
  final bool? replaceIfConflict;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddToCartRequest &&
          other.menuId == menuId &&
          other.quantity == quantity &&
          other.notes == notes &&
          other.replaceIfConflict == replaceIfConflict;

  @override
  int get hashCode =>
      menuId.hashCode +
      quantity.hashCode +
      (notes == null ? 0 : notes.hashCode) +
      replaceIfConflict.hashCode;

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
