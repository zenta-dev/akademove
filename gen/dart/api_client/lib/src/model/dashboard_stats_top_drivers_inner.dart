//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_stats_top_drivers_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardStatsTopDriversInner {
  /// Returns a new [DashboardStatsTopDriversInner] instance.
  const DashboardStatsTopDriversInner({
    required this.id,
    required this.name,
    required this.earnings,
    required this.orders,
    required this.rating,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'earnings', required: true, includeIfNull: false)
  final num earnings;

  @JsonKey(name: r'orders', required: true, includeIfNull: false)
  final num orders;

  @JsonKey(name: r'rating', required: true, includeIfNull: false)
  final num rating;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardStatsTopDriversInner &&
          other.id == id &&
          other.name == name &&
          other.earnings == earnings &&
          other.orders == orders &&
          other.rating == rating;

  @override
  int get hashCode =>
      id.hashCode +
      name.hashCode +
      earnings.hashCode +
      orders.hashCode +
      rating.hashCode;

  factory DashboardStatsTopDriversInner.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsTopDriversInnerFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatsTopDriversInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
