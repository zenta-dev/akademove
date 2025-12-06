//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_stats_top_merchants_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardStatsTopMerchantsInner {
  /// Returns a new [DashboardStatsTopMerchantsInner] instance.
  const DashboardStatsTopMerchantsInner({
    required this.id,
    required this.name,
    required this.revenue,
    required this.orders,
    required this.rating,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'revenue', required: true, includeIfNull: false)
  final num revenue;

  @JsonKey(name: r'orders', required: true, includeIfNull: false)
  final num orders;

  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final num rating;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardStatsTopMerchantsInner &&
          other.id == id &&
          other.name == name &&
          other.revenue == revenue &&
          other.orders == orders &&
          other.rating == rating;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      revenue.hashCode +
      orders.hashCode +
      rating.hashCode;

  factory DashboardStatsTopMerchantsInner.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsTopMerchantsInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardStatsTopMerchantsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
