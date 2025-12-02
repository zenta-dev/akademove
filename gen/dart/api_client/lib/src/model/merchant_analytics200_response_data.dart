//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant_analytics200_response_data_top_selling_items_inner.dart';
import 'package:api_client/src/model/merchant_analytics200_response_data_revenue_by_day_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_analytics200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantAnalytics200ResponseData {
  /// Returns a new [MerchantAnalytics200ResponseData] instance.
  const MerchantAnalytics200ResponseData({
    required this.totalOrders,
    required this.totalRevenue,
    required this.totalCommission,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.averageOrderValue,
    required this.topSellingItems,
    required this.revenueByDay,
  });

  @JsonKey(name: r'totalOrders', required: true, includeIfNull: false)
  final num totalOrders;
  
  @JsonKey(name: r'totalRevenue', required: true, includeIfNull: false)
  final num totalRevenue;
  
  @JsonKey(name: r'totalCommission', required: true, includeIfNull: false)
  final num totalCommission;
  
  @JsonKey(name: r'completedOrders', required: true, includeIfNull: false)
  final num completedOrders;
  
  @JsonKey(name: r'cancelledOrders', required: true, includeIfNull: false)
  final num cancelledOrders;
  
  @JsonKey(name: r'averageOrderValue', required: true, includeIfNull: false)
  final num averageOrderValue;
  
  @JsonKey(name: r'topSellingItems', required: true, includeIfNull: false)
  final List<MerchantAnalytics200ResponseDataTopSellingItemsInner> topSellingItems;
  
  @JsonKey(name: r'revenueByDay', required: true, includeIfNull: false)
  final List<MerchantAnalytics200ResponseDataRevenueByDayInner> revenueByDay;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantAnalytics200ResponseData &&
    other.totalOrders == totalOrders &&
    other.totalRevenue == totalRevenue &&
    other.totalCommission == totalCommission &&
    other.completedOrders == completedOrders &&
    other.cancelledOrders == cancelledOrders &&
    other.averageOrderValue == averageOrderValue &&
    other.topSellingItems == topSellingItems &&
    other.revenueByDay == revenueByDay;

  @override
  int get hashCode =>
      totalOrders.hashCode +
      totalRevenue.hashCode +
      totalCommission.hashCode +
      completedOrders.hashCode +
      cancelledOrders.hashCode +
      averageOrderValue.hashCode +
      topSellingItems.hashCode +
      revenueByDay.hashCode;

  factory MerchantAnalytics200ResponseData.fromJson(Map<String, dynamic> json) => _$MerchantAnalytics200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantAnalytics200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

