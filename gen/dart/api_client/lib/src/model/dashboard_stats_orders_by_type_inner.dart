//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_stats_orders_by_type_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardStatsOrdersByTypeInner {
  /// Returns a new [DashboardStatsOrdersByTypeInner] instance.
  const DashboardStatsOrdersByTypeInner({
    required this.type,
    required this.orders,
    required this.revenue,
  });

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final String type;

  @JsonKey(name: r'orders', required: true, includeIfNull: false)
  final num orders;

  @JsonKey(name: r'revenue', required: true, includeIfNull: false)
  final num revenue;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardStatsOrdersByTypeInner &&
          other.type == type &&
          other.orders == orders &&
          other.revenue == revenue;

  @override
  int get hashCode => type.hashCode + orders.hashCode + revenue.hashCode;

  factory DashboardStatsOrdersByTypeInner.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsOrdersByTypeInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardStatsOrdersByTypeInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
