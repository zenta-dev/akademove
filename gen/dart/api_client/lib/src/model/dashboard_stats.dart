//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/dashboard_stats_orders_by_day_inner.dart';
import 'package:api_client/src/model/dashboard_stats_top_drivers_inner.dart';
import 'package:api_client/src/model/dashboard_stats_high_cancellation_drivers_inner.dart';
import 'package:api_client/src/model/merchant_analytics200_response_data_revenue_by_day_inner.dart';
import 'package:api_client/src/model/dashboard_stats_orders_by_type_inner.dart';
import 'package:api_client/src/model/dashboard_stats_top_merchants_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_stats.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardStats {
  /// Returns a new [DashboardStats] instance.
  const DashboardStats({
    required this.totalUsers,
    required this.totalDrivers,
    required this.totalMerchants,
    required this.activeOrders,
    required this.totalOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.totalRevenue,
    required this.todayRevenue,
    required this.todayOrders,
    required this.onlineDrivers,
    required this.revenueByDay,
    required this.ordersByDay,
    required this.ordersByType,
    required this.topDrivers,
    required this.topMerchants,
    required this.highCancellationDrivers,
  });

  @JsonKey(name: r'totalUsers', required: true, includeIfNull: false)
  final num totalUsers;

  @JsonKey(name: r'totalDrivers', required: true, includeIfNull: false)
  final num totalDrivers;

  @JsonKey(name: r'totalMerchants', required: true, includeIfNull: false)
  final num totalMerchants;

  @JsonKey(name: r'activeOrders', required: true, includeIfNull: false)
  final num activeOrders;

  @JsonKey(name: r'totalOrders', required: true, includeIfNull: false)
  final num totalOrders;

  @JsonKey(name: r'completedOrders', required: true, includeIfNull: false)
  final num completedOrders;

  @JsonKey(name: r'cancelledOrders', required: true, includeIfNull: false)
  final num cancelledOrders;

  @JsonKey(name: r'totalRevenue', required: true, includeIfNull: false)
  final num totalRevenue;

  @JsonKey(name: r'todayRevenue', required: true, includeIfNull: false)
  final num todayRevenue;

  @JsonKey(name: r'todayOrders', required: true, includeIfNull: false)
  final num todayOrders;

  @JsonKey(name: r'onlineDrivers', required: true, includeIfNull: false)
  final num onlineDrivers;

  @JsonKey(name: r'revenueByDay', required: true, includeIfNull: false)
  final List<MerchantAnalytics200ResponseDataRevenueByDayInner> revenueByDay;

  @JsonKey(name: r'ordersByDay', required: true, includeIfNull: false)
  final List<DashboardStatsOrdersByDayInner> ordersByDay;

  @JsonKey(name: r'ordersByType', required: true, includeIfNull: false)
  final List<DashboardStatsOrdersByTypeInner> ordersByType;

  @JsonKey(name: r'topDrivers', required: true, includeIfNull: false)
  final List<DashboardStatsTopDriversInner> topDrivers;

  @JsonKey(name: r'topMerchants', required: true, includeIfNull: false)
  final List<DashboardStatsTopMerchantsInner> topMerchants;

  @JsonKey(
    name: r'highCancellationDrivers',
    required: true,
    includeIfNull: false,
  )
  final List<DashboardStatsHighCancellationDriversInner>
  highCancellationDrivers;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardStats &&
          other.totalUsers == totalUsers &&
          other.totalDrivers == totalDrivers &&
          other.totalMerchants == totalMerchants &&
          other.activeOrders == activeOrders &&
          other.totalOrders == totalOrders &&
          other.completedOrders == completedOrders &&
          other.cancelledOrders == cancelledOrders &&
          other.totalRevenue == totalRevenue &&
          other.todayRevenue == todayRevenue &&
          other.todayOrders == todayOrders &&
          other.onlineDrivers == onlineDrivers &&
          other.revenueByDay == revenueByDay &&
          other.ordersByDay == ordersByDay &&
          other.ordersByType == ordersByType &&
          other.topDrivers == topDrivers &&
          other.topMerchants == topMerchants &&
          other.highCancellationDrivers == highCancellationDrivers;

  @override
  int get hashCode =>
      totalUsers.hashCode +
      totalDrivers.hashCode +
      totalMerchants.hashCode +
      activeOrders.hashCode +
      totalOrders.hashCode +
      completedOrders.hashCode +
      cancelledOrders.hashCode +
      totalRevenue.hashCode +
      todayRevenue.hashCode +
      todayOrders.hashCode +
      onlineDrivers.hashCode +
      revenueByDay.hashCode +
      ordersByDay.hashCode +
      ordersByType.hashCode +
      topDrivers.hashCode +
      topMerchants.hashCode +
      highCancellationDrivers.hashCode;

  factory DashboardStats.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
