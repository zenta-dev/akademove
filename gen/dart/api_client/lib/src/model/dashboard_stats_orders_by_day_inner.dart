//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'dashboard_stats_orders_by_day_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DashboardStatsOrdersByDayInner {
  /// Returns a new [DashboardStatsOrdersByDayInner] instance.
  const DashboardStatsOrdersByDayInner({
    required this.date,
    required this.total,
    required this.completed,
    required this.cancelled,
  });

  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'total', required: true, includeIfNull: false)
  final num total;

  @JsonKey(name: r'completed', required: true, includeIfNull: false)
  final num completed;

  @JsonKey(name: r'cancelled', required: true, includeIfNull: false)
  final num cancelled;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardStatsOrdersByDayInner &&
          other.date == date &&
          other.total == total &&
          other.completed == completed &&
          other.cancelled == cancelled;

  @override
  int get hashCode =>
      date.hashCode + total.hashCode + completed.hashCode + cancelled.hashCode;

  factory DashboardStatsOrdersByDayInner.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsOrdersByDayInnerFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatsOrdersByDayInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
