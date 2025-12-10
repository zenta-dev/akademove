//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_analytics200_response_data_top_selling_items_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantAnalytics200ResponseDataTopSellingItemsInner {
  /// Returns a new [MerchantAnalytics200ResponseDataTopSellingItemsInner] instance.
  const MerchantAnalytics200ResponseDataTopSellingItemsInner({
    required this.menuId,
    required this.menuName,
     this.menuImage,
    required this.totalOrders,
    required this.totalRevenue,
  });
  @JsonKey(name: r'menuId', required: true, includeIfNull: true)
  final String? menuId;
  
  @JsonKey(name: r'menuName', required: true, includeIfNull: true)
  final String? menuName;
  
  @JsonKey(name: r'menuImage', required: false, includeIfNull: false)
  final String? menuImage;
  
  @JsonKey(name: r'totalOrders', required: true, includeIfNull: false)
  final num totalOrders;
  
  @JsonKey(name: r'totalRevenue', required: true, includeIfNull: false)
  final num totalRevenue;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantAnalytics200ResponseDataTopSellingItemsInner &&
    other.menuId == menuId &&
    other.menuName == menuName &&
    other.menuImage == menuImage &&
    other.totalOrders == totalOrders &&
    other.totalRevenue == totalRevenue;

  @override
  int get hashCode =>
      (menuId == null ? 0 : menuId.hashCode) +
      (menuName == null ? 0 : menuName.hashCode) +
      (menuImage == null ? 0 : menuImage.hashCode) +
      totalOrders.hashCode +
      totalRevenue.hashCode;

  factory MerchantAnalytics200ResponseDataTopSellingItemsInner.fromJson(Map<String, dynamic> json) => _$MerchantAnalytics200ResponseDataTopSellingItemsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantAnalytics200ResponseDataTopSellingItemsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

