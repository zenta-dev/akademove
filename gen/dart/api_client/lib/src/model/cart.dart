//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/cart_item.dart';
import 'package:api_client/src/model/merchant_category.dart';
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
    this.merchantLocation,
    this.merchantCategory,
    required this.items,
    required this.totalItems,
    required this.subtotal,
    this.attachmentUrl,
    required this.lastUpdated,
  });
  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;

  @JsonKey(name: r'merchantName', required: true, includeIfNull: false)
  final String merchantName;

  @JsonKey(name: r'merchantLocation', required: false, includeIfNull: false)
  final Coordinate? merchantLocation;

  @JsonKey(name: r'merchantCategory', required: false, includeIfNull: false)
  final MerchantCategory? merchantCategory;

  @JsonKey(name: r'items', required: true, includeIfNull: false)
  final List<CartItem> items;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'totalItems', required: true, includeIfNull: false)
  final int totalItems;

  @JsonKey(name: r'subtotal', required: true, includeIfNull: false)
  final num subtotal;

  @JsonKey(name: r'attachmentUrl', required: false, includeIfNull: false)
  final String? attachmentUrl;

  @JsonKey(name: r'lastUpdated', required: true, includeIfNull: true)
  final DateTime? lastUpdated;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cart &&
          other.merchantId == merchantId &&
          other.merchantName == merchantName &&
          other.merchantLocation == merchantLocation &&
          other.merchantCategory == merchantCategory &&
          other.items == items &&
          other.totalItems == totalItems &&
          other.subtotal == subtotal &&
          other.attachmentUrl == attachmentUrl &&
          other.lastUpdated == lastUpdated;

  @override
  int get hashCode =>
      merchantId.hashCode +
      merchantName.hashCode +
      merchantLocation.hashCode +
      merchantCategory.hashCode +
      items.hashCode +
      totalItems.hashCode +
      subtotal.hashCode +
      (attachmentUrl == null ? 0 : attachmentUrl.hashCode) +
      (lastUpdated == null ? 0 : lastUpdated.hashCode);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
