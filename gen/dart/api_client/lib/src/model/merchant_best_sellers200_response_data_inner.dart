//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant_best_sellers200_response_data_inner_menu.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response_data_inner_merchant.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_best_sellers200_response_data_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantBestSellers200ResponseDataInner {
  /// Returns a new [MerchantBestSellers200ResponseDataInner] instance.
  const MerchantBestSellers200ResponseDataInner({
    required this.menu,
    required this.merchant,
    required this.orderCount,
  });
  @JsonKey(name: r'menu', required: true, includeIfNull: false)
  final MerchantBestSellers200ResponseDataInnerMenu menu;

  @JsonKey(name: r'merchant', required: true, includeIfNull: false)
  final MerchantBestSellers200ResponseDataInnerMerchant merchant;

  @JsonKey(name: r'orderCount', required: true, includeIfNull: false)
  final num orderCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantBestSellers200ResponseDataInner &&
          other.menu == menu &&
          other.merchant == merchant &&
          other.orderCount == orderCount;

  @override
  int get hashCode => menu.hashCode + merchant.hashCode + orderCount.hashCode;

  factory MerchantBestSellers200ResponseDataInner.fromJson(
    Map<String, dynamic> json,
  ) => _$MerchantBestSellers200ResponseDataInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MerchantBestSellers200ResponseDataInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
