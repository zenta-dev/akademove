import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantAnalyticsState extends Equatable {
  const MerchantAnalyticsState({
    this.analytics = const OperationResult.idle(),
    this.exportResult = const OperationResult.idle(),
  });

  /// Analytics data from getAnalytics API
  final OperationResult<MerchantAnalytics200ResponseData> analytics;

  /// Result of exportAnalytics operation (returns export URL/path)
  final OperationResult<String> exportResult;

  @override
  List<Object> get props => [analytics, exportResult];

  MerchantAnalyticsState copyWith({
    OperationResult<MerchantAnalytics200ResponseData>? analytics,
    OperationResult<String>? exportResult,
  }) {
    return MerchantAnalyticsState(
      analytics: analytics ?? this.analytics,
      exportResult: exportResult ?? this.exportResult,
    );
  }

  // ========== HELPER GETTERS ==========

  /// Total orders from analytics data
  num get totalOrders => analytics.value?.totalOrders ?? 0;

  /// Total revenue from analytics data
  num get totalRevenue => analytics.value?.totalRevenue ?? 0;

  /// Total commission from analytics data
  num get totalCommission => analytics.value?.totalCommission ?? 0;

  /// Commission rate as percentage (e.g., 10 for 10%) - from server config
  num get commissionRate => analytics.value?.commissionRate ?? 0;

  /// Net income after commission deduction - from server
  num get netIncome => analytics.value?.netIncome ?? 0;

  /// Completed orders count
  num get completedOrders => analytics.value?.completedOrders ?? 0;

  /// Cancelled orders count
  num get cancelledOrders => analytics.value?.cancelledOrders ?? 0;

  /// Average order value
  num get averageOrderValue => analytics.value?.averageOrderValue ?? 0;

  /// Top selling items list
  List<MerchantAnalytics200ResponseDataTopSellingItemsInner>
  get topSellingItems => analytics.value?.topSellingItems ?? [];

  /// Revenue by day data for charts
  List<MerchantAnalytics200ResponseDataRevenueByDayInner> get revenueByDay =>
      analytics.value?.revenueByDay ?? [];

  @override
  bool get stringify => true;
}
