//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_best_sellers200_response_data_inner_menu.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantBestSellers200ResponseDataInnerMenu {
  /// Returns a new [MerchantBestSellers200ResponseDataInnerMenu] instance.
  const MerchantBestSellers200ResponseDataInnerMenu({
    required this.id,
    required this.merchantId,
    required this.name,
     this.image,
     this.category,
    required this.price,
    required this.stock,
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
  
  @JsonKey(name: r'price', required: true, includeIfNull: false)
  final num price;
  
  @JsonKey(name: r'stock', required: true, includeIfNull: false)
  final num stock;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantBestSellers200ResponseDataInnerMenu &&
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

  factory MerchantBestSellers200ResponseDataInnerMenu.fromJson(Map<String, dynamic> json) => _$MerchantBestSellers200ResponseDataInnerMenuFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantBestSellers200ResponseDataInnerMenuToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

