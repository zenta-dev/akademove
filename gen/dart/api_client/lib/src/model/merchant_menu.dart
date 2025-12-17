//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_menu.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantMenu {
  /// Returns a new [MerchantMenu] instance.
  const MerchantMenu({
    required this.id,
    required this.merchantId,
    required this.name,
    this.image,
    this.category,
    this.categoryId,
    required this.price,
    required this.stock,
    required this.soldStock,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'image', required: false, includeIfNull: false)
  final String? image;

  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final String? category;

  /// Reference to merchant menu category
  @JsonKey(name: r'categoryId', required: false, includeIfNull: false)
  final String? categoryId;

  // minimum: 0
  @JsonKey(name: r'price', required: true, includeIfNull: false)
  final num price;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'stock', required: true, includeIfNull: false)
  final int stock;

  /// Total number of items sold
  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'soldStock', required: true, includeIfNull: false)
  final int soldStock;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantMenu &&
          other.id == id &&
          other.merchantId == merchantId &&
          other.name == name &&
          other.image == image &&
          other.category == category &&
          other.categoryId == categoryId &&
          other.price == price &&
          other.stock == stock &&
          other.soldStock == soldStock &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      merchantId.hashCode +
      name.hashCode +
      (image == null ? 0 : image.hashCode) +
      category.hashCode +
      categoryId.hashCode +
      price.hashCode +
      stock.hashCode +
      soldStock.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory MerchantMenu.fromJson(Map<String, dynamic> json) =>
      _$MerchantMenuFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantMenuToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
