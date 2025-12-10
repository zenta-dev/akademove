//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_stats_revenue_by_day_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardStatsRevenueByDayInner {
  /// Returns a new [DashboardStatsRevenueByDayInner] instance.
  const DashboardStatsRevenueByDayInner({
    required this.date,
    required this.revenue,
    required this.orders,
  });
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'revenue', required: true, includeIfNull: false)
  final num revenue;

  @JsonKey(name: r'orders', required: true, includeIfNull: false)
  final num orders;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardStatsRevenueByDayInner &&
          other.date == date &&
          other.revenue == revenue &&
          other.orders == orders;

  @override
  int get hashCode => date.hashCode + revenue.hashCode + orders.hashCode;

  factory DashboardStatsRevenueByDayInner.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsRevenueByDayInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardStatsRevenueByDayInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
