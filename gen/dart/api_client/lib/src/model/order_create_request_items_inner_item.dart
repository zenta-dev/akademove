//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_create_request_items_inner_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCreateRequestItemsInnerItem {
  /// Returns a new [OrderCreateRequestItemsInnerItem] instance.
  OrderCreateRequestItemsInnerItem({
    this.id,

    this.merchantId,

    this.name,

    this.image,

    this.category,

    this.price,

    this.stock,

    this.createdAt,

    this.updatedAt,
  });

  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final String? id;

  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final String? category;

  // minimum: 0
  @JsonKey(name: r'price', required: false, includeIfNull: false)
  final num? price;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'stock', required: false, includeIfNull: false)
  final int? stock;

  @JsonKey(name: r'createdAt', required: false, includeIfNull: false)
  final DateTime? createdAt;

  @JsonKey(name: r'updatedAt', required: false, includeIfNull: false)
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderCreateRequestItemsInnerItem &&
          other.id == id &&
          other.merchantId == merchantId &&
          other.name == name &&
          other.image == image &&
          other.category == category &&
          other.price == price &&
          other.stock == stock &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      merchantId.hashCode +
      name.hashCode +
      image.hashCode +
      category.hashCode +
      price.hashCode +
      stock.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory OrderCreateRequestItemsInnerItem.fromJson(
    Map<String, dynamic> json,
  ) => _$OrderCreateRequestItemsInnerItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderCreateRequestItemsInnerItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
